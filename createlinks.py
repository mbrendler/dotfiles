#!/usr/bin/env python
"""Creates symbolic links for every file and directory from 'configfiles'.

The links are created in home directory of the current user. Every link gets a
'.' prefix.
"""
import os
import sys
import time


HERE = os.path.dirname(__file__)
SOURCE_DIR = os.path.abspath(os.path.join(HERE, 'configfiles'))
DESTINATION_DIR = os.getenv('HOME')
BACKUP_DIR = os.path.join(DESTINATION_DIR, 'configsbackup', '%d' % time.time())


def error(message):
    """Prints a red error message to stderr.
    """
    sys.stderr.write("\033[38;5;1m" + str(message) + "\033[0m")
    sys.stderr.flush()


def warning(message):
    """Prints a yellow message to stdout.
    """
    sys.stdout.write("\033[38;5;11m" + str(message) + "\033[0m")
    sys.stdout.flush()


def info(message):
    """Prints a green message to stdout.
    """
    sys.stdout.write("\033[38;5;10m" + str(message) + "\033[0m")
    sys.stdout.flush()


def backup(filename, backup_dir):
    """Moves the given file to the given backup directory.
    """
    os.system("mkdir -p %s" % backup_dir)
    os.rename(filename, os.path.join(backup_dir, os.path.basename(filename)))


def main():
    """See module documentation.
    """
    for filename in os.listdir(SOURCE_DIR):
        source_path = os.path.join(SOURCE_DIR, filename)
        destination_path = os.path.join(DESTINATION_DIR, '.' + filename)
        sys.stdout.write('%s ' % destination_path)
        if os.path.exists(destination_path):
            if os.path.realpath(destination_path) == source_path:
                info('exists\n')
                continue
            else:
                backup(destination_path, BACKUP_DIR)
                warning('backup ')
        os.symlink(source_path, destination_path)
        info('created\n')


if __name__ == '__main__':
    main()

