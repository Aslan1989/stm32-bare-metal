#include "stm32f103.h"
#include "timer.h"
#include "gpio.h"

void timer2_init(void)
{
    // Enable TIM2 clock
    RCC->APB1ENR |= (1U << 0);

    // Timer clock = 8 MHz
    // 8 MHz / 8000 = 1 kHz
    TIM2->PSC = 7999;

    // 1000 counts = 1 second
    TIM2->ARR = 999;

    // Enable update interrupt
    TIM2->DIER |= (1U << 0);

	// Enable TIM2 interrupt in NVIC
    NVIC_ISER0 = (1U << 28);

    // Start timer
    TIM2->CR1 |= (1U << 0);
}
void TIM2_IRQHandler(void)
{
    // Check update interrupt flag
    if (TIM2->SR & (1U << 0))
    {
        // Clear update interrupt flag
        TIM2->SR &= ~(1U << 0);

        // Toggle LED
        gpio_toggle_pin(GPIOA, GPIO_PIN_5);
    }
}