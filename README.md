# swabang

A minimal starter kit for programming WS2812b LEDs with avr-libc on the Arduino Uno/ATmega328P microcontroller.

Includes:

* Assembly procedures for bit-banging the WS2812b data protocol
* Makefile for building and flashing the Arduino Uno ROM

## Prerequisites

You will require the following:

* avr-libc
* avr-gcc
* avr-objcopy
* avrdude

You may need to add yourself to the `uucp` group to read/write from/to serial ports:

```sh
$ usermod -a -G uucp yourself
```

## Usage

Choose an I/O port and bit number from <avr/iom328p.h>. This example assumes bit 0 of port B is chosen (pin 8 on the Uno R3).

Assemble procedures for the WS2812b data protocol:

```sh
$ make clean; make SWABANG_BIT=PORTB0 SWABANG_PORT=PORTB
$ file swabang.o
swabang.o: ELF 32-bit LSB relocatable, Atmel AVR 8-bit, version 1 (SYSV), not stripped
```

Write an entry point defining `main`:

```sh
$ echo '#include <avr/io.h>
> int main()
> {
>         DDRB |= _BV(DDB0);
>
>         while (1) {
>                 ws2812b_reset(PORTB, PORTB0);
>                 ws2812b_color(255, 0, 255);
>         }
> }' > main.c
```

Forward declarations for the ws2812b procedures will automatically be included into your program. See [swabang.h](./swabang.h) for a list of available procedures.

Build the application and flash it onto the Arduino. Here we assume the device file `/dev/ttyACM0` has been adequately permissioned and is connected to the Arduino's serial port:

```sh
make flash MAIN_FILE=main.c AVRDUDE_PORT=/dev/ttyACM0
```
