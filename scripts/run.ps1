# PowerShell (w kontenerze)
qemu-system-arm -M mps2-an385 -nographic `
  -semihosting `
  -kernel build\firmware.elf