.syntax unified
.thumb

.section .data
.align 2
array:
    .word 0x11223344        @ Element 0 (adres: 0x20000000)
    .word 0x00000010        @ Element 1 (adres: 0x20000004)
result:
    .word 0x00000000        @ Miejsce na wynik (adres: 0x20000008)

.section .text
.global main
.thumb_func
main:
    ldr r0, =array          @ Załaduj adres początkowy tablicy do R0
    ldr r1, [r0]            @ Odczytaj pierwszy element (0x11223344) do R1
    ldr r2, [r0, #4]        @ Odczytaj drugi element (0x00000010) do R2
    adds r3, r1, r2         @ Dodaj oba elementy: R3 = R1 + R2 (0x11223354)

    ldr r4, =result         @ Załaduj adres docelowy wyniku do R4
    str r3, [r4]            @ Zapisz wynik z R3 do pamięci pod adresem R4

infinite_loop:
    b infinite_loop
