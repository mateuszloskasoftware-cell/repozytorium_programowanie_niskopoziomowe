emote debugging using localhost:1234
Reset_Handler () at boards/qemu-mps2/startup.S:42
42	  ldr r0, =_sidata
(gdb) info  registers
r0             0x0                 0
r1             0x0                 0
r2             0x0                 0
r3             0x0                 0
r4             0x0                 0
r5             0x0                 0
r6             0x0                 0
r7             0x0                 0
r8             0x0                 0
r9             0x0                 0
r10            0x0                 0
r11            0x0                 0
r12            0x0                 0
sp             0x20020000          0x20020000
lr             0xffffffff          -1
pc             0x110               0x110 <Reset_Handler>
xpsr           0x41000000          1090519040
(gdb) si
43	  ldr r1, =_sdata
(gdb) info  registers
r0             0x168               360
r1             0x0                 0
r2             0x0                 0
r3             0x0                 0
r4             0x0                 0
r5             0x0                 0
r6             0x0                 0
r7             0x0                 0
r8             0x0                 0
r9             0x0                 0
r10            0x0                 0
r11            0x0                 0
r12            0x0                 0
sp             0x20020000          0x20020000
lr             0xffffffff          -1
pc             0x112               0x112 <Reset_Handler+2>
xpsr           0x41000000          1090519040
(gdb) si
44	  ldr r2, =_edata
(gdb) info  registers
r0             0x168               360
r1             0x20000000          536870912
r2             0x0                 0
r3             0x0                 0
r4             0x0                 0
r5             0x0                 0
r6             0x0                 0
r7             0x0                 0
r8             0x0                 0
r9             0x0                 0
r10            0x0                 0
r11            0x0                 0
r12            0x0                 0
sp             0x20020000          0x20020000
lr             0xffffffff          -1
pc             0x114               0x114 <Reset_Handler+4>
xpsr           0x41000000          1090519040
(gdb) si
45	1:cmp r1, r2
(gdb) info  registers
r0             0x168               360
r1             0x20000000          536870912
r2             0x20000000          536870912
r3             0x0                 0
r4             0x0                 0
r5             0x0                 0
r6             0x0                 0
r7             0x0                 0
r8             0x0                 0
r9             0x0                 0
r10            0x0                 0
r11            0x0                 0
r12            0x0                 0
sp             0x20020000          0x20020000
lr             0xffffffff          -1
pc             0x116               0x116 <Reset_Handler+6>
xpsr           0x41000000          1090519040
(gdb) si
46	  bcc 2f
(gdb) info  registers
r0             0x168               360
r1             0x20000000          536870912
r2             0x20000000          536870912
r3             0x0                 0
r4             0x0                 0
r5             0x0                 0
r6             0x0                 0
r7             0x0                 0
r8             0x0                 0
r9             0x0                 0
r10            0x0                 0
r11            0x0                 0
r12            0x0                 0
sp             0x20020000          0x20020000
lr             0xffffffff          -1
pc             0x118               0x118 <Reset_Handler+8>
xpsr           0x61000000          1627389952
(gdb) si
47	  b   3f
(gdb) info  registers
r0             0x168               360
r1             0x20000000          536870912
r2             0x20000000          536870912
r3             0x0                 0
r4             0x0                 0
r5             0x0                 0
r6             0x0                 0
r7             0x0                 0
r8             0x0                 0
r9             0x0                 0
r10            0x0                 0
r11            0x0                 0
r12            0x0                 0
sp             0x20020000          0x20020000
lr             0xffffffff          -1
pc             0x11a               0x11a <Reset_Handler+10>
xpsr           0x61000000          1627389952
(gdb) si
53	  ldr r0, =_sbss
(gdb) info  registers
r0             0x168               360
r1             0x20000000          536870912
r2             0x20000000          536870912
r3             0x0                 0
r4             0x0                 0
r5             0x0                 0
r6             0x0                 0
r7             0x0                 0
r8             0x0                 0
r9             0x0                 0
r10            0x0                 0
r11            0x0                 0
r12            0x0                 0
sp             0x20020000          0x20020000
lr             0xffffffff          -1
pc             0x126               0x126 <Reset_Handler+22>
xpsr           0x61000000          1627389952
(gdb) si
54	  ldr r1, =_ebss
(gdb) info  registers
r0             0x20000000          536870912
r1             0x20000000          536870912
r2             0x20000000          536870912
r3             0x0                 0
r4             0x0                 0
r5             0x0                 0
r6             0x0                 0
r7             0x0                 0
r8             0x0                 0
r9             0x0                 0
r10            0x0                 0
r11            0x0                 0
r12            0x0                 0
sp             0x20020000          0x20020000
lr             0xffffffff          -1
pc             0x128               0x128 <Reset_Handler+24>
xpsr           0x61000000          1627389952
(gdb) si
55	4:cmp r0, r1
(gdb) info  registers
r0             0x20000000          536870912
r1             0x20000000          536870912
r2             0x20000000          536870912
r3             0x0                 0
r4             0x0                 0
r5             0x0                 0
r6             0x0                 0
r7             0x0                 0
r8             0x0                 0
r9             0x0                 0
r10            0x0                 0
r11            0x0                 0
r12            0x0                 0
sp             0x20020000          0x20020000
lr             0xffffffff          -1
pc             0x12a               0x12a <Reset_Handler+26>
xpsr           0x61000000          1627389952
(gdb) si
56	  bcc 5f
(gdb) info  registers
r0             0x20000000          536870912
r1             0x20000000          536870912
r2             0x20000000          536870912
r3             0x0                 0
r4             0x0                 0
r5             0x0                 0
r6             0x0                 0
r7             0x0                 0
r8             0x0                 0
r9             0x0                 0
r10            0x0                 0
r11            0x0                 0
r12            0x0                 0
sp             0x20020000          0x20020000
lr             0xffffffff          -1
pc             0x12c               0x12c <Reset_Handler+28>
xpsr           0x61000000          1627389952
(gdb) si
57	  b   6f
(gdb) info  registers
r0             0x20000000          536870912
r1             0x20000000          536870912
r2             0x20000000          536870912
r3             0x0                 0
r4             0x0                 0
r5             0x0                 0
r6             0x0                 0
r7             0x0                 0
r8             0x0                 0
r9             0x0                 0
r10            0x0                 0
r11            0x0                 0
r12            0x0                 0
sp             0x20020000          0x20020000
lr             0xffffffff          -1
pc             0x12e               0x12e <Reset_Handler+30>
xpsr           0x61000000          1627389952
(gdb) si
62	  bl  main
(gdb) info  registers
r0             0x20000000          536870912
r1             0x20000000          536870912
r2             0x20000000          536870912
r3             0x0                 0
r4             0x0                 0
r5             0x0                 0
r6             0x0                 0
r7             0x0                 0
r8             0x0                 0
r9             0x0                 0
r10            0x0                 0
r11            0x0                 0
r12            0x0                 0
sp             0x20020000          0x20020000
lr             0xffffffff          -1
pc             0x138               0x138 <Reset_Handler+40>
xpsr           0x61000000          1627389952
(gdb) si

Breakpoint 1, main () at src/main.S:8
8	    movs r0, #10
(gdb) info  registers
r0             0x20000000          536870912
r1             0x20000000          536870912
r2             0x20000000          536870912
r3             0x0                 0
r4             0x0                 0
r5             0x0                 0
r6             0x0                 0
r7             0x0                 0
r8             0x0                 0
r9             0x0                 0
r10            0x0                 0
r11            0x0                 0
r12            0x0                 0
sp             0x20020000          0x20020000
lr             0x13d               317
pc             0xc0                0xc0 <main>
xpsr           0x61000000          1627389952
(gdb) si
9	    movs r1, #20
(gdb) info  registers
r0             0xa                 10
r1             0x20000000          536870912
r2             0x20000000          536870912
r3             0x0                 0
r4             0x0                 0
r5             0x0                 0
r6             0x0                 0
r7             0x0                 0
r8             0x0                 0
r9             0x0                 0
r10            0x0                 0
r11            0x0                 0
r12            0x0                 0
sp             0x20020000          0x20020000
lr             0x13d               317
pc             0xc2                0xc2 <main+2>
xpsr           0x21000000          553648128
(gdb) si
10	    cmp r0, r1
(gdb) info  registers
r0             0xa                 10
r1             0x14                20
r2             0x20000000          536870912
r3             0x0                 0
r4             0x0                 0
r5             0x0                 0
r6             0x0                 0
r7             0x0                 0
r8             0x0                 0
r9             0x0                 0
r10            0x0                 0
r11            0x0                 0
r12            0x0                 0
sp             0x20020000          0x20020000
lr             0x13d               317
pc             0xc4                0xc4 <main+4>
xpsr           0x21000000          553648128
(gdb) si
11	    bge 1f
(gdb) info  registers
r0             0xa                 10
r1             0x14                20
r2             0x20000000          536870912
r3             0x0                 0
r4             0x0                 0
r5             0x0                 0
r6             0x0                 0
r7             0x0                 0
r8             0x0                 0
r9             0x0                 0
r10            0x0                 0
r11            0x0                 0
r12            0x0                 0
sp             0x20020000          0x20020000
lr             0x13d               317
pc             0xc6                0xc6 <main+6>
xpsr           0x81000000          -2130706432
(gdb) si
12	    movs r2, r1
(gdb) info  registers
r0             0xa                 10
r1             0x14                20
r2             0x20000000          536870912
r3             0x0                 0
r4             0x0                 0
r5             0x0                 0
r6             0x0                 0
r7             0x0                 0
r8             0x0                 0
r9             0x0                 0
r10            0x0                 0
r11            0x0                 0
r12            0x0                 0
sp             0x20020000          0x20020000
lr             0x13d               317
pc             0xc8                0xc8 <main+8>
xpsr           0x81000000          -2130706432
(gdb) si
13	    b next1
(gdb) info  registers
r0             0xa                 10
r1             0x14                20
r2             0x14                20
r3             0x0                 0
r4             0x0                 0
r5             0x0                 0
r6             0x0                 0
r7             0x0                 0
r8             0x0                 0
r9             0x0                 0
r10            0x0                 0
r11            0x0                 0
r12            0x0                 0
sp             0x20020000          0x20020000
lr             0x13d               317
pc             0xca                0xca <main+10>
xpsr           0x1000000           16777216
(gdb) si
next1 () at src/main.S:18
18	    movs r0, #20
(gdb) info  registers
r0             0xa                 10
r1             0x14                20
r2             0x14                20
r3             0x0                 0
r4             0x0                 0
r5             0x0                 0
r6             0x0                 0
r7             0x0                 0
r8             0x0                 0
r9             0x0                 0
r10            0x0                 0
r11            0x0                 0
r12            0x0                 0
sp             0x20020000          0x20020000
lr             0x13d               317
pc             0xce                0xce <next1>
xpsr           0x1000000           16777216
(gdb) si
19	    movs r1, #10
(gdb) info  registers
r0             0x14                20
r1             0x14                20
r2             0x14                20
r3             0x0                 0
r4             0x0                 0
r5             0x0                 0
r6             0x0                 0
r7             0x0                 0
r8             0x0                 0
r9             0x0                 0
r10            0x0                 0
r11            0x0                 0
r12            0x0                 0
sp             0x20020000          0x20020000
lr             0x13d               317
pc             0xd0                0xd0 <next1+2>
xpsr           0x1000000           16777216
(gdb) si
20	    cmp r0, r1
(gdb) info  registers
r0             0x14                20
r1             0xa                 10
r2             0x14                20
r3             0x0                 0
r4             0x0                 0
r5             0x0                 0
r6             0x0                 0
r7             0x0                 0
r8             0x0                 0
r9             0x0                 0
r10            0x0                 0
r11            0x0                 0
r12            0x0                 0
sp             0x20020000          0x20020000
lr             0x13d               317
pc             0xd2                0xd2 <next1+4>
xpsr           0x1000000           16777216
(gdb) si
21	    bge 2f
(gdb) info  registers
r0             0x14                20
r1             0xa                 10
r2             0x14                20
r3             0x0                 0
r4             0x0                 0
r5             0x0                 0
r6             0x0                 0
r7             0x0                 0
r8             0x0                 0
r9             0x0                 0
r10            0x0                 0
r11            0x0                 0
r12            0x0                 0
sp             0x20020000          0x20020000
lr             0x13d               317
pc             0xd4                0xd4 <next1+6>
xpsr           0x21000000          553648128
(gdb) si
24	2:  movs r2, r0
(gdb) info  registers
r0             0x14                20
r1             0xa                 10
r2             0x14                20
r3             0x0                 0
r4             0x0                 0
r5             0x0                 0
r6             0x0                 0
r7             0x0                 0
r8             0x0                 0
r9             0x0                 0
r10            0x0                 0
r11            0x0                 0
r12            0x0                 0
sp             0x20020000          0x20020000
lr             0x13d               317
pc             0xda                0xda <next1+12>
xpsr           0x21000000          553648128
(gdb) si
next2 () at src/main.S:28
28	    movs r0, #10
(gdb) info  registers
r0             0x14                20
r1             0xa                 10
r2             0x14                20
r3             0x0                 0
r4             0x0                 0
r5             0x0                 0
r6             0x0                 0
r7             0x0                 0
r8             0x0                 0
r9             0x0                 0
r10            0x0                 0
r11            0x0                 0
r12            0x0                 0
sp             0x20020000          0x20020000
lr             0x13d               317
pc             0xdc                0xdc <next2>
xpsr           0x21000000          553648128
(gdb) si
29	    movs r1, #10
(gdb) info  registers
r0             0xa                 10
r1             0xa                 10
r2             0x14                20
r3             0x0                 0
r4             0x0                 0
r5             0x0                 0
r6             0x0                 0
r7             0x0                 0
r8             0x0                 0
r9             0x0                 0
r10            0x0                 0
r11            0x0                 0
r12            0x0                 0
sp             0x20020000          0x20020000
lr             0x13d               317
pc             0xde                0xde <next2+2>
xpsr           0x21000000          553648128
(gdb) si
30	    cmp r0, r1
(gdb) info  registers
r0             0xa                 10
r1             0xa                 10
r2             0x14                20
r3             0x0                 0
r4             0x0                 0
r5             0x0                 0
r6             0x0                 0
r7             0x0                 0
r8             0x0                 0
r9             0x0                 0
r10            0x0                 0
r11            0x0                 0
r12            0x0                 0
sp             0x20020000          0x20020000
lr             0x13d               317
pc             0xe0                0xe0 <next2+4>
xpsr           0x21000000          553648128
(gdb) si
31	    bge 3f
(gdb) info  registers
r0             0xa                 10
r1             0xa                 10
r2             0x14                20
r3             0x0                 0
r4             0x0                 0
r5             0x0                 0
r6             0x0                 0
r7             0x0                 0
r8             0x0                 0
r9             0x0                 0
r10            0x0                 0
r11            0x0                 0
r12            0x0                 0
sp             0x20020000          0x20020000
lr             0x13d               317
pc             0xe2                0xe2 <next2+6>
xpsr           0x61000000          1627389952
(gdb) si
34	3:  movs r2, r0
(gdb) info  registers
r0             0xa                 10
r1             0xa                 10
r2             0x14                20
r3             0x0                 0
r4             0x0                 0
r5             0x0                 0
r6             0x0                 0
r7             0x0                 0
r8             0x0                 0
r9             0x0                 0
r10            0x0                 0
r11            0x0                 0
r12            0x0                 0
sp             0x20020000          0x20020000
lr             0x13d               317
pc             0xe8                0xe8 <next2+12>
xpsr           0x61000000          1627389952
(gdb) si
next3 () at src/main.S:38
38	    ldr r0, =-5
(gdb) info  registers
r0             0xa                 10
r1             0xa                 10
r2             0xa                 10
r3             0x0                 0
r4             0x0                 0
r5             0x0                 0
r6             0x0                 0
r7             0x0                 0
r8             0x0                 0
r9             0x0                 0
r10            0x0                 0
r11            0x0                 0
r12            0x0                 0
sp             0x20020000          0x20020000
lr             0x13d               317
pc             0xea                0xea <next3>
xpsr           0x21000000          553648128
(gdb) si
39	    movs r1, #2
(gdb) info  registers
r0             0xfffffffb          -5
r1             0xa                 10
r2             0xa                 10
r3             0x0                 0
r4             0x0                 0
r5             0x0                 0
r6             0x0                 0
r7             0x0                 0
r8             0x0                 0
r9             0x0                 0
r10            0x0                 0
r11            0x0                 0
r12            0x0                 0
sp             0x20020000          0x20020000
lr             0x13d               317
pc             0xee                0xee <next3+4>
xpsr           0x21000000          553648128
(gdb) si
40	    cmp r0, r1
(gdb) info  registers
r0             0xfffffffb          -5
r1             0x2                 2
r2             0xa                 10
r3             0x0                 0
r4             0x0                 0
r5             0x0                 0
r6             0x0                 0
r7             0x0                 0
r8             0x0                 0
r9             0x0                 0
r10            0x0                 0
r11            0x0                 0
r12            0x0                 0
sp             0x20020000          0x20020000
lr             0x13d               317
pc             0xf0                0xf0 <next3+6>
xpsr           0x21000000          553648128
(gdb) si
41	    bge 4f
(gdb) info  registers
r0             0xfffffffb          -5
r1             0x2                 2
r2             0xa                 10
r3             0x0                 0
r4             0x0                 0
r5             0x0                 0
r6             0x0                 0
r7             0x0                 0
r8             0x0                 0
r9             0x0                 0
r10            0x0                 0
r11            0x0                 0
r12            0x0                 0
sp             0x20020000          0x20020000
lr             0x13d               317
pc             0xf2                0xf2 <next3+8>
xpsr           0xa1000000          -1593835520
(gdb) si
42	    movs r2, r1
(gdb) info  registers
r0             0xfffffffb          -5
r1             0x2                 2
r2             0xa                 10
r3             0x0                 0
r4             0x0                 0
r5             0x0                 0
r6             0x0                 0
r7             0x0                 0
r8             0x0                 0
r9             0x0                 0
r10            0x0                 0
r11            0x0                 0
r12            0x0                 0
sp             0x20020000          0x20020000
lr             0x13d               317
pc             0xf4                0xf4 <next3+10>
xpsr           0xa1000000          -1593835520
(gdb) si
43	    b next4
(gdb) info  registers
r0             0xfffffffb          -5
r1             0x2                 2
r2             0x2                 2
r3             0x0                 0
r4             0x0                 0
r5             0x0                 0
r6             0x0                 0
r7             0x0                 0
r8             0x0                 0
r9             0x0                 0
r10            0x0                 0
r11            0x0                 0
r12            0x0                 0
sp             0x20020000          0x20020000
lr             0x13d               317
pc             0xf6                0xf6 <next3+12>
xpsr           0x21000000          553648128
(gdb) si
next4 () at src/main.S:48
48	    ldr r0, =-3
(gdb) info  registers
r0             0xfffffffb          -5
r1             0x2                 2
r2             0x2                 2
r3             0x0                 0
r4             0x0                 0
r5             0x0                 0
r6             0x0                 0
r7             0x0                 0
r8             0x0                 0
r9             0x0                 0
r10            0x0                 0
r11            0x0                 0
r12            0x0                 0
sp             0x20020000          0x20020000
lr             0x13d               317
pc             0xfa                0xfa <next4>
xpsr           0x21000000          553648128
(gdb) si
49	    ldr r1, =-8
(gdb) info  registers
r0             0xfffffffd          -3
r1             0x2                 2
r2             0x2                 2
r3             0x0                 0
r4             0x0                 0
r5             0x0                 0
r6             0x0                 0
r7             0x0                 0
r8             0x0                 0
r9             0x0                 0
r10            0x0                 0
r11            0x0                 0
r12            0x0                 0
sp             0x20020000          0x20020000
lr             0x13d               317
pc             0xfe                0xfe <next4+4>
xpsr           0x21000000          553648128
(gdb) si
50	    cmp r0, r1
(gdb) info  registers
r0             0xfffffffd          -3
r1             0xfffffff8          -8
r2             0x2                 2
r3             0x0                 0
r4             0x0                 0
r5             0x0                 0
r6             0x0                 0
r7             0x0                 0
r8             0x0                 0
r9             0x0                 0
r10            0x0                 0
r11            0x0                 0
r12            0x0                 0
sp             0x20020000          0x20020000
lr             0x13d               317
pc             0x102               0x102 <next4+8>
xpsr           0x21000000          553648128
(gdb) si
51	    bge 5f
(gdb) info  registers
r0             0xfffffffd          -3
r1             0xfffffff8          -8
r2             0x2                 2
r3             0x0                 0
r4             0x0                 0
r5             0x0                 0
r6             0x0                 0
r7             0x0                 0
r8             0x0                 0
r9             0x0                 0
r10            0x0                 0
r11            0x0                 0
r12            0x0                 0
sp             0x20020000          0x20020000
lr             0x13d               317
pc             0x104               0x104 <next4+10>
xpsr           0x21000000          553648128
(gdb) si
54	5:  movs r2, r0
(gdb) info  registers
r0             0xfffffffd          -3
r1             0xfffffff8          -8
r2             0x2                 2
r3             0x0                 0
r4             0x0                 0
r5             0x0                 0
r6             0x0                 0
r7             0x0                 0
r8             0x0                 0
r9             0x0                 0
r10            0x0                 0
r11            0x0                 0
r12            0x0                 0
sp             0x20020000          0x20020000
lr             0x13d               317
pc             0x10a               0x10a <next4+16>
xpsr           0x21000000          553648128
(gdb) si
next5 () at src/main.S:57
57	    b next5
(gdb) info  registers
r0             0xfffffffd          -3
r1             0xfffffff8          -8
r2             0xfffffffd          -3
r3             0x0                 0
r4             0x0                 0
r5             0x0                 0
r6             0x0                 0
r7             0x0                 0
r8             0x0                 0
r9             0x0                 0
r10            0x0                 0
r11            0x0                 0
r12            0x0                 0
sp             0x20020000          0x20020000
lr             0x13d               317
pc             0x10c               0x10c <next5>
xpsr           0xa1000000          -1593835520
(gdb) si
57	    b next5
(gdb) info  registers
r0             0xfffffffd          -3
r1             0xfffffff8          -8
r2             0xfffffffd          -3
r3             0x0                 0
r4             0x0                 0
r5             0x0                 0
r6             0x0                 0
r7             0x0                 0
r8             0x0                 0
r9             0x0                 0
r10            0x0                 0
r11            0x0                 0
r12            0x0                 0
sp             0x20020000          0x20020000
lr             0x13d               317
pc             0x10c               0x10c <next5>
xpsr           0xa1000000          -1593835520
(gdb) si
57	    b next5
(gdb) info  registers
r0             0xfffffffd          -3
r1             0xfffffff8          -8
r2             0xfffffffd          -3
r3             0x0                 0
r4             0x0                 0
r5             0x0                 0
r6             0x0                 0
r7             0x0                 0
r8             0x0                 0
r9             0x0                 0
r10            0x0                 0
r11            0x0                 0
r12            0x0                 0
sp             0x20020000          0x20020000
lr             0x13d               317
pc             0x10c               0x10c <next5>
xpsr           0xa1000000          -1593835520
(gdb) si
57	    b next5
(gdb) info  registers
r0             0xfffffffd          -3
r1             0xfffffff8          -8
r2             0xfffffffd          -3
r3             0x0                 0
r4             0x0                 0
r5             0x0                 0
r6             0x0                 0
r7             0x0                 0
r8             0x0                 0
r9             0x0                 0
r10            0x0                 0
r11            0x0                 0
r12            0x0                 0
sp             0x20020000          0x20020000
lr             0x13d               317
pc             0x10c               0x10c <next5>
xpsr           0xa1000000          -1593835520
(gdb) si
57	    b next5
(gdb) info  registers
r0             0xfffffffd          -3
r1             0xfffffff8          -8
r2             0xfffffffd          -3
r3             0x0                 0
r4             0x0                 0
r5             0x0                 0
r6             0x0                 0
r7             0x0                 0
r8             0x0                 0
r9             0x0                 0
r10            0x0                 0
r11            0x0                 0
r12            0x0                 0
sp             0x20020000          0x20020000
lr             0x13d               317
pc             0x10c               0x10c <next5>
xpsr           0xa1000000          -1593835520
(gdb) si
57	    b next5
(gdb) 

