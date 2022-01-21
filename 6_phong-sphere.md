# Rendering a Phong Sphere

New rendering in `raytracer.cpp`:

```c++
// ...
	#if MAIN
	auto ray_origin { mk_point(0, 0, -5) };
	float wall_z { 10 };
	float wall_size { 7 };
	int canvas_pixels { 100 };
	float pixel_size { wall_size / canvas_pixels };
	float half { wall_size / 2 };
	// Color red { 1, 0, 0 };
	Color black { 0, 0, 0 };
	Sphere shape;
	shape.material.color = { 1, 0.2, 1 };
	Point_Light light {
		mk_point(-10, 10, -10),
		{ 1, 1, 1 }
	};
	std::ofstream o("phong-ball.ppm");
	mk_ppm(o, canvas_pixels, canvas_pixels,
		[&](int x, int y) {
			float world_y { half - pixel_size * y };
			float world_x { -half + pixel_size * x };
			auto pos { mk_point(world_x, world_y, wall_z) };
			Ray r { ray_origin, norm(pos - ray_origin) };
			auto xs { shape.intersect(r) };
			auto i { hit(xs) };
			if (i == xs.end()) { return black; }
			auto hp { r.pos(i->t) };
			auto n { i->object->normal_at(hp) };
			auto e { -r.direction };
			auto c { lighting(i->object->material, light, hp, e, n) };
			return c;
		}
	);
	#elif 0
// ...
```
