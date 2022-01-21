# Surface Normals

First we must establish the unit-tests in `raytracer.cpp`:

```c++
#include "normal.h"
// ...
	// unit-tests
	normal_tests();
// ...
```

As the function `normal_tests` is only invoked once, it can be `inline`d and
goes directly to the header `normal.h`:

```c++
#pragma once
#include "sphere.h"

inline void normal_tests() {
	// normal-tests
}
```

First a test the normal on a sphere at a point on the x-axis:

```c++
// ...
	// normal-tests
	{ // on sphere, x-axis
		Sphere s;
		auto p { mk_point(1, 0, 0) } ;
		auto n { s.normal_at(p) };
		auto e { mk_vector(1, 0, 0) };
		assert(n == e);
	}
// ...
```

Declare `normal_at` in `Object` in `sphere.h`:

```c++
// ...
struct Object {
	virtual Tuple normal_at(const Tuple &w) = 0;
	// ...
};
// ...
```

And declare the overridden version in the `Sphere` class:

```c++
// ...
struct Sphere: Object {
	Tuple normal_at(const Tuple &w) override;
	// ...
};
// ...
```

Now the method can be implemented in `sphere.cpp`:

```c++
// ...
Tuple Sphere::normal_at(const Tuple &w) {
	auto i { inv_transform };
	auto o { i * w };
	auto on { o - mk_point(0, 0, 0) };
	auto wn { trans(i) * on };
	wn.w = 0;
	return norm(wn);
}
```

Now check with a point on the y-axis in `normal.h`:

```c++
// ...
	// normal-tests
	{ // on sphere, y-axis
		Sphere s;
		auto p { mk_point(0, 1, 0) } ;
		auto n { s.normal_at(p) };
		auto e { mk_vector(0, 1, 0) };
		assert(n == e);
	}
// ...
```

And on on the z-axis:

```c++
// ...
	// normal-tests
	{ // on sphere, z-axis
		Sphere s;
		auto p { mk_point(0, 0, 1) } ;
		auto n { s.normal_at(p) };
		auto e { mk_vector(0, 0, 1) };
		assert(n == e);
	}
// ...
```

And on a non-axis point:

```c++
// ...
	// normal-tests
	{ // on sphere, non-axial
		Sphere s;
		float f { sqrtf(3)/3 };
		auto p { mk_point(f, f, f) } ;
		auto n { s.normal_at(p) };
		auto e { mk_vector(f, f, f) };
		assert(n == e);
	}
// ...
```

A normal vector is its own normal:

```c++
// ...
	// normal-tests
	{ // normal of a normal
		Sphere s;
		float f { sqrtf(3)/3 };
		auto p { mk_point(f, f, f) } ;
		auto n { s.normal_at(p) };
		assert(n == norm(n));
	}
// ...
```

Check a normal of a translated sphere:

```c++
// ...
	// normal-tests
	{ // normal of translated sphere
		Sphere s;
		s.transform = translation(0, 1, 0);
		s.inv_transform = inv(s.transform);
		auto n { s.normal_at(mk_point(0, 1.70711, -0.70711)) };
		auto e { mk_vector(0, 0.70711, -0.70711) };
		assert(e == n);
	}
// ...
```

Normal of a transformed sphere:

```c++
// ...
	// normal-tests
	{ // normal of transformed sphere
		Sphere s;
		s.transform = scaling(1, 0.5, 1) * rotate_z(M_PI/5);
		s.inv_transform = inv(s.transform);
		float f { sqrtf(2)/2 };
		auto n { s.normal_at(mk_point(0, f, -f)) };
		auto e { mk_vector(0, 0.97014, -0.24254) };
		assert(e == n);
	}
// ...
```

Continuous in [6_reflecting-vectors.md](./6_reflecting-vectors.md).
