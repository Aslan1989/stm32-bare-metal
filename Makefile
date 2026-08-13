CC = arm-none-eabi-gcc
OBJCOPY = arm-none-eabi-objcopy

BUILD = build

CFLAGS = -mcpu=cortex-m3 -mthumb -Wall -Wextra -g -O0 -Iinclude

SRCS = \
    src/main.c \
    src/gpio.c \
    src/timer.c

OBJ = \
    $(BUILD)/main.o \
    $(BUILD)/gpio.o \
    $(BUILD)/timer.o \
    $(BUILD)/startup.o


all: $(BUILD)/firmware.bin


$(BUILD)/main.o: src/main.c include/gpio.h include/timer.h
	@mkdir -p $(BUILD)
	$(CC) $(CFLAGS) -c $< -o $@


$(BUILD)/gpio.o: src/gpio.c include/gpio.h
	@mkdir -p $(BUILD)
	$(CC) $(CFLAGS) -c $< -o $@


$(BUILD)/timer.o: src/timer.c include/timer.h include/gpio.h
	@mkdir -p $(BUILD)
	$(CC) $(CFLAGS) -c $< -o $@


$(BUILD)/startup.o: startup/startup.s
	@mkdir -p $(BUILD)
	$(CC) $(CFLAGS) -c $< -o $@


$(BUILD)/firmware.elf: $(OBJ)
	$(CC) $(CFLAGS) -nostdlib -T linker.ld $(OBJ) -o $@


$(BUILD)/firmware.bin: $(BUILD)/firmware.elf
	$(OBJCOPY) -O binary $< $@


clean:
	rm -rf $(BUILD)