# The Phong Reflection Model

First we must establish the unit-tests in `raytracer.cpp`:

```c++
#include "light.h"
// ...
	// unit-tests
	light_tests();
// ...
```

As the function `light_tests` is only invoked once, it can be `inline`d and
goes directly to the header `light.h`:

```c++
#pragma once
#include "color.h"

inline void light_tests() {
	// light-tests
}
```

First test the attributes of a point light:

```c++
// ...
	// light-tests
	{ // point light attributes
		Color i { 1, 1, 1 };
		auto p { mk_point(0, 0, 0) };
		Point_Light l { p, i };
		assert(l.position == p);
		assert(l.intensity == i);
	}
// ...
```

Declare the point light class:

```c++
// ...
#include "color.h"

struct Point_Light {
	Tuple position;
	Color intensity;
};
// ...
```

Now we must establish the material unit-tests in `raytracer.cpp`:

```c++
#include "material.h"
// ...
	// unit-tests
	material_tests();
// ...
```

As the function `material_tests` is only invoked once, it can be `inline`d and
goes directly to the header `material.h`:

```c++
#pragma once
#include "color.h"

inline void material_tests() {
	// material-tests
}
```

Test default attributes of the material


```c++
// ...
	// material-tests
	{ // default material attributes
		Material m;
		Color e { 1, 1, 1 };
		assert(m.color == e);
		assert_eq(0.1, m.ambient);
		assert_eq(0.9, m.diffuse);
		assert_eq(0.9, m.specular);
		assert_eq(200, m.shininess);
	}
// ...
```

Define the material class:

```c++
// ...
#include "color.h"

struct Material {
	Color color { 1, 1, 1 };
	float ambient { 0.1 };
	float diffuse { 0.9 };
	float specular { 0.9 };
	float shininess { 200 };
};
// ...
```

Test that a sphere has a material in `sphere.h`:


```c++
// ...
	// sphere-tests
	{ // sphere has default material
		Sphere s;
		Material m;
		assert(s.material == m);
	}
// ...
```

Add material to the `Object`:

```c++
// ...
#include <vector>
#include "material.h"
// ...
struct Object {
	Material material;
	// ...
};
// ...
```

We need to compare materials to make the test work in `material.h`:

```c++
// ...
struct Material {
	// ...
};
inline bool operator==(const Material &a, const Material &b) {
	return a.color == b.color &&
		eq(a.ambient, b.ambient) &&
		eq(a.diffuse, b.diffuse) &&
		eq(a.specular, b.specular) &&
		eq(a.shininess, b.shininess);
}
// ...
```

The material can be assigned to a sphere in `sphere.h`:

```c++
// ...
	// sphere-tests
	{ // assign material to sphere
		Sphere s;
		Material m;
		m.ambient = 1;
		s.material = m;
		assert(s.material == m);
	}
// ...
```

Test scenario with eye between light and the object in `light.h`:

```c++
// ...
#include "color.h"
#include "light.h"
// ...
	// light-tests
	{ // eye between light and object
		Material m;
		auto pos { mk_point(0, 0, 0) };
		auto eye { mk_vector(0, 0, -1) };
		auto n { mk_vector(0, 0, -1) };
		auto lp { mk_point(0, 0, -10) };
		Color lc { 1, 1, 1 };
		Point_Light l { lp, lc };
		Color e { 1.9, 1.9, 1.9 };
		assert(lighting(m, l, pos, eye, n) == e);
	}
// ...
```

Define `lighting` function:

```c++
// ...
struct Point_Light {
	// ...
};

Color lighting(
	const Material &m, const Point_Light &l,
	const Tuple &p, const Tuple &e, const Tuple &n,
	bool in_shadow = false
) {
	Color res { 0, 0, 0 };
	// lighting
	return res;
}
// ...
```

Implement the `lighting` function:

```c++
// ...
	// lighting
	auto ec { m.color * l.intensity };
	res = ec * m.ambient;
	auto lv { norm(l.position - p) };
	auto ldn { dot(lv, n) };
	if (ldn >= 0 && ! in_shadow) {
		res = res + ec * m.diffuse * ldn;
		auto r { reflect(-lv, n) };
		auto rde { dot(r, e) };
		if (rde >= 0) {
			auto f { powf(rde, m.shininess) };
			res = res + l.intensity * m.specular * f;
		}
	}
// ...
```

Test with eye offset:

```c++
// ...
	// light-tests
	{ // offset eye
		Material m;
		auto pos { mk_point(0, 0, 0) };
		float f { sqrtf(2)/2 };
		auto eye { mk_vector(0, f, -f) };
		auto n { mk_vector(0, 0, -1) };
		auto lp { mk_point(0, 0, -10) };
		Color lc { 1, 1, 1 };
		Point_Light l { lp, lc };
		Color e { 1, 1, 1 };
		assert(lighting(m, l, pos, eye, n) == e);
	}
// ...
```

Test with light offset:

```c++
// ...
	// light-tests
	{ // offset light source
		Material m;
		auto pos { mk_point(0, 0, 0) };
		auto eye { mk_vector(0, 0, -1) };
		auto n { mk_vector(0, 0, -1) };
		auto lp { mk_point(0, 10, -10) };
		Color lc { 1, 1, 1 };
		Point_Light l { lp, lc };
		float f { 0.7364 };
		Color e { f, f, f };
		assert(lighting(m, l, pos, eye, n) == e);
	}
// ...
```

Test with eye and light offset:

```c++
// ...
	// light-tests
	{ // offset eye and light source
		Material m;
		auto pos { mk_point(0, 0, 0) };
		float f { sqrtf(2)/2 };
		auto eye { mk_vector(0, -f, -f) };
		auto n { mk_vector(0, 0, -1) };
		auto lp { mk_point(0, 10, -10) };
		Color lc { 1, 1, 1 };
		Point_Light l { lp, lc };
		float g { 1.6364 };
		Color e { g, g, g };
		assert(lighting(m, l, pos, eye, n) == e);
	}
// ...
```

Test with eye behind the surface:

```c++
// ...
	// light-tests
	{ // eye behind the surface
		Material m;
		auto pos { mk_point(0, 0, 0) };
		auto eye { mk_vector(0, 0, -1) };
		auto n { mk_vector(0, 0, -1) };
		auto lp { mk_point(0, 0, 10) };
		Color lc { 1, 1, 1 };
		Point_Light l { lp, lc };
		Color e { 0.1, 0.1, 0.1 };
		assert(lighting(m, l, pos, eye, n) == e);
	}
// ...
```

Continue in [6_phong-sphere.md](./6_phong-sphere.md).
