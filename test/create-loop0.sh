#!/usr/bin/env bash
set -e
if [ ! -f "/tmp/loop0-file" ]; then
  dd if=/dev/zero of=/tmp/loop0-file bs=1M count=1000
fi

if [ ! -e "/dev/loop0" ]; then
  losetup /dev/loop0 /tmp/loop0-file
fi
