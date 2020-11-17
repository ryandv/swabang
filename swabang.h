#include <stdint.h>

extern void ws2812b_send(uint8_t* buf, uint8_t len);
extern void ws2812b_color(uint8_t red, uint8_t green, uint8_t blue);
extern void ws2812b_reset();
