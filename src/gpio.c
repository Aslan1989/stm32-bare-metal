#include "stm32f103.h"
#include "gpio.h"

void gpio_init(void)
{
	// Implementation for GPIO initialization
	RCC->APB2ENR |= (1 << 2); // Enable GPIOA clock
}