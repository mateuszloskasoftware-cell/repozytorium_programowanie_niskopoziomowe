/* boards/qemu-mps2/startup.S */
.syntax unified
.cpu cortex-m3
.thumb

.global _estack
.global _sidata, _sdata, _edata, _sbss, _ebss
.extern main

/* --- Tabela wektorów --- */
.section .isr_vector, "a", %progbits
.type g_pfnVectors, %object
g_pfnVectors:
  .word _estack           /* 0: MSP (Initial Stack Pointer) */
  .word Reset_Handler     /* 1: Reset */
  .word NMI_Handler       /* 2 */
  .word HardFault_Handler /* 3 */
  .word MemManage_Handler /* 4 */
  .word BusFault_Handler  /* 5 */
  .word UsageFault_Handler/* 6 */
  .word 0                 /* 7 Reserved */
  .word 0                 /* 8 Reserved */
  .word 0                 /* 9 Reserved */
  .word 0                 /* 10 Reserved */
  .word SVC_Handler       /* 11 */
  .word DebugMon_Handler  /* 12 */
  .word 0                 /* 13 Reserved */
  .word PendSV_Handler    /* 14 */
  .word SysTick_Handler   /* 15 */
  /* wypełnij IRQ domyślnym handlerem (na M3 i tak niewykorzystywane w demo) */
  .rept 32
    .word Default_Handler
  .endr
.size g_pfnVectors, .-g_pfnVectors

/* --- Reset_Handler: kopiuj .data, zeruj .bss, zawołaj main --- */
.section .text.Reset_Handler, "ax", %progbits
.global Reset_Handler
.type Reset_Handler, %function
Reset_Handler:
  /* .data: FLASH -> RAM */
  ldr r0, =_sidata
  ldr r1, =_sdata
  ldr r2, =_edata
1:cmp r1, r2
  bcc 2f
  b   3f
2:ldr r3, [r0], #4
  str r3, [r1], #4
  b   1b

3:/* .bss: zero */
  ldr r0, =_sbss
  ldr r1, =_ebss
4:cmp r0, r1
  bcc 5f
  b   6f
5:movs r2, #0
  str r2, [r0], #4
  b   4b
6:
  bl  main
7:
  b   7b

/* --- Handlery domyślne: pętla --- */
.section .text.Handlers, "ax", %progbits
.global Default_Handler
.type Default_Handler, %function
Default_Handler: b .

.global NMI_Handler, HardFault_Handler, MemManage_Handler, BusFault_Handler
.global UsageFault_Handler, SVC_Handler, DebugMon_Handler, PendSV_Handler, SysTick_Handler
NMI_Handler:        b .
HardFault_Handler:  b .
MemManage_Handler:  b .
BusFault_Handler:   b .
UsageFault_Handler: b .
SVC_Handler:        b .
DebugMon_Handler:   b .
PendSV_Handler:     b .
SysTick_Handler:    b .