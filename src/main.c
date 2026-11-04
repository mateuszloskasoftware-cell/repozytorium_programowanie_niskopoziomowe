#include <stdint.h>

/* Semihosting: SYS_WRITE0 + SYS_EXIT via BKPT 0xAB */
static inline void sh_write0(const char *s) {
  __asm__ volatile (
    "mov r0, #4      \n\t"   /* SYS_WRITE0 */
    "mov r1, %0      \n\t"   /* r1 = s     */
    "bkpt 0xAB       \n\t"
    :
    : "r"(s)
    : "r0","r1","memory");
}

static inline void sh_exit(int code) {
  __asm__ volatile (
    "mov r0, #0x18   \n\t"   /* SYS_EXIT   */
    "mov r1, %0      \n\t"   /* r1 = code  */
    "bkpt 0xAB       \n\t"
    :
    : "r"(code)
    : "r0","r1","memory");
}

int main(void) {
  sh_write0("Hello world!\n");
  sh_exit(0);
  for(;;) {} /* never reached */
}