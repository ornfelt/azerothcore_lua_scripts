import os

import requests
from bs4 import BeautifulSoup
import re
import json
from flask import Flask, jsonify, make_response
from flask_cors import CORS

from soap import SoapClient, EmailItem

app = Flask(__name__)
CORS(app)


@app.route("/", methods=['GET'])
def health_check():
    return jsonify({"status": "OK", "code": 200}), 200


@app.route("/add/gear-set/wowhead/<player_name>/<set_name>", methods=['GET'])
def send_gear_by_build(player_name: str, set_name: str):
    url = f"https://www.wowhead.com/classic/gear-set/{set_name}"

    response = requests.get(url)
    soup = BeautifulSoup(response.text, 'html.parser')
    pattern = re.compile(r'state: (.*?),$')

    scripts = soup.find_all('script')

    items_and_enchants = None

    for script in scripts:
        for line in str(script).splitlines():
            match = pattern.search(line)
            if match:
                json_data = json.loads(match.group(1))
                items_and_enchants = json_data.get('slots')

    if not items_and_enchants:
        raise ValueError('items_and_enchants not found')

    email_items = []
    for item in items_and_enchants:
        item_id = items_and_enchants.get(str(item), {}).get('item')
        email_items.append(EmailItem(item_id))

        gems = items_and_enchants.get(str(item), {}).get('gems', {})
        for index in gems:
            email_items.append(EmailItem(gems[index]))

    if len(email_items) > 0:
        gm = SoapClient(os.environ.get('AZEROTHCORE_REMOTE_ADDRESS'), os.environ.get('GM_USERNAME'), os.environ.get('GM_PASSWORD'))
        gm.send_items(player_name, 'Tienes un paquete de WoWHead', 'Disfrutalo', email_items)
        return make_response('{}', 201)

    return make_response('', 204)


if __name__ == '__main__':
    config = {
        'host': '0.0.0.0',
        'port': 1337,
        'debug': True
    }

    app.run(**config)

