#ifndef GPIO_H
#define GPIO_H

void gpio_init(void);
void gpio_set_pin(GPIO_TypeDef *gpio, uint8_t pin);
void gpio_clear_pin(GPIO_TypeDef *gpio, uint8_t pin);
void gpio_toggle_pin(GPIO_TypeDef *gpio, uint8_t pin);

#endif // GPIO_H