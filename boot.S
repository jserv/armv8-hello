#include "reg.h"

.text

.globl	_start
_start:
	/* init UART (38400 8N1) */
	ldr	x4, =UART_BASE		// UART base
	mov	w5, #0x10		// IBRD
	str	w5, [x4, #0x24]
	mov	w5, #0xc300
	orr	w5, w5, #0x0001		// CR
	str	w5, [x4, #0x30]

	/* check CPU ID */
	mrs x0, mpidr_el1
	tst x0, #15
	b.ne    other_cpu

boot_cpu:
	/* configure stack */
	adrp x0, stacktop
	mov sp, x0

	b main

other_cpu:
	b other_cpu
