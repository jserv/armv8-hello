#include "reg.h"

extern unsigned long other_cpu_spin_loc;

int puts(const char *str)
{
	while (*str)
		*((unsigned int *) UART_BASE) = *str++;
	return 0;
}

void main(void)
{
	puts("boot cpu: Hello\n");
		
	other_cpu_spin_loc = 1;
	/* sync*/
	asm volatile ("dsb sy" : : : "memory");	
	/* send an event to wake up other cpus*/	
	asm volatile ("sev");
	
	while (1);
}
