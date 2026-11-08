.syntax unified
.thumb

.global main
.thumb_func
main:
    movs r0, #0xB6       @ A = 0xB6
    movs r1, #0x6C       @ B = 0x6C

    @ 1. AND
    ands r2, r0, r1      @ r2 = A & B

    @ 2. OR
    orrs r3, r0, r1     @ r3 = A | B

    @ 3. XOR
    eors r4, r0, r1     @ r4 = A ^ B

    @ 4. LSL 1 z maską 0xFF
    lsls r5, r0, #1
    movs r6, #0xFF
    ands r5, r5, r6     @ r5 = (A << 1) & 0xFF

    @ 5. LSR 2 (logiczne)
    lsrs r6, r0, #2     @ r6 = A >> 2

    @ Operacje na bicie nr 3 (wartość 8)
    movs r7, r0         @ r7 = A (0xB6)
    movs ip, #8         @ maska dla bitu nr 3
    orrs r7, r7, ip     @ ustawienie bitu 3 na 1

    movs r7, r0         @ przywrócenie A
    bics r7, r7, ip     @ wyzerowanie bitu 3 na 0

    movs r7, r0         @ przywrócenie A
    eors r7, r7, ip     @ przełączenie bitu 3

infinite_loop:
    b infinite_loop
