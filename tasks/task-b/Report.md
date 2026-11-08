
For help, type "help".
Type "apropos word" to search for commands related to "word"...
Reading symbols from build/firmware.elf...
(gdb) target remote localhost:1234
break main
continue
localhost:1234
break main
continue: cannot resolve name: Servname not supported for ai_socktype
localhost:1234
break main
continue: No such file or directory.
(gdb) target remote localhost:1234
Remote debugging using localhost:1234
Reset_Handler () at boards/qemu-mps2/startup.S:42
42	  ldr r0, =_sidata
(gdb) break main
Breakpoint 1 at 0xc0: file src/main.S, line 7.
(gdb) continue
Continuing.

Breakpoint 1, main () at src/main.S:7
7	    movs r0, #0xB6       @ A = 0xB6
(gdb) si
8	    movs r1, #0x6C       @ B = 0x6C
(gdb) info registers
r0             0xb6                182
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
lr             0x11d               285
pc             0xc2                0xc2 <main+2>
xpsr           0x21000000          553648128
(gdb) si
11	    ands r2, r0, r1      @ r2 = A & B
(gdb) info registers
r0             0xb6                182
r1             0x6c                108
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
lr             0x11d               285
pc             0xc4                0xc4 <main+4>
xpsr           0x21000000          553648128
(gdb) si
14	    orrs r3, r0, r1     @ r3 = A | B
(gdb) info registers
r0             0xb6                182
r1             0x6c                108
r2             0x24                36
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
lr             0x11d               285
pc             0xc8                0xc8 <main+8>
xpsr           0x21000000          553648128
(gdb) si
17	    eors r4, r0, r1     @ r4 = A ^ B
(gdb) info registers
r0             0xb6                182
r1             0x6c                108
r2             0x24                36
r3             0xfe                254
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
lr             0x11d               285
pc             0xcc                0xcc <main+12>
xpsr           0x21000000          553648128
(gdb) si
20	    lsls r5, r0, #1
(gdb) info registers
r0             0xb6                182
r1             0x6c                108
r2             0x24                36
r3             0xfe                254
r4             0xda                218
r5             0x0                 0
r6             0x0                 0
r7             0x0                 0
r8             0x0                 0
r9             0x0                 0
r10            0x0                 0
r11            0x0                 0
r12            0x0                 0
sp             0x20020000          0x20020000
lr             0x11d               285
pc             0xd0                0xd0 <main+16>
xpsr           0x21000000          553648128
(gdb) si
21	    movs r6, #0xFF
(gdb) info registers
r0             0xb6                182
r1             0x6c                108
r2             0x24                36
r3             0xfe                254
r4             0xda                218
r5             0x16c               364
r6             0x0                 0
r7             0x0                 0
r8             0x0                 0
r9             0x0                 0
r10            0x0                 0
r11            0x0                 0
r12            0x0                 0
sp             0x20020000          0x20020000
lr             0x11d               285
pc             0xd2                0xd2 <main+18>
xpsr           0x1000000           16777216
(gdb) si
22	    ands r5, r5, r6     @ r5 = (A << 1) & 0xFF
(gdb) info registers
r0             0xb6                182
r1             0x6c                108
r2             0x24                36
r3             0xfe                254
r4             0xda                218
r5             0x16c               364
r6             0xff                255
r7             0x0                 0
r8             0x0                 0
r9             0x0                 0
r10            0x0                 0
r11            0x0                 0
r12            0x0                 0
sp             0x20020000          0x20020000
lr             0x11d               285
pc             0xd4                0xd4 <main+20>
xpsr           0x1000000           16777216
(gdb) si
25	    lsrs r6, r0, #2     @ r6 = A >> 2
(gdb) info registers
r0             0xb6                182
r1             0x6c                108
r2             0x24                36
r3             0xfe                254
r4             0xda                218
r5             0x6c                108
r6             0xff                255
r7             0x0                 0
r8             0x0                 0
r9             0x0                 0
r10            0x0                 0
r11            0x0                 0
r12            0x0                 0
sp             0x20020000          0x20020000
lr             0x11d               285
pc             0xd6                0xd6 <main+22>
xpsr           0x1000000           16777216
(gdb) si
28	    movs r7, r0         @ r7 = A (0xB6)
(gdb) info registers
r0             0xb6                182
r1             0x6c                108
r2             0x24                36
r3             0xfe                254
r4             0xda                218
r5             0x6c                108
r6             0x2d                45
r7             0x0                 0
r8             0x0                 0
r9             0x0                 0
r10            0x0                 0
r11            0x0                 0
r12            0x0                 0
sp             0x20020000          0x20020000
lr             0x11d               285
pc             0xd8                0xd8 <main+24>
xpsr           0x21000000          553648128
(gdb) si
29	    movs ip, #8         @ maska dla bitu nr 3
(gdb) info registers
r0             0xb6                182
r1             0x6c                108
r2             0x24                36
r3             0xfe                254
r4             0xda                218
r5             0x6c                108
r6             0x2d                45
r7             0xb6                182
r8             0x0                 0
r9             0x0                 0
r10            0x0                 0
r11            0x0                 0
r12            0x0                 0
sp             0x20020000          0x20020000
lr             0x11d               285
pc             0xda                0xda <main+26>
xpsr           0x21000000          553648128
(gdb) si
30	    orrs r7, r7, ip     @ ustawienie bitu 3 na 1
(gdb) info registers
r0             0xb6                182
r1             0x6c                108
r2             0x24                36
r3             0xfe                254
r4             0xda                218
r5             0x6c                108
r6             0x2d                45
r7             0xb6                182
r8             0x0                 0
r9             0x0                 0
r10            0x0                 0
r11            0x0                 0
r12            0x8                 8
sp             0x20020000          0x20020000
lr             0x11d               285
pc             0xde                0xde <main+30>
xpsr           0x21000000          553648128
(gdb) si
32	    movs r7, r0         @ przywrócenie A
(gdb) info registers
r0             0xb6                182
r1             0x6c                108
r2             0x24                36
r3             0xfe                254
r4             0xda                218
r5             0x6c                108
r6             0x2d                45
r7             0xbe                190
r8             0x0                 0
r9             0x0                 0
r10            0x0                 0
r11            0x0                 0
r12            0x8                 8
sp             0x20020000          0x20020000
lr             0x11d               285
pc             0xe2                0xe2 <main+34>
xpsr           0x21000000          553648128
(gdb) si
33	    bics r7, r7, ip     @ wyzerowanie bitu 3 na 0
(gdb) info registers
r0             0xb6                182
r1             0x6c                108
r2             0x24                36
r3             0xfe                254
r4             0xda                218
r5             0x6c                108
r6             0x2d                45
r7             0xb6                182
r8             0x0                 0
r9             0x0                 0
r10            0x0                 0
r11            0x0                 0
r12            0x8                 8
sp             0x20020000          0x20020000
lr             0x11d               285
pc             0xe4                0xe4 <main+36>
xpsr           0x21000000          553648128
(gdb) si
35	    movs r7, r0         @ przywrócenie A
(gdb) info registers
r0             0xb6                182
r1             0x6c                108
r2             0x24                36
r3             0xfe                254
r4             0xda                218
r5             0x6c                108
r6             0x2d                45
r7             0xb6                182
r8             0x0                 0
r9             0x0                 0
r10            0x0                 0
r11            0x0                 0
r12            0x8                 8
sp             0x20020000          0x20020000
lr             0x11d               285
pc             0xe8                0xe8 <main+40>
xpsr           0x21000000          553648128
(gdb) si
36	    eors r7, r7, ip     @ przełączenie bitu 3
(gdb) info registers
r0             0xb6                182
r1             0x6c                108
r2             0x24                36
r3             0xfe                254
r4             0xda                218
r5             0x6c                108
r6             0x2d                45
r7             0xb6                182
r8             0x0                 0
r9             0x0                 0
r10            0x0                 0
r11            0x0                 0
r12            0x8                 8
sp             0x20020000          0x20020000
lr             0x11d               285
pc             0xea                0xea <main+42>
xpsr           0x21000000          553648128
(gdb) si
infinite_loop () at src/main.S:39
39	    b infinite_loop
(gdb) Quit
(gdb) q 
A debugging session is active.

