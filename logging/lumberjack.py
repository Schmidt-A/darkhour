#!/usr/bin/env python

import json
import logging
import os
import pprint
import sys
import time

from pygtail import Pygtail

logging.basicConfig(filename='im_a_lumberjack.log',
        format='%(asctime)s %(levelname)s %(message)s', level=logging.DEBUG)
log = logging.getLogger()

class Splitter():
    def __init__(self, path, patterns):
        self.path = path
        self.patterns = patterns

    def match(self, line):
        for pattern in self.patterns:
            if pattern in line.decode('utf-8', 'ignore'):
                log.debug('match:"%s" ==> "%s"' % (pattern, self.path))
                self.write(line)
                return True
        return False

    def write(self, line):
        if not os.path.exists(self.path):
            try:
                os.makedirs(os.path.dirname(self.path))
            except OSError as e:
                if e.errno == 17:
                    pass
                else:
                    log.warn('makedirs exception: %s' % e)
                    pass
        with open(self.path, 'a') as f:
            f.write('%s\n' % line.rstrip())


class FileFollower():
    '''
    Use pygtail to keep track of EOF and rotated files, catch exceptions to
    make things more seamless
    '''
    def __init__(self, path):
        self.path = path
        self.pygtail = None
        self.last_inode = 0

    def next(self):
        line = ''
        curr_inode = 0
        if self.pygtail is None:
            try:
                # remove last offset file if the log file is different
                # PygTail's inode detection doesn't work in certain cases
                curr_inode = os.stat(self.path).st_ino
                if self.last_inode != curr_inode:
                    os.unlink(self.path + '.offset')
                    self.last_inode = curr_inode
                    log.debug('deleted offset file, inode difference')
            except Exception as e:
                log.info('inode checking failed (not terminal): %s' % e)
            self.pygtail = Pygtail(self.path)
        try:
            line = self.pygtail.next()
        except StopIteration as si:
            # Need to get a new instance of pygtail after this incase the inode
            # has changed
            self.pygtail = None
            return False
        return line


class LumberJack():
    def __init__(self, settings):
        log.debug('settings: %s' % pprint.pformat(settings))
        self.settings = settings
        self.splitters = []
        self.follower = FileFollower(self.settings["log_path"])
        for split, patterns in self.settings["log_splits"].items():
            log.debug("split: %s , patterns: %s" % (split, patterns))
            self.splitters.append(Splitter(split, patterns))

    def chop_forever(self):
        log.debug('chop_forever')
        while True:
            line = self.follower.next()
            if line == False:
                # take a break big guy
                log.debug('no line found, rest for %s' % self.settings["rest"])
                time.sleep(self.settings["rest"])
            else:
                found_match = False
                for chop in self.splitters:
                    matched = chop.match(line)
                    if matched:
                        found_match = True
                if not found_match:
                    log.debug('no match: %s' % line)

def usage():
    sys.stderr.write('usage: %s [settings file]\nSettings file required if '
                     'it does not exist in the current path\n' % sys.argv[0])
    sys.exit(1)

def main():
    settings_path = './settings.json'
    if not os.path.isfile(settings_path):
        # look for settings arg
        if not len(sys.argv) >= 2:
            usage()
        settings_path = sys.argv[1]
    with open(settings_path) as sfile:
        settings = json.load(sfile)
    ljack = LumberJack(settings)
    ljack.chop_forever()

if __name__ == '__main__':
    try:
        main()
    except Exception as e:
        log.exception('Unexpected exception: %s' % e)
        sys.exit(1)


