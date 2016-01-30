#!/usr/bin/env python
"""Creates symbolic links for every file and directory from 'dot'.

The links are created in home directory of the current user. Every link gets a
'.' prefix.
"""
import os
import sys
import time
import platform


HERE = os.path.dirname(__file__)
SOURCE_DIR = os.path.abspath(os.path.join(HERE, 'dot'))
OS_SPECIFIC_SOURCE_DIR = os.path.abspath(
    os.path.join(SOURCE_DIR, '_' + platform.system().lower()))
DESTINATION_DIR = os.getenv('HOME')
BACKUP_DIR = os.path.join(DESTINATION_DIR, 'configsbackup', '%d' % time.time())
IGNORE_FILES = ('.DS_Store', '_darwin', '_linux')


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
    for source_dir in (SOURCE_DIR, OS_SPECIFIC_SOURCE_DIR):
        if not os.path.isdir(source_dir):
            continue
        for filename in os.listdir(source_dir):
            if filename in IGNORE_FILES or filename[0] == '.':
                continue
            source_path = os.path.join(source_dir, filename)
            destination_path = os.path.join(DESTINATION_DIR, '.' + filename)
            sys.stdout.write('%s ' % destination_path)
            if os.path.exists(destination_path):
                if os.path.realpath(destination_path) == source_path:
                    info('exists\n')
                    continue
                else:
                    backup(destination_path, BACKUP_DIR)
                    warning('backup ')
            os.system('ln -fs %s %s' % (source_path, destination_path))
            info('created\n')


if __name__ == '__main__':
    main()
