#include "gpio.h"

int main(void) {

	gpio_init(); // Initialize GPIO

	while (1)
	{
		gpio_toggle_pin(GPIOA, GPIO_PIN_5); // Toggle PA5
	}
}