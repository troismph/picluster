#!/bin/bash
# $1: network device
tcpdump -i "$1" -vnes0 port 67
