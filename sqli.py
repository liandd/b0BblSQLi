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


def make_SQLI():


if __name__ == '__main__':
    make_SQLI()
