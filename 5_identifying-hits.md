# Identifying Hits

Test for two hits in`sphere.h`:

```c++
// ...
	// sphere-tests
	{ // two positive intersections
		Sphere s;
		Intersection i1 { 1.0f, &s };
		Intersection i2 { 2.0f, &s };
		Intersections xs { i2, i1 };
		auto i { hit(xs) };
		assert(*i == i1);
	}
// ...
```

Define `hit` function:

```c++
// ...
class Intersections: public std::vector<Intersection> {
	// ...
};
inline auto hit(Intersections &xs) {
	for (auto i = xs.begin(); i != xs.end(); ++i) {
		if (i->t >= 0.0f) { return i; }
	}
	return xs.end();
}
// ...
```

Define equality for `Intersection`:

```c++
// ...
struct Intersection {
	// ...
};
inline constexpr bool operator==(const Intersection &a, const Intersection &b) {
	return a.object == b.object && eq(a.t, b.t);
}
// ...
```

Test with one negative intersection:

```c++
// ...
	// sphere-tests
	{ // one negative intersection
		Sphere s;
		Intersection i1 { -1.0f, &s };
		Intersection i2 { 1.0f, &s };
		Intersections xs { i2, i1 };
		auto i { hit(xs) };
		assert(*i == i2);
	}
// ...
```

Test with only negative intersections:

```c++
// ...
	// sphere-tests
	{ // only negative intersections
		Sphere s;
		Intersection i1 { -2.0f, &s };
		Intersection i2 { -1.0f, &s };
		Intersections xs { i2, i1 };
		auto i { hit(xs) };
		assert(i == xs.end());
	}
// ...
```

Test that the lowest non-negative intersection is chosen:

```c++
// ...
	// sphere-tests
	{ // lowest non-negative
		Sphere s;
		Intersection i1 { 5.0f, &s };
		Intersection i2 { 7.0f, &s };
		Intersection i3 { -3.0f, &s };
		Intersection i4 { 2.0f, &s };
		Intersections xs { i1, i2, i3, i4 };
		auto i { hit(xs) };
		assert(*i == i4);
	}
// ...
```

```
@Add(unit-tests) {
	auto o { mk_point(1, 2, 3) };
	auto d { mk_vector(0, 1, 0) };
	Ray r { o, d };
	auto m { translation(3, 4, 5) };
	auto r2 { transform(r, m) };
	auto eo { mk_point(4, 6, 8) };
	assert(r2.origin == eo);
	assert(r2.direction == d);
} @End(unit-tests)
```

```
@Add(unit-tests) {
	auto o { mk_point(1, 2, 3) };
	auto d { mk_vector(0, 1, 0) };
	Ray r { o, d };
	auto m { scaling(2, 3, 4) };
	auto r2 { transform(r, m) };
	auto eo { mk_point(2, 6, 12) };
	auto ed { mk_vector(0, 3, 0) };
	assert(r2.origin == eo);
	assert(r2.direction == ed);
} @End(unit-tests)
```

```
@Add(unit-tests) {
	Sphere s;
	assert(s.transform == identity);
} @End(unit-tests)
```

```
@Add(unit-tests) {
	Sphere s;
	auto m { translation(2, 3, 4) };
	s.transform = m;
	s.inv_transform = inv(m);
	assert(s.transform == m);
} @End(unit-tests)
```

```
@Add(unit-tests) {
	auto o { mk_point(0, 0, -5) };
	auto d { mk_vector(0, 0, 1) };
	Ray r { o, d };
	Sphere s;
	s.transform = scaling(2, 2, 2);
	s.inv_transform = inv(s.transform);
	auto xs { s.intersect(r) };
	assert(xs.size() == 2);
	assert_eq(xs[0].t, 3);
	assert_eq(xs[1].t, 7);
} @End(unit-tests)
```

```
@Add(unit-tests) {
	auto o { mk_point(0, 0, -5) };
	auto d { mk_vector(0, 0, 1) };
	Ray r { o, d };
	Sphere s;
	s.transform = translation(5, 0, 0);
	s.inv_transform = inv(s.transform);
	auto xs { s.intersect(r) };
	assert(xs.size() == 0);
} @End(unit-tests)
```

```
@Add(includes)
	#include <fstream>
@End(includes)
```

```
@Add(main)
	#if 0
	auto ray_origin { mk_point(0, 0, -5) };
	float wall_z { 10 };
	float wall_size { 7 };
	int canvas_pixels { 100 };
	float pixel_size { wall_size / canvas_pixels };
	float half { wall_size / 2 };
	Color red { 1, 0, 0 };
	Color black { 0, 0, 0 };
	Sphere shape;
	std::ofstream o("ball.ppm");
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
	#endif
@End(main)
```
