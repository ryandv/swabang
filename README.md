# swabang

A minimal starter kit for programming WS2812b LEDs with AVR Libc on the Arduino Uno/ATmega328P microcontroller.

Includes:

* Inline AVR assembly macros for the WS2812b data protocol
* Makefile for building and flashing the Arduino Uno ROM

## Prerequisites

You will require the following:

* avr-libc
* avr-gcc
* avr-objcopy
* avrdude

You may need to add yourself to the `uucp` group to read/write from serial ports:

```sh
usermod -a -G uucp yourself
```

## Usage

Include the `swabang.h` header & write an entry point:

```sh
$ echo '#include "swabang.h"
> int main()
> {
>         while (1) {
>                 DDRB |= _BV(DDB0);
>                 ws2812b_reset(PORTB, PORTB0);
> 
>                 ws2812b_one(PORTB, PORTB0);
>                 ws2812b_one(PORTB, PORTB0);
>                 ws2812b_one(PORTB, PORTB0);
>                 ws2812b_one(PORTB, PORTB0);
>                 ws2812b_one(PORTB, PORTB0);
>                 ws2812b_one(PORTB, PORTB0);
>                 ws2812b_one(PORTB, PORTB0);
>                 ws2812b_one(PORTB, PORTB0);
> 
>                 ws2812b_zero(PORTB, PORTB0);
>                 ws2812b_zero(PORTB, PORTB0);
>                 ws2812b_zero(PORTB, PORTB0);
>                 ws2812b_zero(PORTB, PORTB0);
>                 ws2812b_zero(PORTB, PORTB0);
>                 ws2812b_zero(PORTB, PORTB0);
>                 ws2812b_zero(PORTB, PORTB0);
>                 ws2812b_zero(PORTB, PORTB0);
> 
>                 ws2812b_zero(PORTB, PORTB0);
>                 ws2812b_zero(PORTB, PORTB0);
>                 ws2812b_zero(PORTB, PORTB0);
>                 ws2812b_zero(PORTB, PORTB0);
>                 ws2812b_zero(PORTB, PORTB0);
>                 ws2812b_zero(PORTB, PORTB0);
>                 ws2812b_zero(PORTB, PORTB0);
>                 ws2812b_zero(PORTB, PORTB0);
>         }
> }' > main.c
```

Build the application and upload it to the Arduino. Here we assume the device file `/dev/ttyACM0` is connected to the Arduino's serial port:

```sh
make MAIN_FILE=main.c AVRDUDE_PORT=/dev/ttyACM0
```
