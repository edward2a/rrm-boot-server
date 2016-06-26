#!/usr/bin/env python3

import hashlib
import urllib.request
import sys


class GentooStage3(object):

    base_url = 'http://distfiles.gentoo.org/releases/amd64/autobuilds/'
    stage3_latest = 'latest-stage3-amd64.txt'
    stage3_dl = None

    def __init__(self):
        self.stage3_dl = self.get_latest_stage3_link()
        self.get_latest_stage3_archive()

        return None

    def get_latest_stage3_link(self):
        _url = self.base_url + self.stage3_latest
        try:
            data = urllib.request.urlopen(url=_url, timeout=5).read()
        except:
            raise

        result = data.splitlines()[2].decode('utf-8').split()
        sys.stdout.writelines(
                'Found ' + result[0] + 'with size (bytes): ' + result[1] + '\n'
            )
        return result

    def get_latest_sum(self):
        _url = self.base_url + self.stage3_dl[0].DIGESTS
        try:
            data = urllib.request.urlopen(url=_url, timeout=5).read()
        except:
            raise

        self.stage3_sum = data.splitlines()[1].split()[0].decode('utf-8')

    def calculate_file_sum(self, target_file):
        buffer_size = 65536
        try:
            hash = hashlib.sha512()
            with open(target_file, 'rb') as f:
                for chunk in iter(lambda: f.read(buffer_size), b''):
                    hash.update(chunk)
            return hash.hexdigest()
        except FileNotFoundError:
            return None

    def get_latest_stage3_archive(self):
        _url = self.base_url + self.stage3_dl[0]
        dest_file = self.stage3_dl[0].split('/')[1]
        try:
            sys.stdout.writelines('Downloading ' + dest_file + '...\n')
            data = urllib.request.urlretrieve(url=_url, filename=dest_file)
            sys.stdout.writelines('Download finished.\n')
        except:
            raise

        return None

if __name__ == '__main__':
    try:
        GentooStage3()
    except:
        sys.exit(1)
