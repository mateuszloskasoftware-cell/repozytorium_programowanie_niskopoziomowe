.syntax unified
.thumb

.section .data
.align 2
array:
    .word 4         @ Element 0
    .word 7         @ Element 1
    .word 10        @ Element 2 (zmienione z 2)
    .word 9         @ Element 3
    .word 20        @ Element 4 (zmienione z 5)
length:
    .word 5         @ Długość tablicy przekazana osobno
result:
    .word 0         @ Miejsce na wynik sumowania

.section .text
.global main
.thumb_func
main:
    ldr r0, =array      @ R0 = adres bazowy tablicy
    ldr r1, =length     
    ldr r1, [r1]        @ R1 = długość tablicy (N = 5)
    movs r2, #0         @ R2 = licznik i = 0
    movs r3, #0         @ R3 = suma = 0

loop:
    cmp r2, r1
    bge end_loop

    @ Adres elementu = adres_bazowy + (i * 4)
    lsls r4, r2, #2     @ R4 = i * 4 (przesunięcie w bajtach)
    adds r4, r0, r4     @ R4 = adres aktualnego elementu
    ldr r5, [r4]        @ Odczytaj wartość z tablicy do R5
    adds r3, r3, r5     @ Suma += odczytana wartość

    adds r2, r2, #1     @ Zwiększ licznik i++
    b loop

end_loop:
    ldr r4, =result     @ Załaduj adres zmiennej wynikowej
    str r3, [r4]        @ Zapisz ostateczną sumę w pamięci

infinite_loop:
    b infinite_loop
