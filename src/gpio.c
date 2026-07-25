#include "stm32f103.h"
#include "gpio.h"

void gpio_init(void)
{
	// Implementation for GPIO initialization
	RCC->APB2ENR |= RCC_APB2ENR_IOPAEN; // Enable GPIOA clock

	// PA5 as output (push-pull, max speed 2 MHz)
	GPIOA->CRL &= ~(0xF << 20); // Clear CNF and MODE bits for PA5
	GPIOA->CRL |= (0x1 << 20); // Set MODE bits for PA5
}

// Set the specified pin
void gpio_set_pin(GPIO_TypeDef *gpio, uint8_t pin)
{
	gpio->BSRR = (1U << pin); // Set the specified pin
}

// Clear the specified pin
void gpio_clear_pin(GPIO_TypeDef *gpio, uint8_t pin)
{
	gpio->BSRR = (1U << (pin + 16)); // Clear the specified pin
}

void gpio_toggle_pin(GPIO_TypeDef *gpio, uint8_t pin)
{
	gpio->ODR ^= (1U << pin); // Toggle the specified pin
}