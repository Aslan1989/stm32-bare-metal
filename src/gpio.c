#include "stm32f103.h"
#include "gpio.h"

void gpio_init(void)
{
	// Implementation for GPIO initialization
	RCC->APB2ENR |= (1 << 2); // Enable GPIOA clock

	GPIOA->CRL &= ~(0xF << 20); // Clear CNF and MODE bits for PA5
	GPIOA->CRL |= (0x1 << 20); // Set MODE bits for
}

void gpio_set_pin(GPIO_TypeDef *GPIOx, uint8_t pin)
{
	GPIOx->BSRR = (1U << pin); // Set the specified pin
}

void gpio_clear_pin(GPIO_TypeDef *GPIOx, uint8_t pin)
{
	GPIOx->BSRR = (1U << (pin + 16)); // Clear the specified pin
}