#this file is usually only needed to get the programs up and running 
#it's not needed for the end user

import hashlib
import sys
import json
import os



def json_builder():
    # run once to build the json file if needed 


    patches = [
    ['Patch-6.mpq','https://www.dropbox.com/scl/fo/r8t7fje9j02nr2mqlki00/h/Patch-6.mpq?rlkey=09m2mcbwvejsjyn42nz9zqx63'],
    ['Patch-7.mpq','https://www.dropbox.com/scl/fo/r8t7fje9j02nr2mqlki00/h/Patch-7.mpq?rlkey=09m2mcbwvejsjyn42nz9zqx63'],
    ['patch-8.mpq','https://www.dropbox.com/scl/fo/r8t7fje9j02nr2mqlki00/h/patch-8.mpq?rlkey=09m2mcbwvejsjyn42nz9zqx63'],
    ['patch-A.mpq','https://www.dropbox.com/scl/fo/r8t7fje9j02nr2mqlki00/h/patch-A.mpq?rlkey=09m2mcbwvejsjyn42nz9zqx63'],
    ['patch-B.mpq','https://www.dropbox.com/scl/fo/r8t7fje9j02nr2mqlki00/h/patch-B.mpq?rlkey=09m2mcbwvejsjyn42nz9zqx63'],
    ['Patch-D.mpq','https://www.dropbox.com/scl/fo/r8t7fje9j02nr2mqlki00/h/Patch-D.mpq?rlkey=09m2mcbwvejsjyn42nz9zqx63'],
    ['patch-E.mpq','https://www.dropbox.com/scl/fo/r8t7fje9j02nr2mqlki00/h/patch-E.mpq?rlkey=09m2mcbwvejsjyn42nz9zqx63'],
    ['patch-G.mpq','https://www.dropbox.com/scl/fo/r8t7fje9j02nr2mqlki00/h/patch-G.mpq?rlkey=09m2mcbwvejsjyn42nz9zqx63'],
    ['patch-H.mpq','https://www.dropbox.com/scl/fo/r8t7fje9j02nr2mqlki00/h/patch-H.mpq?rlkey=09m2mcbwvejsjyn42nz9zqx63'],
    ['Patch-I.mpq','https://www.dropbox.com/scl/fo/r8t7fje9j02nr2mqlki00/h/Patch-I.mpq?rlkey=09m2mcbwvejsjyn42nz9zqx63'],
    ['patch-J.mpq','https://www.dropbox.com/scl/fo/r8t7fje9j02nr2mqlki00/h/patch-J.mpq?rlkey=09m2mcbwvejsjyn42nz9zqx63'],
    ['patch-K.mpq','https://www.dropbox.com/scl/fo/r8t7fje9j02nr2mqlki00/h/patch-K.mpq?rlkey=09m2mcbwvejsjyn42nz9zqx63'],
    ['patch-M.mpq','https://www.dropbox.com/scl/fo/r8t7fje9j02nr2mqlki00/h/patch-M.mpq?rlkey=09m2mcbwvejsjyn42nz9zqx63'],
    ['Patch-Q.mpq','https://www.dropbox.com/scl/fo/r8t7fje9j02nr2mqlki00/h/Patch-Q.mpq?rlkey=09m2mcbwvejsjyn42nz9zqx63'],
    ['Patch-R.mpq','https://www.dropbox.com/scl/fo/r8t7fje9j02nr2mqlki00/h/Patch-R.mpq?rlkey=09m2mcbwvejsjyn42nz9zqx63'],
    ['Patch-S.mpq','https://www.dropbox.com/scl/fo/r8t7fje9j02nr2mqlki00/h/Patch-S.mpq?rlkey=09m2mcbwvejsjyn42nz9zqx63'],
    ['Patch-T.mpq','https://www.dropbox.com/scl/fo/r8t7fje9j02nr2mqlki00/h/Patch-T.mpq?rlkey=09m2mcbwvejsjyn42nz9zqx63'],
    ['Patch-U.mpq','https://www.dropbox.com/scl/fo/r8t7fje9j02nr2mqlki00/h/Patch-U.mpq?rlkey=09m2mcbwvejsjyn42nz9zqx63'],
    ['patch-V.mpq','https://www.dropbox.com/scl/fo/r8t7fje9j02nr2mqlki00/h/patch-V.mpq?rlkey=09m2mcbwvejsjyn42nz9zqx63'],
    ['Patch-W.mpq','https://www.dropbox.com/scl/fo/r8t7fje9j02nr2mqlki00/h/Patch-W.mpq?rlkey=09m2mcbwvejsjyn42nz9zqx63'],
    ['patch-X.mpq','https://www.dropbox.com/scl/fo/r8t7fje9j02nr2mqlki00/h/patch-X.mpq?rlkey=09m2mcbwvejsjyn42nz9zqx63'],
    ['Patch-Y.mpq','https://www.dropbox.com/scl/fo/r8t7fje9j02nr2mqlki00/h/Patch-Y.mpq?rlkey=09m2mcbwvejsjyn42nz9zqx63'],
    ['patch-Z.mpq','https://www.dropbox.com/scl/fo/r8t7fje9j02nr2mqlki00/h/patch-Z.mpq?rlkey=09m2mcbwvejsjyn42nz9zqx63'],
    ['patch-8.mpq','https://www.dropbox.com/sh/7wto7lnj635qjws/AAC_-aNGG-swSXJZ-uFg1M46a/patch-8.mpq'],
    ['Patch-D.mpq','https://www.dropbox.com/sh/7wto7lnj635qjws/AACxknWGv-uZECqyn2Pf7KXAa/Patch-D.mpq'],
    ['patch-H.mpq','https://www.dropbox.com/sh/7wto7lnj635qjws/AACjkydKYg5In11ml1b8IHELa/patch-H.mpq'],
    ['Patch-I.mpq','https://www.dropbox.com/sh/7wto7lnj635qjws/AAC5QFsuZAa32FAg9seo8xUOa/Patch-I.mpq'],
    ['patch-M.mpq','https://www.dropbox.com/sh/7wto7lnj635qjws/AAAYSMiyd9Y5H-VpzDWd9-b8a/patch-M.mpq'],
    ['Patch-S.mpq','https://www.dropbox.com/sh/7wto7lnj635qjws/AACNyDRSs2uJmZou6Z4Pt5Loa/Patch-S.mpq'],
    ['Patch-U.mpq','https://www.dropbox.com/sh/7wto7lnj635qjws/AABj0VDK0ZIOHCQrl6-TvBuNa/Patch-U.mpq'],
    ['Patch-W.mpq','https://www.dropbox.com/sh/7wto7lnj635qjws/AACrLaHLmpvi3L_uJjbR-ICTa/Patch-W.mpq'],
    ['Patch-Y.mpq','https://www.dropbox.com/sh/7wto7lnj635qjws/AACQwlWE-KD-n3eN_ePL6NdIa/Patch-Y.mpq'],
    ['OptionalEyeglow-Helf-and-Belf.zip','https://www.dropbox.com/sh/7wto7lnj635qjws/AADE5iGsI2y6E8d3olxb_qwOa/OptionalEyeglow-Helf-and-Belf.zip']
    ]

    jsonfile = {}


    for file in patches:
        #append to the dict
        jsonfile[file[0]]={"filename":file[0],
            "downloadurl_1":file[1],
            "downloadurl_2":"\\192.168.1.190\my_share\wow_server\_Client\Data\{}".format(file[0]),
            "checksum":""}
        
    # save the json to a file
    with open('patch_list.json', 'w') as f:
        f.write(json.dumps(jsonfile, indent=4))

        

def gather_checksums(file):
    #pass in the json file name 
    # eg gather_checksums('patch_list.json')
    # read the file  , get its checksum, and print to console
    os.chdir(os.path.dirname(os.path.abspath(__file__)))
    def get_checksum(file):
        with open(file, "rb") as f:
            file_hash = hashlib.md5()
            while chunk := f.read(8192):
                file_hash.update(chunk)

        #print(file_hash.digest())
        print(file_hash.hexdigest())  # to get a printable str instead of bytes
    jsonfilename = file
    with open(jsonfilename, 'r') as f:
        data = json.load(f)

    for key in data:
        print(key)
        print(data[key]['filename'])
        get_checksum(data[key]['downloadurl_2'].replace('\\','\\\\')) # use the local path of the file if available for quicker checksum
        print('')
    #get_checksum(r'\\192.168.1.190\my_share\wow_server\_Client\Data\patch.MPQ')       

def build_exe(python_script):
    #using pyinstaller to build the exe
    # used to turn shalkith_patcher.py into an exe
    # eg build_exe('shalkith_patcher.py')
    os.system('pyinstaller --onefile {}'.format(python_script))


def main():
    os.chdir(os.path.dirname(os.path.abspath(__file__)))
    #json_builder()
    #gather_checksums('patch_list.json')
    build_exe('shalkith_patcher.py')
    #move the exe to the _Tools folder
    os.rename('dist\shalkith_patcher.exe','_Tools\shalkith_patcher.exe')


def get_checksum(file):
    with open(file, "rb") as f:
        file_hash = hashlib.md5()
        while chunk := f.read(8192):
            file_hash.update(chunk)
    print(file_hash.hexdigest())
    return file_hash.hexdigest()  # to get a printable str instead of bytes


def new_json_builder(filepath):
    # for each file in the folder ask if it should be added to the json file, if so, generate the checksum an add it

    # get the list of files in the folder
    files = os.listdir(filepath)
    #print(files)
    # load the json file
    jsonfile = {}
    with open('patch_list.json', 'r') as f:
        data = json.load(f)
    #print(data)
    # for each file in the folder
    for file in files:
        # ask if the file should be added to the json file
        #print('Add {} to the json file? y/n'.format(file))
        #response = input()
        if file.lower().endswith('.mpq') or file.lower().endswith('.zip'):
            response = 'y'
        else:
            response = 'n'
        if response == 'y':
            # add the file to the json file
            # if the file is not already in the json file, add it
            if file not in data:
                jsonfile[file]={"filename":file,
                    "downloadurl_1":"",
                    "checksum":""}
            else:
                jsonfile[file] = data[file]
            # generate the checksum
            checksum = get_checksum(filepath+'\\'+file)
            # add the checksum to the json file
            

            jsonfile[file]['checksum']=checksum
            #print(jsonfile)
    # save the json file
    temp_filename = 'patch_list_temp.json'
    with open(temp_filename, 'w') as f:
        f.write(json.dumps(jsonfile, indent=4)
    )
    #print(jsonfile)
    #print(files)


if __name__ == '__main__':
    #get_checksum('LOGO.png')
    dir = input('Enter the path to the folder to check: ')
    new_json_builder(dir)