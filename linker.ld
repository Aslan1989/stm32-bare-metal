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
		KEEP(*(.isr_vector))
	} > FLASH

	.text :
	{
		*(.text)
		*(.text.*)
		*(.rodata)
		*(.rodata.*)
	} > FLASH

	.data :
	{
		*(.data)
		*(.data.*)
	} > RAM

	.bss :
	{
		*(.bss)
		*(.bss.*)
		*(COMMON)
	} > RAM
}