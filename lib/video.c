unsigned char *videoram = (unsigned char *)0xB8000;
unsigned short vrpos = 0;

void clear() {
    short num = 80 * 50 * 2,
        i = 0;
    for (i = 0; i <= num; i += 2) {
        videoram[i] = 0x20;
    }
}

void print(char* string) {
    short i = 0;
    do {
        videoram[vrpos*2] = string[i];
        vrpos++;
        i++;
    } while ('\0' != string[i]);
}
