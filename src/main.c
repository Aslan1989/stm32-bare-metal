#include "gpio.h"
#include "timer.h"

int main(void) {

	gpio_init(); // Initialize GPIO
	timer2_init(); // Initialize Timer 2
	while (1)
	{
		// gpio_toggle_pin(GPIOA, GPIO_PIN_5); // Toggle PA5
		
	}
}