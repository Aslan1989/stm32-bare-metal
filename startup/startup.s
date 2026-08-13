/* # Use unified ARM assembly syntax
.syntax unified

# Generate instructions for Cortex-M3
.cpu cortex-m3

# Use Thumb instruction set
.thumb

# Export Reset_Handler symbol for the linker
.global Reset_Handler

# _estack will be resolved by the linker
.global _estack

# Interrupt Vector Table a - allocatable
.section .isr_vector, "a"

.word _estack
.word Reset_Handler + 1

.text
.thumb

Reset_Handler:
	bl main

Loop:
	b Loop
*/

.syntax unified
.cpu cortex-m3
.thumb

.global Reset_Handler
.global TIM2_IRQHandler
.global _estack

.section .isr_vector, "a"

.word _estack
.word Reset_Handler + 1

/* Cortex-M3 system exceptions */
.word 0
.word 0
.word 0
.word 0
.word 0
.word 0
.word 0
.word 0
.word 0
.word 0
.word 0
.word 0
.word 0
.word 0

/* External interrupts 0-27 */
.word 0
.word 0
.word 0
.word 0
.word 0
.word 0
.word 0
.word 0
.word 0
.word 0
.word 0
.word 0
.word 0
.word 0
.word 0
.word 0
.word 0
.word 0
.word 0
.word 0
.word 0
.word 0
.word 0
.word 0
.word 0
.word 0
.word 0
.word 0

/* IRQ 28 = TIM2 */
.word TIM2_IRQHandler + 1

.text
.thumb

Reset_Handler:
    bl main

Loop:
    b Loop