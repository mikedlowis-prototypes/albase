/* See LICENSE file for copyright and license details. */
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>

#include "../util.h"

unsigned long
estrtoul(const char *s, int base)
{
	char *end;
	unsigned long n;

	errno = 0;
	n = strtoul(s, &end, base);
	if (*end != '\0') {
		if (base == 0)
			eprintf("%s: not an integer\n", s);
		else
			eprintf("%s: not a base %d integer\n", s, base);
	}
	if (errno != 0)
		eprintf("%s:", s);

	return n;
}
