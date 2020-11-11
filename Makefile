CC=avr-gcc
WFLAGS=-Wall -pedantic
CFLAGS=$(WFLAGS) -O2 -mmcu=atmega328p -DF_CPU=16000000UL

OBJCOPY=avr-objcopy
OBJCOPY_FLAGS=-O ihex -R .eeprom

AVRDUDE=avrdude
AVRDUDE_BAUD=115200
AVRDUDE_FLAGS=-c arduino -p ATMEGA328P -b $(AVRDUDE_BAUD)

objects=swabang.o
binary=a.out
hexdump=a.hex

all: $(objects)

$(objects): %.o: %.S
	$(CC) $(CFLAGS) -c $< -o $@

$(hexdump): $(objects) check-main-defined
	$(CC) $(CFLAGS) $(objects) $(MAIN_FILE) -o $(binary) && $(OBJCOPY) $(OBJCOPY_FLAGS) $(binary) $(hexdump)

upload: $(hexdump) check-avrdude-port-defined
	$(AVRDUDE) $(AVRDUDE_FLAGS) -P $(AVRDUDE_PORT) -U flash:w:$(hexdump)

.PHONY: check-avrdude-port-defined check-main-defined clean

check-avrdude-port-defined:
ifndef AVRDUDE_PORT
		$(error AVRDUDE_PORT is undefined)
endif

check-main-defined:
ifndef MAIN_FILE
		$(error MAIN_FILE is undefined)
endif

clean:
	rm -f $(hexdump) $(binary) $(objects)
