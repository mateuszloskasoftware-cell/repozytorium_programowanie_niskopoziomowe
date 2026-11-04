# Docker ARM bare‑metal + QEMU (Windows & macOS)

Reprodykowalne środowisko do zadań: ASM (AAPCS), budowanie dla **Cortex‑M3**, uruchamianie w **QEMU** (semihosting) i debug przez **GDB**.

## 1) Wymagania
- Docker Desktop (Windows/macOS), Compose v2.
- (Opcjonalnie) VS Code + Dev Containers.

## 2) Szybki start
```bash
docker compose build
docker compose run --rm toolchain make
docker compose run --rm toolchain bash -lc "./scripts/run.sh"
# alternatywnie
docker compose run --rm toolchain bash -lc "qemu-system-arm -M mps2-an385 -nographic -semihosting -kernel build/firmware.elf"
# Debug (dwa terminale):
docker compose run --rm toolchain bash -lc "qemu-system-arm -M mps2-an385 -nographic -S -gdb tcp::1234 -semihosting-config enable=on,target=native -kernel build/firmware.elf"
docker compose run --rm toolchain bash -lc "arm-none-eabi-gdb build/firmware.elf -ex 'target remote :1234'"
```

## 3) Windows/macOS — uwagi
- Windows: uruchamiaj `scripts\run.ps1` w kontenerze (PowerShell).  
- macOS (Apple Silicon): domyślnie obraz będzie arm64 — OK. Wymuś `platform` tylko jeśli potrzebujesz.

## 4) Struktura
```
asm/  src/  boards/qemu-mps2/  scripts/  Makefile  Dockerfile  docker-compose.yml  .devcontainer/
```
