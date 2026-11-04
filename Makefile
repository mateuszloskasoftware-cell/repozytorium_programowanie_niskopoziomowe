TOOL=arm-none-eabi
CFLAGS= -mcpu=cortex-m3 -mthumb -O0 -g -ffreestanding -nostdlib
LDFLAGS= -T boards/qemu-mps2/linker.ld -Wl,--gc-sections,-Map,build/firmware.map \
         -nostartfiles 
SRC=src/main.c boards/qemu-mps2/startup.S
OUT=build/firmware.elf

all:
	mkdir -p build
	$(TOOL)-gcc $(CFLAGS) $(LDFLAGS) -o $(OUT) $(SRC)

size:
	$(TOOL)-size $(OUT)

clean:
	rm -f $(OUT)