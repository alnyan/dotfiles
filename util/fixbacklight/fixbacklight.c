#include <stdlib.h>
#include <stdio.h>
#include <ctype.h>

#define BACKLIGHT "/sys/class/backlight/intel_backlight"
#define MAX       4438
#define MIN       200

static int get_backlight(void) {
    char buf[12];
    int res;
    FILE *fp = fopen(BACKLIGHT "/brightness", "r");
    if (!fp) {
        perror(BACKLIGHT "/brightness");
        return -1;
    }
    fread(buf, 1, sizeof(buf), fp);
    sscanf(buf, "%d", &res);
    return res;
}

static int set_backlight(int value) {
    FILE *fp = fopen(BACKLIGHT "/brightness", "w");
    if (!fp) {
        perror(BACKLIGHT "/brightness");
        return -1;
    }
    fprintf(fp, "%d", value);
    return 0;
}

int main(int argc, char **argv) {
    if (argc == 1) {
        // $ fixbacklight
        int r = get_backlight();
        if (r >= 0) {
            printf("%d\n", r);
        }
        return r == -1;
    } else if (argc == 2) {
        // $ fixbacklight NNN
        // $ fixbacklight +NNN
        // $ fixbacklight -NNN

        if (isdigit(argv[1][0])) {
            return set_backlight(atoi(argv[1]));
        } else if (argv[1][0] == '+' || argv[1][0] == '-') {
            int v = atoi(&argv[1][1]);
            if (argv[1][0] == '-') {
                v = -v;
            }
            int c = get_backlight();
            if (c < 0) {
                return -1;
            }
            c += v;
            if (c < MIN) {
                c = MIN;
            }
            if (c > MAX) {
                c = MAX;
            }
            return set_backlight(c + v);
        }
    }

    return 0;
}
