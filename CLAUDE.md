# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A bare-metal firmware learning project for the STM32F103 (Cortex-M3), built from scratch without any HAL/CMSIS library — all peripheral access is via manually defined register structs in `include/stm32f103.h`. Git history shows this is being built up incrementally as a study exercise (startup code → linker script → GPIO driver → symbolic constants → timer/interrupts), so prefer small, focused, well-explained changes over large rewrites, consistent with that progression.

## Build

```sh
make        # builds build/firmware.bin (and firmware.elf)
make clean  # removes the build/ directory
```

Requires the `arm-none-eabi-gcc` / `arm-none-eabi-objcopy` toolchain on PATH. Target flags: `-mcpu=cortex-m3 -mthumb -nostdlib`, linked with `linker.ld`.

There is no flash/debug target in the Makefile and no test suite — nothing to run beyond `make`. If asked to flash the board or set up debugging, it will need to be added (e.g. OpenOCD/st-flash + gdb), don't assume it already exists.

When adding a new source file, it must be added to both `SRCS` and `OBJ` in the `Makefile`, and to the header-dependency line for any `.o` rule that includes it.

## Architecture

- **`startup/startup.s`** — Reset/interrupt vector table (`.isr_vector` section) and `Reset_Handler`, which simply branches to `main`. The vector table is a flat list of `.word` entries: stack pointer, then one word per exception/IRQ; unused vectors are `0`. Handler addresses must have their Thumb bit set (`Handler + 1`), and any new IRQ handler must be added at its correct index (see the "IRQ 28 = TIM2" comment for the pattern) and declared `.global`.
- **`linker.ld`** — Defines the memory map (FLASH at `0x08000000`/128K, RAM at `0x20000000`/20K), places `.isr_vector` at the start of FLASH, `.text`/`.rodata` in FLASH, `.data`/`.bss` in RAM, and sets `_estack` to the top of RAM.
- **`include/stm32f103.h`** — Central peripheral register map: each peripheral (RCC, GPIOA, TIM2, ...) is a `typedef struct` of `volatile uint32_t` registers matching the datasheet layout, plus a base-address cast macro (e.g. `#define RCC ((RCC_TypeDef *) RCC_BASE)`) and bit-position/mask `#define`s for the fields actually in use. When adding support for a new register field, follow the existing naming convention: `<PERIPH>_<REG>_<FIELD>_Pos` / `_Msk`, and add a comment with the datasheet register name and offset.
- **`src/gpio.c`** / **`include/gpio.h`** — Minimal GPIO driver (init, set/clear/toggle pin) operating directly on the `GPIO_TypeDef` registers via `BSRR`/`ODR`.
- **`src/timer.c`** / **`include/timer.h`** — TIM2 setup (prescaler/auto-reload for a 1 Hz update interrupt) and the `TIM2_IRQHandler` interrupt handler, which must always check and clear the relevant status bit in `TIM2->SR` before acting.
- **`src/main.c`** — Entry point; calls peripheral `_init()` functions and spins in a `while(1)` loop. With interrupts driving behavior (e.g. LED toggling in `TIM2_IRQHandler`), the main loop is often intentionally empty.

## Conventions

- No CMSIS/HAL — all register access goes through the structs/macros in `stm32f103.h`. Don't introduce HAL calls or external dependencies.
- Bit manipulation uses explicit `(1U << n)`-style masks with named constants rather than magic numbers, matching existing definitions in `stm32f103.h`.
- Comments on register fields typically note the datasheet register name and byte offset (e.g. `// Control Register 0x00`) — follow this style for new struct fields.
