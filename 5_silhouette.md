# Putting it together

Render a silhouette of a ball in `raytracer.cpp`:

```c++
#include <fstream>
// ...
	#if MAIN
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
// ...
```
