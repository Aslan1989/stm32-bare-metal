#ifndef STM32F103_H
#define STM32F103_H

#include <stdint.h>

#define RCC_BASE 0x40021000UL // U-unsigned L-Long
#define GPIOA_BASE 0x40010800UL
#define USART2_BASE 0x40004400UL

typedef struct
{
	volatile uint32_t CR; // Control Register 0x00
	volatile uint32_t CFGR; // Configuration Register 0x04
	volatile uint32_t CIR; // Clock Interrupt Register 0x08
	volatile uint32_t APB2RSTR; // APB2 Peripheral Reset Register 0x0C
	volatile uint32_t APB1RSTR; // APB1 Peripheral Reset Register 0x10
	volatile uint32_t AHBENR; // AHB Peripheral Clock Enable Register 0x14
	volatile uint32_t APB2ENR; // APB2 Peripheral Clock Enable Register 0x18
	volatile uint32_t APB1ENR; // APB1 Peripheral Clock Enable Register 0x1C
	volatile uint32_t BDCR; // Backup Domain Control Register 0x20
	volatile uint32_t CSR; // Control/Status Register 0x24
} RCC_TypeDef;

#define RCC ((RCC_TypeDef *) RCC_BASE)

#endif // STM32F103_H