CC = arm-none-eabi-gcc
AS = arm-none-eabi-gcc
OBJCOPY = arm-none-eabi-objcopy

BUILD = build

CFLAGS = -mcpu=cortex-m3 -mthumb -Wall -Wextra -g -O0

SRC = src/main.c
STARTUP = startup/startup.s

all: $(BUILD)/firmware.bin

OBJ = $(BUILD)/main.o \
	$(BUILD)/startup.o

$(BUILD)/main.o: src/main.c
	@mkdir -p $(BUILD)
	$(CC) $(CFLAGS) -c $< -o $@

$(BUILD)/startup.o: startup/startup.s
	mkdir -p $(BUILD)
	$(AS) $(CFLAGS) -c $< -o $@

$(BUILD)/firmware.elf: $(OBJ)
	$(CC) $(CFLAGS) \
	-nostdlib \
	-T linker.ld \
	$(OBJ) \
	-o $@

$(BUILD)/firmware.bin: $(BUILD)/firmware.elf
	$(OBJCOPY) -O binary $< $@

clean:
	rm -rf build