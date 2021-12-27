#line 6 "3_creating-matrices.md"
#include "matrix.h"
#line 8 "2_ppm.md"
#include "ppm.h"
#line 6 "2_representing-colors.md"
#include "color.h"
#line 8 "1_tuples.md"
#include "tuple.h"
#line 10 "README.md"
static void run_tests() {
	// unit-tests
#line 9 "3_creating-matrices.md"
	matrix_tests();
#line 11 "2_ppm.md"
	ppm_tests();
#line 9 "2_representing-colors.md"
	color_tests();
#line 11 "1_tuples.md"
	tuple_tests();
#line 12 "README.md"
}

int main(int argc, char **argv) {
	run_tests();
}
