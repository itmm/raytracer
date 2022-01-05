#line 7 "./5_intersect-sphere.md"
#include "sphere.h"
#line 6 "./5_creating-rays.md"
#include "ray.h"
#line 6 "./4_translation.md"
#include "transform.h"
#line 6 "./3_creating-matrices.md"
#include "matrix.h"
#line 8 "./2_ppm.md"
#include "ppm.h"
#line 6 "./2_representing-colors.md"
#include "color.h"
#line 8 "./1_tuples.md"
#include "tuple.h"
#line 10 "README.md"
static void run_tests() {
	// unit-tests
#line 10 "./5_intersect-sphere.md"
	sphere_tests();
#line 9 "./5_creating-rays.md"
	ray_tests();
#line 9 "./4_translation.md"
	transform_tests();
#line 9 "./3_creating-matrices.md"
	matrix_tests();
#line 11 "./2_ppm.md"
	ppm_tests();
#line 9 "./2_representing-colors.md"
	color_tests();
#line 11 "./1_tuples.md"
	tuple_tests();
#line 12 "README.md"
}

int main(int argc, char **argv) {
	run_tests();
}
