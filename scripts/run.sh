#!/usr/bin/env bash
set -e
qemu-system-arm -M mps2-an385 -nographic \
  -semihosting \
  -kernel build/firmware.elf