#include "reg.h"

.text

.globl	_start
_start:
	/* configure stack */
	adrp	x2, stackend	
	mov	x1, #4096	
	bl	smp_id
	mul	x1, x1, x0
	sub	x2, x2, x1
	mov	sp, x2

	/* check CPU ID */
	mrs x0, mpidr_el1
	tst x0, #15
	b.ne    other_cpu_spin

boot_cpu:
	/* init UART (38400 8N1) */
	ldr	x4, =UART_BASE		// UART base
	mov	w5, #0x10		// IBRD
	str	w5, [x4, #0x24]
	mov	w5, #0xc300
	orr	w5, w5, #0x0001		// CR
	str	w5, [x4, #0x30]
	
	b main

other_cpu_spin:
	adr	x0, other_cpu_spin_loc
	sevl
1:	wfe
	ldr	x1, [x0]
	cmp	x1, xzr
	beq	1b
	adr	x0, banner_cores
	bl	puts	
	b	other_cpu
	
other_cpu:
	b	. 
	
	.global smp_id
smp_id:
	mrs	x0, mpidr_el1
	and	x0, x0, #0xff00
	ret

	.global	other_cpu_spin_loc
other_cpu_spin_loc:
	.dword 0

banner_cores:
	.ascii "secondary cpus: Hello\n"
	.dword 0x0
	.align 3
