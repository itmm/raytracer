# Creating Rays

First we must establish the unit-tests in `raytracer.cpp`:

```c++
#include "ray.h"
// ...
	// unit-tests
	ray_tests();
// ...
```

As the function `ray_tests` is only invoked once, it can be `inline`d and
goes directly to the header `ray.h`:

```c++
#pragma once
#include "tuple.h"

inline void ray_tests() {
	// ray-tests
}
```

First a test to check the attributes

```c++
// ...
	// ray-tests
	{ // check attributes
		auto o { mk_point(1.0f, 2.0f, 3.0f) };
		auto d { mk_vector(4.0f, 5.0f, 6.0f) };
		Ray r { o, d };
		assert(r.origin == o);
		assert(r.direction == d);
	}
// ...
```

Create missing `struct`:

```c++
#include "tuple.h"

struct Ray {
	Tuple origin;
	Tuple direction;
};
// ...
```

Check position on a ray:

```c++
// ...
	// ray-tests
	{ // position on a ray
		auto o { mk_point(2.0f, 3.0f, 4.0f) };
		auto d { mk_vector(1.0f, 0.0f, 0.0f) };
		Ray r { o, d };
		assert(r.pos(0.0f) == o);
		auto e1 { mk_point(3.0f, 3.0f, 4.0f) };
		assert(r.pos(1.0f) == e1);
		auto e2 { mk_point(1.0f, 3.0f, 4.0f) };
		assert(r.pos(-1.0f) == e2);
		auto e3 { mk_point(4.5f, 3.0f, 4.0f) };
		assert(r.pos(2.5f) == e3);
	}
// ...
```

Define `pos` method:

```c++
// ...
struct Ray {
	constexpr auto pos(float t) const {
		return origin + t * direction;
	}
	// ...
};
// ...
```

Next chapter handles the intersection of a ray and a sphere in
[5_intersect-sphere.md](./5_intersect-sphere.md).
