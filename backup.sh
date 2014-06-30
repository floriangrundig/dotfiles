#!/bin/bash

tar pzchf ~/backup-$(date +%Y-%m-%d).tar.gz * \
    --exclude=temp

gpg --symmetric --cipher-algo AES256 ~/backup-$(date +%Y-%m-%d).tar.gz
rm -f ~/backup-$(date +%Y-%m-%d).tar.gz
