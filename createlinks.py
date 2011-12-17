#!/usr/bin/env python
"""Creates symbolic links for every file and directory from 'configfiles'.

The links are created in home directory of the current user. Every link gets a
'.' prefix.
"""
import os
import sys


HERE = os.path.dirname(__file__)
SOURCE_DIR = os.path.abspath(os.path.join(HERE, 'configfiles'))
DESTINATION_DIR = os.getenv('HOME')


def error(message):
    """Prints error messages to stderr in red.
    """
    sys.stderr.write("\033[38;5;1m" + str(message) + "\033[0m\n")
    sys.stderr.flush()


def main():
    """See module documentation.
    """
    for filename in os.listdir(SOURCE_DIR):
        source_path = os.path.join(SOURCE_DIR, filename)
        destination_path = os.path.join(DESTINATION_DIR, '.' + filename)
        print('%s -> %s' % (source_path, destination_path))
        try:
            os.symlink(source_path, destination_path)
        except OSError, err:
            error(err)


if __name__ == '__main__':
    main()

