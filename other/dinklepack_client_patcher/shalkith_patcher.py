import os
import hashlib
#import wget
import json
import requests
import sys 
import subprocess

# for each patch check if it exists, if not download it
# if it exists, check if the checksum is correct
# if the checksum is correct, print 'checksum correct'
# if the checksum is incorrect, download the patch
# this could in theroy replace download_client_part_2_dropbox in the current Launcher.bat file
#os.chdir(os.path.dirname(os.path.abspath(__file__)))
#create folder _Client\Data if it doesnt exist
if not os.path.exists('_Client\Data'):
    os.makedirs('_Client\Data')

download_log = []

def get_latest_patch_list():
    #get the latest patch list from the server
    #check and see if args were passed, if so use arg 1 as branch

    if len(sys.argv) > 1:
        branch = sys.argv[1]
        url = 'https://raw.githubusercontent.com/Shalkith/dinklepack_client_patcher/{}/patch_list.json'.format(branch)
    else:
        url = 'https://raw.githubusercontent.com/Shalkith/dinklepack_client_patcher/main/patch_list.json'

    r = requests.get(url)
    with open('patch_list.json', 'wb') as f:
        f.write(r.content)

def clear():
    os.system('cls' if os.name=='nt' else 'clear')
    pass

def remove_temp_files():
    #rempve all files in the _Client\Data folder that end with .tmp
    for file in os.listdir('_Client\Data'):
        if file.endswith('.tmp'):
            os.remove('_Client\Data\\'+file)
            download_log.append('Deleted '+file)


def get_checksum(file):
    with open(file, "rb") as f:
        file_hash = hashlib.md5()
        while chunk := f.read(8192):
            file_hash.update(chunk)

    return file_hash.hexdigest()  # to get a printable str instead of bytes
  
def download_patch(patch,url=1):
    # using the wget.exe file to download the patch like the current launcher.bat file does
    # for example: _Tools\wget.exe -k --no-check-certificate --show-progress --content-disposition --directory-prefix=.\_Client\Data\ -c "https://www.dropbox.com/sh/7wto7lnj635qjws/AAC_-aNGG-swSXJZ-uFg1M46a/patch-8.mpq"
    if url == 1:
        url = patch['downloadurl_1']
    elif url == 2:
        url = patch['downloadurl_2'].replace('229:8000','190:8000')
    else:
        print('Invalid URL')
        input()
        return '404'
    filename = patch['filename']
    #os.system('_Tools\wget.exe -k --no-check-certificate --show-progress --content-disposition --directory-prefix=.\_Client\Data\ -c "{}"'.format(url))
    command = '_Tools\wget.exe -k --no-check-certificate --show-progress --content-disposition --directory-prefix=.\_Client\Data\ -c "{}"'.format(url)
    result = subprocess.check_output(command)
    if 'ERROR 404: Not Found' in result:
        return '404'
    else: 
        return '200'

def print_program_banner():
    remove_temp_files()
    clear()
    # Dinkledork Patch Downloader
    print('''
      ____  _       __   __     ____             __  
     / __ \(_)___  / /__/ /__  / __ \____  _____/ /__
    / / / / / __ \/ //_/ / _ \/ /_/ / __ `/ ___/ //_/
   / /_/ / / / / / ,( / /  __/ ____/ /_/ / /__/ ,(   
  /_____/_/_/ /_/_/\_/_/\___/_/    \__,_/\___/_/\_\  v13.0
   Dinkledork @ https://www.patreon.com/Dinklepack5
''')
 # print('Dinkledork Patch Downloader')
    print('By Shalkith')

def announcement():
    print('''
__________________________Downloading Dinklepack Client Patches__________________________

If you get any "unspecified" files when downloading, then try again after 24 hours, as 
the links get disabled for 24 hours by Dropbox when they reach a certain unknown limit.

If it still doesn't work, after waiting, then something on your PC is preventing the 
launcher from downloading the files and I can't do anything about that, unfortunately.''')

def del_file(filename):
    try:
        os.remove(filename)
    except:
        print('Error deleting file: {}'.format(filename))

def check_patch(patch):
    filename = patch['filename']
    checksum = patch['checksum']
    if os.path.exists('_Client\Data\\'+filename):
        print('file exists, checking checksum...')
        if checksum == get_checksum('_Client\Data\\'+filename):
            print('Checksum correct - File is good to go!')
            download_log.append(filename+' was already up to date')
        else:
            print('Checksum incorrect - downloading new file...')
            del_file('_Client\Data\\'+filename)
            try:
                if len(sys.argv) > 2:
                    log = download_patch(patch,sys.argv[2])
                else:
                    log = download_patch(patch)

                log = download_patch(patch)
                if log == '404':
                    download_log.append(filename+' had an invalid checksum - we tried to download it but it wasnt found. Please try again in 24 hours')
                else: 
                    download_log.append(filename+' had an invalid checksum so we downloaded a new file')
                
            except Exception as e:
                print('Error downloading file: {}'.format(e))
                download_log.append(filename+' had an invalid checksum - we tried to download it but there was a problem. Please try again in 24 hours')
                input('Press Enter to exit' )
    else:
        print('File does not exist - downloading...')
        try:
            if len(sys.argv) > 2:
                log = download_patch(patch,sys.argv[2])
            else:
                log = download_patch(patch)
            if log == '404':
                download_log.append(filename+' didnt exist - we tried to download it but it wasnt found. Please try again in 24 hours')
            else: 
                download_log.append(filename+' didnt exist so we downloaded it')
        except Exception as e:
            print('Error downloading file: {}'.format(e))
            download_log.append(filename+' didnt exist - we tried to download it but there was a problem. Please try again in 24 hours')
            input('Press Enter to exit' )
        

def main():
    get_latest_patch_list()
    jsonfilename = 'patch_list.json'

    with open(jsonfilename, 'r') as f:
        data = json.load(f)

    for key in data:
        #if downloadurl_1 is empty, skip the patch
        if data[key]['downloadurl_1'] == '':
            continue
        print_program_banner()
        announcement()
        print()
        print(data[key]['filename'])
        check_patch(data[key])
        print('')
        clear()

    print('All patches checked and downloaded if needed')
    print('Here\'s what we did:')
    for row in download_log:
        print(row)

if __name__ == '__main__':

    main()
    input('Press Enter to exit')
    clear()
    os.remove('patch_list.json')
    exit()