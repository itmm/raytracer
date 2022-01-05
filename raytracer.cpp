#line 6 "./5_silhouette.md"
#include <fstream>
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
	#define MAIN 1
	#if MAIN
#line 9 "./5_silhouette.md"
		auto ray_origin { mk_point(0.0f, 0.0f, -5.0f) };
		float wall_z { 10.0f };
		float wall_size { 7.0f };
		int canvas_pixels { 100 };
		float pixel_size { wall_size / canvas_pixels };
		float half { wall_size / 2.0f };
		Color red { 1.0f, 0.0f, 0.0f };
		Color black { 0.0f, 0.0f, 0.0f };
		Sphere shape;
		std::ofstream o("silhouette.ppm");
		mk_ppm(o, canvas_pixels, canvas_pixels,
			[&](int x, int y) {
				float world_y { half - pixel_size * y };
				float world_x { -half + pixel_size * x };
				auto pos { mk_point(world_x, world_y, wall_z) };
				Ray r { ray_origin, norm(pos - ray_origin) };
				auto xs { shape.intersect(r) };
				return hit(xs) == xs.end() ? black : red;
			}
		);
	#elif 0
#line 18 "README.md"
	#endif
}
