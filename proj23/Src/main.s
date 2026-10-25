.syntax unified
.thumb

.global main
.type main, %function

main:
    movs r0, #5
    movs r1, #3
    adds r2, r0, r1
    lsls r2, r2, #1
    subs r3, r2, #4

.inf_loop:
    b .             @ Pętla nieskończona, żeby procesor nie wszedł w martwą strefę
