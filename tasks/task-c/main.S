.syntax unified
.thumb

.global main
.thumb_func
main:
    @ Przypadek 1: a = 10, b = 20
    movs r0, #10
    movs r1, #20
    cmp r0, r1
    bge 1f
    movs r2, r1
    b next1
1:  movs r2, r0

next1:
    @ Przypadek 2: a = 20, b = 10
    movs r0, #20
    movs r1, #10
    cmp r0, r1
    bge 2f
    movs r2, r1
    b next2
2:  movs r2, r0

next2:
    @ Przypadek 3: a = 10, b = 10
    movs r0, #10
    movs r1, #10
    cmp r0, r1
    bge 3f
    movs r2, r1
    b next3
3:  movs r2, r0

next3:
    @ Przypadek 4: a = -5, b = 2
    ldr r0, =-5
    movs r1, #2
    cmp r0, r1
    bge 4f
    movs r2, r1
    b next4
4:  movs r2, r0

next4:
    @ Przypadek 5: a = -3, b = -8
    ldr r0, =-3
    ldr r1, =-8
    cmp r0, r1
    bge 5f
    movs r2, r1
    b next5
5:  movs r2, r0

next5:
    b next5
