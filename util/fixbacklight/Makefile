BIN?=/usr/local/bin

all: fixbacklight

fixbacklight: fixbacklight.c
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $<

install: fixbacklight
	install -m0755 fixbacklight $(BIN)/

install_rules: 10-backlight.rules
	install -m0644 10-backlight.rules /etc/udev/rules.d/
