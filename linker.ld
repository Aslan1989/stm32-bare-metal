MEMORY
{
	FLASH (rx) : ORIGIN = 0x08000000, LENGTH = 128K
	RAM (rwx) : ORIGIN = 0x20000000, LENGTH = 20K
}

_estack = ORIGIN(RAM) + LENGTH(RAM);
SECTIONS
{
	.isr_vector :
	{
		*(.isr_vector)
	} > FLASH

	.text :
	{
		*(.text)
		*(.rodata)
	} > FLASH

	.data :
	{
		*(.data)
	} > RAM

	.bss :
	{
		*(.bss)
		*(COMMON)
	} > RAM
}