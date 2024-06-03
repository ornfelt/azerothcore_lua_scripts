from typing import List
from urllib.parse import urlparse

from acore_soap_app.agent.impl import SOAPRequest


class EmailItem:
    def __init__(self, item_id: int, count: int = 1):
        self.item_id = item_id
        self.count = count

    def __str__(self):
        if self.count > 1:
            return f"{self.item_id}:{self.count}"
        return str(self.item_id)


class SoapClient:
    def __init__(
            self,
            hostname: str,
            username: str,
            password: str,
    ):
        self.hostname = urlparse(hostname).hostname
        self.port = urlparse(hostname).port
        self.username = username
        self.password = password

    def send_items(self, player_name: str, subject: str, message: str, items: List[EmailItem]):
        # .send items #playername "#subject" "#text" itemid1[:count1] itemid2[:count2] ... itemidN[:countN]
        items_per_chunk = 12
        items_chunks = [items[i:i + items_per_chunk] for i in range(0, len(items), items_per_chunk)]

        for chunk in items_chunks:
            item_list = " ".join(str(item) for item in chunk)
            command = f".send items {player_name} \"{subject}\" \"{message}\" {item_list}"
            print(command)

            response = SOAPRequest(username=self.username, password=self.password, host=self.hostname, port=self.port,
                                   command=command).send()
            if not response.succeeded:
                raise ValueError(response.message)
