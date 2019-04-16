# Rays and Spheres

```
@Add(types)
	struct Ray {
		Tuple origin;
		Tuple direction;
		@put(methods);
	};
@End(types)
```

```
@Add(unit-tests) {
	auto o { mk_point(1, 2, 3) };
	auto d { mk_vector(4, 5, 6) };
	Ray r { o, d };
	assert(r.origin == o);
	assert(r.direction == d);
} @End(unit-tests)
```

```
@def(methods)
	constexpr auto pos(float t) const;
@end(methods)
```

```
@Add(functions)
	constexpr auto Ray::pos(float t) const {
		return origin + t * direction;
	}
@End(functions)
```

```
@Add(unit-tests) {
	auto o { mk_point(2, 3, 4) };
	auto d { mk_vector(1, 0, 0) };
	Ray r { o, d };
	assert(r.pos(0) == o);
	auto e1 { mk_point(3, 3, 4) };
	assert(r.pos(1) == e1);
	auto e2 { mk_point(1, 3, 4) };
	assert(r.pos(-1) == e2);
	auto e3 { mk_point(4.5, 3, 4) };
	assert(r.pos(2.5) == e3);
} @End(unit-tests)
```

```
@Add(types)
	@Put(needed by object);
	struct Object {
		Matrix transform = identity;
		Matrix inv_transform = identity;
		@Put(object attribs);
	};
	struct Sphere: Object {
		@Put(sphere attribs);
	};
@End(types)
```

```
@Add(includes)
	#include <vector>
@End(includes)
```

```
@Def(needed by object)
	struct Object;
	struct Intersection {
		float t;
		Object *object;
	};
@End(needed by object)
```

```
@Add(needed by object)
	class Intersections:
		public std::vector<Intersection>
	{
		public:
			@put(xs methods);
	};
@End(needed by object)
```

```
@def(xs methods)
	Intersections(std::initializer_list<Intersection> l);
@end(xs methods)
```

```
@Add(functions)
	inline bool operator<(
		const Intersection &a,
		const Intersection &b
	) {
		return a.t < b.t;
	}
@End(functions)
```

```
@Add(includes)
	#include <algorithm>
@End(includes)
```

```
@Add(functions)
	Intersections::Intersections(std::initializer_list<Intersection> l): std::vector<Intersection>(l) {
		std::sort(begin(), end());
	}
@End(functions)
```

```
@Def(object attribs)
	virtual Intersections intersect(
		const Ray &r
	) = 0;
@End(object attribs)
```

```
@Def(sphere attribs)
	Intersections intersect(
		const Ray &r
	) override;
@End(sphere attribs)
```

```
@Add(functions)
	inline constexpr Ray transform(
		const Ray &r, const Matrix &m
	);

	Intersections Sphere::intersect(
		const Ray &r
	) {
		auto r2 { ::transform(r, inv_transform) };
		auto s2r { r2.origin - mk_point(0, 0, 0) };
		auto a { dot(r2.direction, r2.direction) };
		auto b { 2 * dot(r2.direction, s2r) };
		auto c { dot(s2r, s2r) - 1 };
		auto discr { b * b - 4 * a * c };
		if (discr < 0) { 
			return {};
		}
		auto sd { sqrtf(discr) };
		return {
			{(-b - sd)/(2 * a), this},
			{(-b + sd)/(2 * a), this}
		};
	}
@End(functions)
```

```
@Add(unit-tests) {
	auto o { mk_point(0, 0, -5) };
	auto d { mk_vector(0, 0, 1) };
	Ray r { o, d };
	Sphere s;
	auto xs { s.intersect(r) };
	assert(xs.size() == 2);
	assert_eq(xs[0].t, 4);
	assert_eq(xs[1].t, 6);
} @End(unit-tests)
```

```
@Add(unit-tests) {
	auto o { mk_point(0, 1, -5) };
	auto d { mk_vector(0, 0, 1) };
	Ray r { o, d };
	Sphere s;
	auto xs { s.intersect(r) };
	assert(xs.size() == 2);
	assert_eq(xs[0].t, 5);
	assert_eq(xs[1].t, 5);
} @End(unit-tests)
```

```
@Add(unit-tests) {
	auto o { mk_point(0, 2, -5) };
	auto d { mk_vector(0, 0, 1) };
	Ray r { o, d };
	Sphere s;
	auto xs { s.intersect(r) };
	assert(xs.size() == 0);
} @End(unit-tests)
```

```
@Add(unit-tests) {
	auto o { mk_point(0, 0, 0) };
	auto d { mk_vector(0, 0, 1) };
	Ray r { o, d };
	Sphere s;
	auto xs { s.intersect(r) };
	assert(xs.size() == 2);
	assert_eq(xs[0].t, -1);
	assert_eq(xs[1].t, 1);
} @End(unit-tests)
```

```
@Add(unit-tests) {
	auto o { mk_point(0, 0, 5) };
	auto d { mk_vector(0, 0, 1) };
	Ray r { o, d };
	Sphere s;
	auto xs { s.intersect(r) };
	assert(xs.size() == 2);
	assert_eq(xs[0].t, -6);
	assert_eq(xs[1].t, -4);
} @End(unit-tests)
```

```
@Add(unit-tests) {
	Sphere s;
	Intersection i1 { 1, &s };
	Intersection i2 { 2, &s };
	Intersections xs { i1, i2 };
	assert(xs.size() == 2);
	assert_eq(xs[0].t, 1);
	assert_eq(xs[1].t, 2);
} @End(unit-tests)
```

```
@Add(unit-tests) {
	auto o { mk_point(0, 0, -5) };
	auto d { mk_vector(0, 0, 1) };
	Ray r { o, d };
	Sphere s;
	auto xs { s.intersect(r) };
	assert(xs.size() == 2);
	assert(xs[0].object == &s);
	assert(xs[1].object == &s);
} @End(unit-tests)
```

```
@Add(functions)
	auto hit(Intersections &xs) {
		for (auto i = xs.begin(); i != xs.end(); ++i) {
			if (i->t >= 0) { return i; }
		}
		return xs.end();
	}
@End(functions)
```

```
@Add(functions)
	inline constexpr bool operator==(
		const Intersection &a,
		const Intersection &b
	) {
		return
			a.object == b.object &&
				eq(a.t, b.t);
	}
@End(functions)
```

```
@Add(unit-tests) {
	Sphere s;
	Intersection i1 { 1, &s };
	Intersection i2 { 2, &s };
	Intersections xs { i2, i1 };
	auto i { hit(xs) };
	assert(*i == i1);
} @End(unit-tests)
```

```
@Add(unit-tests) {
	Sphere s;
	Intersection i1 { -1, &s };
	Intersection i2 { 1, &s };
	Intersections xs { i2, i1 };
	auto i { hit(xs) };
	assert(*i == i2);
} @End(unit-tests)
```

```
@Add(unit-tests) {
	Sphere s;
	Intersection i1 { -2, &s };
	Intersection i2 { -1, &s };
	Intersections xs { i2, i1 };
	auto i { hit(xs) };
	assert(i == xs.end());
} @End(unit-tests)
```

```
@Add(unit-tests) {
	Sphere s;
	Intersection i1 { 5, &s };
	Intersection i2 { 7, &s };
	Intersection i3 { -3, &s };
	Intersection i4 { 2, &s };
	Intersections xs { i1, i2, i3, i4 };
	auto i { hit(xs) };
	assert(*i == i4);
} @End(unit-tests)
```

```
@Add(functions)
	inline constexpr Ray transform(
		const Ray &r, const Matrix &m
	) {
		return {
			m * r.origin,
			m * r.direction
		};
	}
@End(functions)
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
