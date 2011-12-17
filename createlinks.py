#!/usr/bin/env python
import os


HERE = os.path.abspath(os.path.dirname(__file__))
THIS_SCRIPT = os.path.basename(__file__)
DESTINATION_DIR = os.getenv('HOME')


def main():
    for filename in os.listdir(HERE):
        if THIS_SCRIPT != filename and not filename.startswith('.'):
            source_path = os.path.join(HERE, filename)
            destination_path = os.path.join(DESTINATION_DIR, '.' + filename)
            link_command = '/bin/ln -s %s %s' % (source_path, destination_path)
            print(link_command)
            os.system(link_command)


if __name__ == '__main__':
    main()

