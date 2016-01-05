#include "reg.h"

int puts(const char *str)
{
	while (*str)
		*((unsigned int *) UART_BASE) = *str++;
	return 0;
}

void main(void)
{
	puts("Hello\n");
	while (1);
}
