#!/usr/bin/env python
import os


HERE = os.path.dirname(__file__)
SOURCE_DIR = os.path.abspath(os.path.join(HERE, 'configfiles'))
THIS_SCRIPT = os.path.basename(__file__)
DESTINATION_DIR = os.getenv('HOME')


def main():
    for filename in os.listdir(SOURCE_DIR):
        source_path = os.path.join(SOURCE_DIR, filename)
        destination_path = os.path.join(DESTINATION_DIR, '.' + filename)
        link_command = '/bin/ln -s %s %s' % (source_path, destination_path)
        print('%s -> %s' % (source_path, destination_path))
        try:
            os.symlink(source_path, destination_path)
        except OSError, e:
            print(e)


if __name__ == '__main__':
    main()

