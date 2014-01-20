#include "video.h"
#include "io.h"
#include "clever.h"
#include "string.h"

int main(void) {
    clear();
    print("Welcome to DanOS32!");
    print(" Thanks for choosing us!");
    asm volatile ("int $0x3");
	asm volatile ("int $0x4");

    return 0;
}
