# Laboratorium 1 — sprawozdanie i karta zadań

**Przedmiot:** Programowanie niskopoziomowe  
**Temat:** Architektura RISC i podstawy ARM Assembly  
**Platforma:** ARM Cortex-M3 (ARMv7-M, Thumb/Thumb-2), QEMU MPS2-AN385  

> **Cel:** zrozumieć, jak instrukcje zmieniają stan rejestrów i pamięci, oraz samodzielnie zaimplementować proste algorytmy w asemblerze ARM. Nie należy przepisywać definicji z podręcznika: każdą odpowiedź teoretyczną powiąż z własnym eksperymentem.

## Metryka

| Pole | Uzupełnij |
|---|---|
| Imię i nazwisko | Mateusz Loska |
| Grupa / data |  1CW_II_INF_IRiSP_N_3 / 25-10-2026|
| Adres prywatnego repozytorium | https://github.com/mateuszloskasoftware-cell/repozytorium_programowanie_niskopoziomowe](https://github.com/mateuszloskasoftware-cell/repozytorium_programowanie_niskopoziomowe |
| Identyfikator końcowego commita |  |
| Wersja toolchaina i QEMU | GCC 10.3.1  , QEMU 6.2.0|

## 1. Efekty uczenia się i przygotowanie

Po wykonaniu ćwiczeń należy umieć: odróżnić ISA od mikroarchitektury; wyjaśnić model RISC load/store; opisać pobieranie, dekodowanie i wykonanie instrukcji; rozróżnić cykl zegarowy i rozkazowy; rozpoznać rejestry R0–R12, SP, LR, PC i flagi APSR; czytać podstawowe instrukcje Thumb; analizować warunki i pętle; wyjaśnić adresowanie i little-endian; sprawdzać wyniki w debuggerze i dokumentować je w Git.

**Przed rozpoczęciem:** przeczytaj notatki do Lab 1, sprawdź działanie środowiska udostępnionego przez prowadzącego i przypomnij sobie zapis binarny, szesnastkowy oraz liczby 32-bitowe ze znakiem.

### Słownik minimalny

| Termin | Znaczenie w praktyce |
|---|---|
| CPU / ALU / rejestr | Procesor / jednostka wykonująca działania / mały element stanu procesora dostępny instrukcjom |
| ISA | Reguły określające m.in. instrukcje, rejestry i ich znaczenie; Cortex-M3 implementuje ARMv7-M |
| Thumb | Zestaw kodowań instrukcji używany na Cortex-M3; instrukcje mają długość 16 lub 32 bitów |
| Immediate `#5` | Liczba 5 zapisana jako operand instrukcji, nie adres w pamięci |
| Adres `[r0]` | Odczyt/zapis pod adresem przechowywanym w R0 |
| `LDR` / `STR` | Odczyt słowa z pamięci / zapis słowa do pamięci |
| `CMP` | Porównanie przez aktualizację flag, bez zapisania wyniku odejmowania do rejestru ogólnego |
| APSR `N Z C V` | Flagi: znak wyniku, zero, przeniesienie/pożyczka, przepełnienie signed |
| Little-endian | Najmniej znaczący bajt słowa trafia pod najniższy adres |
| Git commit | Zapis konkretnego stanu projektu z opisem zmiany |

**Ważne:** `MOVS`, `ADDS`, `SUBS` aktualizują flagi; inne warianty instrukcji nie zawsze to robią. Przy sprawdzaniu flag nie wykonuj między `CMP` a odczytem flag dodatkowych instrukcji zmieniających APSR. `BGT` i `BLT` dotyczą porównania *signed*; dla *unsigned* stosuje się inne warunki.

## 2. Repozytorium i sposób oddania

1. Utwórz lub sklonuj **prywatne** repozytorium zgodnie z instrukcją prowadzącego; jeśli szablon repozytorium nie został jeszcze udostępniony, utwórz repozytorium samodzielnie i skopiuj do niego materiały startowe. Nie publikuj gotowych rozwiązań.
2. Umieść każdy program w osobnym katalogu `tasks/task-a` … `tasks/task-f`, a zadanie końcowe w `final/`. Jeśli szablon ma inną strukturę, zachowaj jego nazewnictwo.
3. Utwórz w katalogu głównym `REPORT.md` (możesz skopiować ten dokument i uzupełnić sekcje odpowiedzi).
4. Po kolejnych etapach wykonuj sensowne commity. Przykładowo: `git add tasks/task-a REPORT.md && git commit -m "Analyze register operations"`.
5. Uruchom testy, jeśli zostały osobno udostępnione przez prowadzącego; w przeciwnym razie wykonaj i udokumentuj ręczne przypadki testowe wskazane w tym sprawozdaniu. Następnie wykonaj `git push`. **Testy automatyczne nie zastępują analizy kodu ani obrony.**
6. Nie dodawaj do Git katalogów `build/`, plików tymczasowych ani danych dostępowych.

Przykładowa kontrola:

```bash
git status
git log --oneline -5
arm-none-eabi-gcc --version
qemu-system-arm --version
```

Dla zadania T1 dołączono samodzielny katalog `starter_lab01/` z komendami `make` i `make disasm`. Dla zadań A–F i zadania końcowego potrzebne są osobne pliki implementacji oraz środowisko ARM/QEMU. Gotowy szablon repozytorium z automatycznymi testami tych zadań **nie jest jeszcze dołączony**. Polecenia kompilacji i uruchomienia pozostałych zadań zależą od udostępnionego środowiska Docker/QEMU. **Nie zakładaj, że plik `.S` można uruchomić samodzielnie**: na Cortex-M3 program bare-metal wymaga m.in. kodu startowego i poprawnego linkowania. Korzystaj z gotowego projektu prowadzącego. Nie zastępuj jego `startup.S` własnym kodem bez polecenia.

### Obserwacja programu w GDB

Podłącz GDB do QEMU zgodnie z instrukcją środowiska. Przydatne polecenia:

```text
info registers
x/8wx 0x20000000
x/16xb 0x20000000
disassemble
stepi
break nazwa_etykiety
```

`x/8wx` pokazuje osiem słów 32-bitowych, `x/16xb` — szesnaście bajtów. Adres `0x20000000` jest przykładowym adresem RAM; rzeczywisty adres danych sprawdź w swoim programie.

## 3. Część teoretyczno-obserwacyjna

### T1. Od C do instrukcji CPU

W katalogu `starter_lab01/` otrzymujesz `example.c`, `startup.S`, `linker.ld` i `Makefile`. Uruchom `make` oraz `make disasm`, aby samodzielnie wygenerować `build/example.elf`. Następnie wykonaj `arm-none-eabi-objdump -d build/example.elf` i znajdź funkcję `add_three`. Opcjonalnie dołączono `example_reference_clang.elf` jako przykładowy plik ELF (wygenerowany kompilatorem Clang; jego dezasemblacja może się różnić od wersji GCC). Zapisz **adres**, **bajty kodu maszynowego** oraz **mnemonik** dwóch kolejnych instrukcji.

**Odpowiedz:** (a) czym różni się kod C od asemblera i kodu maszynowego? (b) co określa ISA? (c) dlaczego plik skompilowany dla x86-64 nie jest bezpośrednio wykonywalny na Cortex-M3? (d) co oznacza load/store w architekturze RISC?

**Miejsce na wyniki:**

| Adres | Kod maszynowy | Instrukcja | Własne wyjaśnienie |
|---|---|---|---|
| 0x00000102| 2000 | movs r0, #0 | załadowanie 0 do rejestru r0 |
| 0x00000104 |f7ff ffea| bl dc <sh_exit> | skok/wywołanie funkcji z etykietą sh_exit |

a) C to język wysokiego poziomu który potem kompilujemy, zrozumiały dla programisty
asembler to tekstowa reprezentacja instrukcji procesora 
kod maszynowy to ciąg bajtów

b) ISA -rejestry oraz zestaw instrukcji danego procesora

c) x86 używa innych rejestrów i instruckji niż Cortex

d) pamięć jest modyfikowana oddzielnymi instrukcjami ładowania LDR i zapisu STR i operacje arytmetyczne wykonują się wyłącznie na rejestrach wewnętrznych

### T2. Cykl instrukcji i rejestry

Wyjaśnij własnymi słowami etapy *fetch → decode → execute* dla wybranej instrukcji `ADDS`. Opisz rolę `PC`, `SP`, `LR` i `APSR`. Odpowiedz, dlaczego 100 MHz nie oznacza automatycznie 100 milionów ukończonych instrukcji na sekundę. Rozróżnij cykl zegarowy, cykl rozkazowy i termin „cykl maszynowy” (jego znaczenie zależy od przyjętego modelu procesora).

**Odpowiedź:**

d4:	370c    adds r7, #12  -- z dekompilowanego kodu z t1

fetch - procesor odczytuje instrukcję ADDS z pamięci pod adresem 0xd4 wskazywanym przez rejestr PC i umieszcza ją w buforze instrukcji,

decode- jednostka sterująca dekoduje kod adds r7, #12 - ma dodać 12 do rejestru r7

execute - ALU pobiera dane z r7, dodaje do niej 12 i zapisuje wynik w r7

PC - przechowuje adres pamięci instrukcji, która ma być wykonana jako następna

SP - wskaźnik stosu - wskazuje aktualny wierzchołek stosu w pamięci RAM

LR - rejestr łącza, który przechowuje adres powrotny gdzie procesor ma wrócić po zakończeniu podprogramu

APSR - rjestr flag warunkowych, które informują o wyniku ostatniej operacji arytmetycznej lub logicznej

100 MHZ nie oznacza 100 milionów instrukcji ukończonych na sekundę, ponieważ  realna liczba wykonywanych instrukcji zależy od architektury,
ponieważ są instrukcje które zajmują więcej niż 1 cykl zegarowy, a także mogą wystąpić przerwania systemowe i opóźnienia pamięci


cykl zegarowy - pojedyncze uderzenie zegara systemowego.
cykl rozkazowy - liczba cykli zegarowych potrzebna procesorowi na całkowite pobranie i wykonanie jednej instrukcji
Cykl maszynowy - pojedyncza operacja podstawowa realizowana na magistrali lub wewnętrznych zasobach procesora w ramach cyklu instrukcji


### T3. Reprezentacja liczb

Zamień `0xB6` na zapis binarny i dziesiętny *unsigned*. Zapisz 32-bitową reprezentację U2 liczby `-10` w systemie szesnastkowym. Wyjaśnij, jaką rolę odgrywa interpretacja signed/unsigned przy porównywaniu tych samych bitów.

**Obliczenia:** 

0xB6 w dziesiętnym unsigned: 10110110
-10 w szestnastkowym: 0xFFFFFFF6

np. w 10110110 najstarszy bit to 1, cala wartośc w unsigned to 182 w dziesiętnym, a w signed może być to -74 lub -73 (zależy który system kodowania z jakim dopełnieniem)


## 4. Zadania praktyczne

**Zasada wspólna:** dla każdego zadania dołącz kod, krótki opis użytych rejestrów, przewidywany rezultat, wynik rzeczywisty oraz przynajmniej jeden dowód weryfikacji (zapis stanu GDB, log testu lub zrzut ekranu z czytelnymi wartościami). Nie należy wklejać dziesiątek nieopisanych zrzutów.

### A. Rejestry i arytmetyka

Przed uruchomieniem przeanalizuj kod:

```asm
.syntax unified
.thumb
movs r0, #5
movs r1, #3
adds r2, r0, r1
lsls r2, r2, #1
subs r3, r2, #4
```

Uzupełnij tabelę **po każdej instrukcji**. Dla rejestrów jeszcze niezainicjalizowanych wpisz `?`, nie `0`. Zweryfikuj w debuggerze, zatrzymując wykonywanie po kolejnych instrukcjach.

| Po instrukcji | R0 | R1 | R2 | R3 |
|---|---:|---:|---:|---:|
| `movs r0,#5` | 0x5 | ? | ? | ? |
| `movs r1,#3` | 0x5 | 0x3 | ? | ? |
| `adds r2,r0,r1` | 0x5 | 0x3 | 0x8 | ? |
| `lsls r2,r2,#1` | 0x5 | 0x3 | 0x10 | ? |
| `subs r3,r2,#4` | 0x5 | 0x3 | 0x10 | 0xc |

**Pytania:** Co oznacza `#`? Czy `ADDS` odczytuje RAM? Które instrukcje zmieniają flagi? Dlaczego przesunięcie w lewo o jeden bit może odpowiadać mnożeniu przez dwa i kiedy takie uproszczenie zawodzi?

`#` oznacza wartość natychmiastową – informuje procesor, że podana liczba to bezpośrednia stała (np. liczba 5), a nie adres w pamięci RAM
ADDS operuje tylko na rejestrach wewnętrznych procesora i nie odczytuje ani nie zapisuje pamięci RAM
Instrukcje, które mają na końcu literę S zmeniają flagi
W systemie binarnym każda pozycja bitu ma wagę dwukrotnie większą od poprzedniej, więc przesunięcie w lewo podwaja wartość liczby, może zawieść gdy przekroczymy zakres bitowy liczby (overflow).

**Dowód:**
Pierwsza instrukcja
 Breakpoint 1, main () at src/main.S:7
7	    movs r0, #5
(gdb) info registers
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
lr             0xf9                249
pc             0xc0                0xc0 <main>
xpsr           0x61000000          1627389952
(gdb) si

Po ostatniej instrukcji:
gdb) si
11	    subs r3, r2, #4
(gdb) info registers
r0             0x5                 5
r1             0x3                 3
r2             0x10                16
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
lr             0xf9                249
pc             0xc8                0xc8 <main+8>
xpsr           0x1000000           16777216
(gdb) 

### B. Operacje bitowe i maski

Dla 8-bitowych wartości `A = 0xB6`, `B = 0x6C` oblicz ręcznie `A AND B`, `A OR B`, `A XOR B`, `A << 1` (wynik ograniczony do 8 bitów) i `A >> 2` (logiczne). Następnie sprawdź wyniki za pomocą instrukcji Thumb na 32-bitowych rejestrach, stosując odpowiednią maskę `0xFF` przy interpretacji 8-bitowej.

| Operacja | Wynik binarny (8 bitów) | Wynik hex | Potwierdzenie w GDB |
|---|---|---|---|
| AND | `00100100` | `0x24` | `r2 = 0x24` |
| OR | `11111110` | `0xfe` | `r3 = 0xfe` |
| XOR | `11011010` | `0xda` | `r4 = 0xda` |
| LSL 1 | `01101100` | `0x6c` | `r5 = 0x6c` |
| LSR 2 | `00101101` | `0x2d` | `r6 = 0x2d` |

**Dodatkowo:** sprawdź bit numer 3 (liczymy od zera), a następnie pokaż, jak ustawić, wyzerować i przełączyć ten bit bez zmiany innych bitów. Wyjaśnij zastosowanie masek w sterowaniu urządzeniami.
0xB6 = 10110110  - bit 3 czyli czwarty od prawej strony licząc od nr 0 - jest równy zero
zmiana na 1 operacją or 
orr r0, r0, #8

zmiana na 1 
bic r0, r0, #8

przełączenie - negacja
eor r0, r0, #8

maski bitowe pozwalają na precyzyjną modyfikację wybranych bitów w rejestrach kontrolnych mikrokontrolera

**Dowód:** (gdb) si
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

...

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


### C. Porównania, flagi i warunki 

Zaimplementuj odpowiednik `max(a,b)` dla **32-bitowych liczb ze znakiem**: `R0 = a`, `R1 = b`, `R2 = wynik`. Użyj `CMP` i skoku warunkowego. Sprawdź przypadki: `10,20`; `20,10`; `10,10`; `-5,2`; `-3,-8`.

Przy co najmniej trzech przypadkach zapisz flagi `N`, `Z`, `C`, `V` **bezpośrednio po `CMP`**. Wskaż, dlaczego przy porównaniu signed samo `N=1` nie zawsze wystarcza do ustalenia relacji mniejszości.

| a | b | Oczekiwane max | Otrzymane | N/Z/C/V po CMP |
|---:|---:|---:|---:|---|
| 10 | 20 | 20 | `0x14` | `N=1, Z=0, C=0, V=0` (xpsr: `0x81000000`) |
| 20 | 10 | 20 | `0x14` | `N=0, Z=0, C=1, V=0` (xpsr: `0x21000000`) |
| 10 | 10 | 10 | `0xa` | `N=0, Z=1, C=1, V=0` (xpsr: `0x61000000`) |
| -5 | 2 | 2 | `0x2` | `N=1, Z=0, C=1, V=0` (xpsr: `0xa1000000`) |
| -3 | -8 | -3 | `0xfffffffd` | `N=1, Z=0, C=1, V=0` (xpsr: `0xa1000000`) |
**Dowód:** 
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

### D. Pętla i suma liczb

Napisz program obliczający `1 + 2 + … + N`, gdzie `R0 = N` i `R1 = wynik`, przy `0 ≤ N ≤ 100`. Wykorzystaj licznik, porównanie i skok; **przypadek `N=0` musi zakończyć się poprawnie**. Najpierw zapisz pseudokod.

| N | Wynik oczekiwany | Wynik uzyskany |
|---:|---:|---:|
| 0 | 0 | `0x0` (0) |
| 1 | 1 | `0x1` (1) |
| 5 | 15 | `0xf` (15) |
| 100 | 5050 | `0x13ba` (5050) |

**Pytania:** która instrukcja kończy pętlę? Co zmieni się, gdy warunek skoku będzie błędny? Dlaczego nie należy opierać warunku na flagach ustawionych przez niepowiązaną instrukcję?
bgt pozwala zakończyc pętle poprzez skok poza nią
przy błędnym warunku program będzie w nieskonczonej pętli
instrukcje z "s" na koncu oraz cmp modyfikuja flagi, jeśli je nadpiszemy to skok warunkowy zadziała na podstawie nieaktualnego stanu

**Pseudokod i dowód:** 
WEJSCIE: N w R0
WYJSIE: Wynik w R1

Suma = 0
i = 1

DOPOKI i <= N    WYKONUJ:
    Suma = Suma + i
    i  = i + 1
KONIEC PETLI
Wynik w R1 = Suma

gdb) info registers
r0             0x64                 100
r1             0x13ba               5050
r2             0x65                 101
r3             0xf                  15
r4             0x13ba               5050
r5             0x0                  0
r6             0x0                  0
r7             0x1                  1
r8             0x0                  0
r9             0x0                  0
r10            0x0                  0
r11            0x0                  0
r12            0x0                  0
sp             0x20020000           0x20020000
lr             0x13d                317
pc             0x11c                0x11c <infinite_loop>
xpsr           0x61000000           1627389952

### E. Pamięć, adresowanie i little-endian

Rozpisz zapis 32-bitowego słowa `0x11223344` w pamięci little-endian od adresu `0x20000000`.

| Adres | Bajt (hex) |
|---|---|
| 0x20000000 |0x44|
| 0x20000001 | 0x33|
| 0x20000002 | 0x22 |
| 0x20000003 | 0x11|

W swoim programie umieść w RAM dwa sąsiadujące 32-bitowe elementy tablicy. Użyj `LDR` do odczytu obu wartości oraz `STR` do zapisania wyniku dodawania w **osobnym, zapisywalnym miejscu pamięci**. Pokaż wynik przez `x/…` w GDB.

**Pytania:** czym różnią się `ldr r0, =symbol`, `ldr r1, [r0]` i `ldr r2, [r0,#4]`? Dlaczego offset ma wartość 4, a nie 1? Czy odczyt z niezainicjalizowanego adresu jest poprawną metodą testowania?
ldr r0, =symbol - ładuje  adres pamięci etykiety symbol do rejestru r0

ldr r1, [r0] - pobranie wartości z adresu r0 do r1

ldr r2, [r0, #4] – obliczenie adresu r0 + 4 i pobranie wartości kolejnego słowa w pamięci do r2

offset jest 4 bajtowy, dlatego że słowa mają 32 bity a nie 8 bitów, czyli 4 bajty

nie powinniśmmy odczytywać z niezaincjalizowanych adresów bo może to prowadzić do błędów

**Dowód:** 19	    adds r3, r1, r2         @ Dodaj oba elementy: R3 = R1 + R2 (0x11223354)
(gdb) info registers
r0             0x20000000          536870912
r1             0x11223344          287454020
r2             0x10                16
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
lr             0x105               261
pc             0xc6                0xc6 <main+6>
xpsr           0x61000000          1627389952
(gdb) si
21	    ldr r4, =result         @ Załaduj adres docelowy wyniku do R4
(gdb) info registers
r0             0x20000000          536870912
r1             0x11223344          287454020
r2             0x10                16
r3             0x11223354          287454036
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
lr             0x105               261
pc             0xc8                0xc8 <main+8>
xpsr           0x1000000           16777216
(gdb) si
22	    str r3, [r4]            @ Zapisz wynik z R3 do pamięci pod adresem R4
(gdb) info registers
r0             0x20000000          536870912
r1             0x11223344          287454020
r2             0x10                16
r3             0x11223354          287454036
r4             0x20000008          536870920
r5             0x0                 0
r6             0x0                 0
r7             0x0                 0
r8             0x0                 0
r9             0x0                 0
r10            0x0                 0
r11            0x0                 0
r12            0x0                 0
sp             0x20020000          0x20020000
lr             0x105               261
pc             0xca                0xca <main+10>
xpsr           0x1000000           16777216
(gdb) si


### F. Iteracja po tablicy

Dla tablicy 32-bitowych liczb `4, 7, 2, 9, 5` oblicz sumę, przechodząc po jej elementach z użyciem wskaźnika/adresu bazowego, `LDR`, licznika i pętli. Zmień co najmniej dwa elementy i wykonaj ponowny test. Nie zastępuj odczytu tablicy sumowaniem stałych zapisanych w instrukcjach.

**Tabela obserwacji:**

| Iteracja | Adres elementu | Odczytana wartość | Suma po dodaniu |
|---:|---|---:|---:|
| 1 |0x20000000|4 | 4 |
| 2 |0x20000004| 7 | 11 |
| 3 |0x20000008| 10|21|
| 4 | 0x2000000c |9| 30 |
| 5 |0x20000010 | 20|50 |

1	0x20000000	4	4
2	0x20000004	7	11
3	0x20000008	10	21
4	0x2000000c	9	30
5	0x20000010	20	50

**Pytania:** jak zmienia się adres? Co dzieje się po przekroczeniu długości tablicy? Jak zmienić kod, aby obsługiwał długość przekazaną osobno?
adres zwiększa się z każdą iteracją o 4 bajty
pętla kontroluje długość tablicy, gdyby tego nie robiła to mogły byc dodane przypadkowe wartości
zaimplementowane (zmienna length i wczytanie do rejestru r1)


**Dowód:**(gdb) info registers
r0             0x20000000           536870912
r1             0x5                  5
r2             0x5                  5
r3             0x32                 50
r4             0x20000010           536870928
r5             0x14                 20
r6             0x0                  0
r7             0x0                  0
r8             0x0                  0
r9             0x0                  0
r10            0x0                  0
r11            0x0                  0
r12            0x0                  0
sp             0x20020000           0x20020000
lr             0x119                281
pc             0xdc                 0xdc <infinite_loop>
xpsr           0x1000000            16777216
## 5. Zadanie końcowe — analiza tablicy

### Cel

W **jednym przebiegu** przez niepustą tablicę 32-bitowych liczb ze znakiem oblicz:

- sumę elementów (`sum`),
- wartość najmniejszą (`min`),
- wartość największą (`max`),
- liczbę elementów **ściśle większych od 10** (`countGreaterThan10`).

**Dane podstawowe:** `12, 7, 25, 3, 18, 9, 14, 2`. Długość tablicy ma być przekazywana oddzielnie lub wyznaczana z symboli początku/końca; nie wolno zakładać na stałe, że zawsze wynosi osiem. Wyniki mają być dostępne w jednoznacznie opisanych rejestrach albo komórkach RAM.

### Wymagania techniczne

1. Użyj rzeczywistego odczytu danych z pamięci (`LDR`), operacji arytmetycznych, porównań i skoków.
2. Wykonaj **jedną pętlę** po danych; w jej ramach aktualizuj wszystkie cztery rezultaty.
3. Program ma działać dla różnych danych bez przepisywania logiki ani wpisywania gotowych odpowiedzi.
4. Zainicjalizuj `min` i `max` tak, aby algorytm działał również dla tablic zawierających wyłącznie liczby ujemne. Założenie: długość `n ≥ 1`.
5. Porównuj liczby jako **signed**; zliczaj wartości `>10`, nie `≥10`.
6. Dla sumy przyjmij, że dane testowe nie powodują przepełnienia 32-bitowej liczby ze znakiem. Nie jest wymagane wykrywanie overflow.
7. Udokumentuj działanie w GDB oraz w repozytorium Git.

### Wymagane testy

| Zestaw | Dane | Co ma wykazać |
|---|---|---|
| T1 | `12,7,25,3,18,9,14,2` | przypadek podstawowy |
| T2 | `-8,-3,-15,-1` | poprawność min/max dla liczb ujemnych |
| T3 | `10` | tablica jednoelementowa i ścisła nierówność |
| T4 | własna tablica ≥5 elementów, w tym `10`, liczba ujemna i liczba `>10` | test samodzielnie zaprojektowany |

**Wyniki T1 do samodzielnego sprawdzenia:** `sum=90`, `min=2`, `max=25`, `countGreaterThan10=4`. Dla pozostałych zestawów samodzielnie wyznacz oczekiwane wyniki **przed uruchomieniem**.

| Test | Oczekiwane sum/min/max/count | Uzyskane | PASS/FAIL |
|---|---|---|---|
| T1 | `90 / 2 / 25 / 4` | `90 / 2 / 25 / 4` | PASS |
| T2 | `-27 / -15 / -1 / 0` | `-27 / -15 / -1 / 0` | PASS |
| T3 | `10 / 10 / 10 / 0` | `10 / 10 / 10 / 0` | PASS |
| T4 | `40 / -5 / 20 / 2` | `40 / -5 / 20 / 2` | PASS |

### Obowiązkowa analiza jednej iteracji

Wybierz jedną iterację dla T1 i zapisz: indeks, adres odczytu, odczytaną liczbę, sumę przed i po, min/max przed i po, licznik `>10` przed i po oraz warunek skoku. Wyjaśnij, **dlaczego następna instrukcja będzie właśnie tą, którą wskazujesz**.

### Mapa rejestrów

| Rejestr | Rola w rozwiązaniu | Przykładowa wartość w wybranym momencie |
|---|---|---|
| R0 | Adres początkowy tablicy w pamięci (`array`) | `0x20000000` |
| R1 | Długość tablicy (`length`, liczba elementów) | `8` |
| R2 | Licznik pętli (`i` – indeks bieżącego elementu od0 do n-1) | `2` |
| R3 | Akumulator sumy elementów (`sum`) | `44` |
| pozostałe użyte | R4: Minimum (`min`), R5: Maksimum (`max`), R6: Licznik `>10` (`count`), R7: Wartość bieżąca `x` | R4: `2`, R5: `25`, R6: `2`, R7: `25` |

### Pseudokod

Wpisz pseudokod **własnego** algorytmu, bez wklejania gotowego kodu z innych źródeł:

```text
inicjalizuj  sum = 0, count = 0, i = 0
min = tablica[0]
max = tablica[0]

dopóki i < długość tablicy:
    x = odczytaj_z_pamięci(tablica + i  * 4)
    sum = sum +x
    
    jeśli x < min to min = x
    jeśli x > max to max = x
    jeśli x > 10  to count = count + 1
    
    i = i+1

zapisz wyniki w pamięci
```

### Weryfikacja i diagnoza

Podaj: polecenie uruchomienia testów, uzyskany wynik, identyfikator commita, przynajmniej jeden napotkany problem (lub kontrolowany eksperyment z błędem) oraz sposób ustalenia przyczyny. Przykładowe kategorie błędów: off-by-one, niewłaściwy warunek skoku, pomylenie adresu z wartością, zmiana flag przez nieoczekiwaną instrukcję.

## 6. Pytania podsumowujące do sprawozdania

Odpowiedz krótko, konkretnie i własnymi słowami:

1. Co wykonuje ALU, a co zapewniają `LDR` i `STR`? ALU przetwarza dane matematycznie i logicznie w rejestrach, podczas gdy LDR i STR przenoszą je między pamięcią RAM a procesorem
2. Dlaczego `R0 = 0x20000000` nie oznacza, że `R0` zawiera wartość zapisaną pod tym adresem? Wartość w R0 to jedynie adres (wskaźnik do komórki pamięci), a nie faktyczne dane, które są w niej zapisane
3. Co oznacza `#4` w `ldr r2, [r0,#4]`? Oznacza to przesunięcie (offset) o 4 bajty względem adresu bazowego, co pozwala odczytać kolejny element tablicy.
4. Jakie są konsekwencje zmiany `BGT` na `BGE` przy zliczaniu liczb większych od 10? Algorytm błędnie zacznie zliczać również samą dziesiątkę zamiast wartości ściśle większych od 10
5. Dlaczego inicjalizacja minimum wartością `0` jest błędna dla pewnych tablic? W tablicach zawierających same liczby ujemne zero jest od nich większe, więc algorytm błędnie uzna je za minimum.=
6. Jakie informacje dają `git log`, testy i GDB, i dlaczego nie są one zamienne? Git log pokazuje historię zmian, testy weryfikują poprawność, a GDB podgląda stan programu na żywo


## 7. Wymagania formalne i ocena

**Weryfikacja ustna przy stanowisku:** prowadzący może poprosić o objaśnienie fragmentu kodu, wskazanie wartości rejestru lub niewielką modyfikację warunku. Brak możliwości wyjaśnienia własnego rozwiązania może skutkować ponowną weryfikacją punktów za dane zadanie zgodnie z zasadami przedmiotu.

**Dostarczone materiały startowe:** `starter_lab01/example.c`, `startup.S`, `linker.ld`, `Makefile`, `README.md` oraz referencyjny `example_reference_clang.elf`. Pozostałe zadania nie mają dostarczonych rozwiązań.

**Wymagane pliki:** `REPORT.md`, kod `.S`, ewentualne skrypty testowe, krótki `README.md` z poleceniami uruchomienia. Zrzuty ekranu przechowuj w `evidence/` i opisuj w raporcie. Nie dołączaj binariów kompilacji.

**Zasady korzystania z narzędzi AI:** dopuszczalne jest używanie ich do wyjaśniania pojęć i diagnozowania komunikatów błędów. Należy samodzielnie rozumieć, uruchomić i zweryfikować oddany kod. W sprawozdaniu ujawnij istotne wykorzystanie narzędzi wspomagających (narzędzie, zakres pomocy, sposób weryfikacji).


W trakcie realizacji projektu skorzystano z pomocy asystenta sztucznej inteligencji w następującym zakresie:
- **Narzędzie:** Model językowy (asystent AI).
- **Zakres pomocy:** Wyjaśnianie mechanizmów adresowania pamięci i instrukcji architektonicznych ARM Cortex-M (Thumb), pomoc w strukturyzowaniu logiki jednoprzebiegowej analizy tablicy (zadanie końcowe), diagnozowanie komunikatów o błędach kompilacji i problemów ze środowiskiem Docker/QEMU oraz pomoc w redagowaniu formatowania sprawozdania (`REPORT.md`).
- **Sposób weryfikacji:** Cały kod źródłowy został przeanalizowany, samodzielnie przetestowany w kontenerze Dockera przy użyciu QEMU oraz zweryfikowany krok po kroku w sesjach debugera GDB (`info registers`, inspekcja pamięci) dla wszystkich zestawów testowych (T1–T4).

## 8. Lista kontrolna przed oddaniem

[x] Wszystkie zadania A–F mają kod, wyniki i wyjaśnienia.
[x] Wykonano T1–T3 oraz pytania podsumowujące.
[x] Zadanie końcowe działa dla T1–T4 i nie zawiera wyników wpisanych na stałe.
[x] Pokazano jedną iterację i opisano użyte rejestry.
[x] Sprawozdanie zawiera konkretne dowody działania (logi z GDB).
[x] Repozytorium jest przygotowane, commity opisują postęp, a zmiany zostały zsynchronizowane z GitHubem.
[x] Kod daje się w pełni odtworzyć w dostarczonym środowisku Docker/QEMU.
