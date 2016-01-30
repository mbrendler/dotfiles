# pylint: disable=missing-docstring
import sys
from argparse import ArgumentParser
from urllib import quote_plus
from urllib2 import urlopen, HTTPError
import json


def get_json(url_template, opts):
    try:
        connection = urlopen(url_template % opts)
    except HTTPError as error:
        sys.stderr.write(str(error) + '\n')
        sys.exit(1)
    return json.loads(connection.read())


def print_json(content, _):
    print json.dumps(content, indent=2)


def parse_options(default_print, extra_arguments):
    parser = ArgumentParser()
    parser.add_argument('words', metavar="WORD", nargs='+')
    parser.add_argument(
        '--json', dest='puts', help='only print JSON response',
        default=default_print, const=print_json, action='store_const'
    )
    return extra_arguments(parser).parse_args()


def main(url_template, default_print, extra_arguments=lambda p: p):
    opts = parse_options(default_print, extra_arguments)
    opts.words = quote_plus(' '.join(opts.words))
    content = get_json(url_template, opts.__dict__)
    opts.puts(content, opts)
