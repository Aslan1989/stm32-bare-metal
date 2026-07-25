#ifndef GPIO_H
#define GPIO_H

void gpio_init(void);
void gpio_set_pin(GPIO_TypeDef *GPIOx, uint8_t pin);
void gpio_clear_pin(GPIO_TypeDef *GPIOx, uint8_t pin);

#endif // GPIO_H