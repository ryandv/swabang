CC=avr-gcc
WFLAGS=-Wall -pedantic
CFLAGS=$(WFLAGS) -O2 -mmcu=atmega328p -DF_CPU=16000000UL

OBJCOPY=avr-objcopy
OBJCOPY_FLAGS=-O ihex -R .eeprom

AVRDUDE=avrdude
AVRDUDE_BAUD=115200
AVRDUDE_FLAGS=-c arduino -p ATMEGA328P -b $(AVRDUDE_BAUD)

headers=swabang.h
objects=swabang.o
binary=a.out
hexdump=a.hex

all: $(objects)

$(objects): %.o: %.S
ifndef SWABANG_BIT
		$(error SWABANG_BIT is undefined)
endif
ifndef SWABANG_PORT
		$(error SWABANG_PORT is undefined)
endif
	$(CC) $(CFLAGS) -DSWABANG_PORT=$(SWABANG_PORT) -DSWABANG_BIT=$(SWABANG_BIT) -c $< -o $@

$(hexdump): $(objects)
ifndef MAIN_FILE
		$(error MAIN_FILE is undefined)
endif
	$(CC) $(CFLAGS) -include $(headers) $(objects) $(MAIN_FILE) -o $(binary) && $(OBJCOPY) $(OBJCOPY_FLAGS) $(binary) $(hexdump)

flash: $(hexdump)
ifndef AVRDUDE_PORT
		$(error AVRDUDE_PORT is undefined)
endif
	$(AVRDUDE) $(AVRDUDE_FLAGS) -P $(AVRDUDE_PORT) -U flash:w:$(hexdump)

.PHONY: check-avrdude-port-defined check-main-defined clean

check-avrdude-port-defined:

check-main-defined:

clean:
	rm -f $(hexdump) $(binary) $(objects)
