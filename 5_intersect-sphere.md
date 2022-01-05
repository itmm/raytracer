# Intersect a ray with a sphere


First we must establish the unit-tests in `raytracer.cpp`:

```c++
#include "sphere.h"
// ...
	// unit-tests
	sphere_tests();
// ...
```

As the function `sphere_tests` is only invoked once, it can be `inline`d and
goes directly to the header `sphere.h`:

```c++
#pragma once
#include "ray.h"

inline void sphere_tests() {
	// sphere-tests
}
```

First a test to check a ray with two intersections:

```c++
// ...
	// sphere-tests
	{ // two intersections
		auto o { mk_point(0.0f, 0.0f, -5.0f) };
		auto d { mk_vector(0.0f, 0.0f, 1.0f) };
		Ray r { o, d };
		Sphere s;
		auto xs { s.intersect(r) };
		assert(xs.size() == 2);
		assert_eq(xs[0].t, 4.0f);
		assert_eq(xs[1].t, 6.0f);
	}
// ...
```

First define a sphere `struct`:

```c++
// ...
#include "ray.h"
#include "matrix.h"

struct Object {
	Matrix transform = identity;
	Matrix inv_transform = identity;
};
struct Sphere: Object {
};
// ...
```

Define `intersect` method:

```c++
// ...
struct Object {
	virtual Intersections intersect(const Ray &r) = 0;
	// ...
};
// ...
struct Sphere: Object {
	Intersections intersect(const Ray &r) override;
};
// ...
```

Add implementation of `intersect` in `sphere.cpp`:

```c++
#include "sphere.h"

Intersections Sphere::intersect(const Ray &r) {
	auto r2 { ::transform(r, inv_transform) };
	auto s2r { r2.origin - mk_point(0.0f, 0.0f, 0.0f) };
	auto a { dot(r2.direction, r2.direction) };
	auto b { 2 * dot(r2.direction, s2r) };
	auto c { dot(s2r, s2r) - 1 };
	auto discr { b * b - 4.0f * a * c };
	if (discr < 0) { 
		return {};
	}
	auto sd { sqrtf(discr) };
	return {
		{(-b - sd)/(2.0f * a), this},
		{(-b + sd)/(2.0f * a), this}
	};
}
```

Define `Intersections` type in `sphere.h`:

```c++
// ...
#include "matrix.h"
#include <vector>

struct Object;
struct Intersection {
	float t;
	Object *object;
};

class Intersections: public std::vector<Intersection> {
	public:
		Intersections(std::initializer_list<Intersection> l);
};
// ...
```

Add `transform` function in `sphere.cpp`:

```c++
#include "sphere.h"

inline constexpr Ray transform(const Ray &r, const Matrix &m) {
	return {
		m * r.origin,
		m * r.direction
	};
}
// ...
```

Define `Intersections` constructor:


```c++
#include "sphere.h"
#include <algorithm>

Intersections::Intersections(std::initializer_list<Intersection> l):
	std::vector<Intersection>(l)
{
	std::sort(begin(), end());
}
// ...
```

Make `Intersection` comparable in `sphere.h`:

```c++
// ...
struct Intersection {
	// ...
};

inline bool operator<(const Intersection &a, const Intersection &b) {
	return a.t < b.t;
}
// ...
```

Unit-Test with one intersection:

```c++
// ...
	// sphere-tests
	{ // one intersection
		auto o { mk_point(0.0f, 1.0f, -5.0f) };
		auto d { mk_vector(0.0f, 0.0f, 1.0f) };
		Ray r { o, d };
		Sphere s;
		auto xs { s.intersect(r) };
		assert(xs.size() == 2);
		assert_eq(xs[0].t, 5.0f);
		assert_eq(xs[1].t, 5.0f);
	}
// ...
```

Unit-Test with no intersections:

```c++
// ...
	// sphere-tests
	{ // no intersections
		auto o { mk_point(0.0f, 2.0f, -5.0f) };
		auto d { mk_vector(0.0f, 0.0f, 1.0f) };
		Ray r { o, d };
		Sphere s;
		auto xs { s.intersect(r) };
		assert(xs.size() == 0);
	}
// ...
```

Ray starts inside a sphere:

```c++
// ...
	// sphere-tests
	{ // start inside
		auto o { mk_point(0.0f, 0.0f, 0.0f) };
		auto d { mk_vector(0.0f, 0.0f, 1.0f) };
		Ray r { o, d };
		Sphere s;
		auto xs { s.intersect(r) };
		assert(xs.size() == 2);
		assert_eq(xs[0].t, -1.0f);
		assert_eq(xs[1].t, 1.0f);
	}
// ...
```

Sphere is behind ray:

```c++
// ...
	// sphere-tests
	{ // sphere is behind ray
		auto o { mk_point(0.0f, 0.0f, 5.0f) };
		auto d { mk_vector(0.0f, 0.0f, 1.0f) };
		Ray r { o, d };
		Sphere s;
		auto xs { s.intersect(r) };
		assert(xs.size() == 2);
		assert_eq(xs[0].t, -6.0f);
		assert_eq(xs[1].t, -4.0f);
	}
// ...
```

Continues in [5_tracking-intersections.md](./5_tracking-intersections.md).

