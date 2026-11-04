/* boards/qemu-mps2/linker.ld */
ENTRY(Reset_Handler)
MEMORY {
  FLASH (rx)  : ORIGIN = 0x00000000, LENGTH = 1M
  RAM   (rwx) : ORIGIN = 0x20000000, LENGTH = 128K
}
_estack = ORIGIN(RAM) + LENGTH(RAM);
/* ... */
SECTIONS
{
  .isr_vector :
  {
    . = ALIGN(4);
    KEEP(*(.isr_vector))
    . = ALIGN(4);
  } > FLASH

  .text :
  {
    . = ALIGN(4);
    *(.text*)
    *(.rodata*)
    *(.glue_7) *(.glue_7t) *(.eh_frame*)
    . = ALIGN(4);
  } > FLASH

  .data : AT (LOADADDR(.text) + SIZEOF(.text))
  {
    . = ALIGN(4);
    _sdata = .;
    *(.data*)
    . = ALIGN(4);
    _edata = .;
  } > RAM
  _sidata = LOADADDR(.data);

  .bss (NOLOAD) :
  {
    . = ALIGN(4);
    _sbss = .;
    *(.bss*) *(COMMON)
    . = ALIGN(4);
    _ebss = .;
  } > RAM

  _end = .;
}

PROVIDE(end = _end);
PROVIDE(__end__ = _end);
PROVIDE(__heap_start = _end);
PROVIDE(__HeapBase   = _end);
PROVIDE(__HeapLimit  = ORIGIN(RAM) + LENGTH(RAM));
