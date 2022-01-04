# Translations

First we must establish the unit-tests in `raytracer.cpp`:

```c++
#include "transform.h"
// ...
	// unit-tests
	transform_tests();
// ...
```

As the function `transform_tests` is only invoked once, it can be `inline`d and
goes directly to the header `transform.h`:

```c++
#pragma once
#include "matrix.h"

inline void transform_tests() {
	// transform-tests
}
```

First a test translation transforms:

```c++
// ...
	// transform-tests
	{ // translation
		auto t { translation(5.0f, -3.0f, 2.0f) };
		auto p { mk_point(-3.0f, 4.0f, 5.0f) };
		auto e { mk_point(2.0f, 1.0f, 7.0f) };
		assert(t * p == e);
	}
// ...
```

Define missing function:

```c++
// ...
#include "matrix.h"

constexpr inline Matrix translation(float dx, float dy, float dz) {
	return {
		1.0f, 0.0f, 0.0f,   dx,
		0.0f, 1.0f, 0.0f,   dy,
		0.0f, 0.0f, 1.0f,   dz,
		0.0f, 0.0f, 0.0f, 1.0f
	};
}
// ...
```

Test inverse translation:


```c++
// ...
	// transform-tests
	{ // inverse translation
		auto t { translation(5.0f, -3.0f, 2.0f) };
		auto i { inv(t) };
		auto p { mk_point(-3.0f, 4.0f, 5.0f) };
		auto e { mk_point(-8.0f, 7.0f, 3.0f) };
		assert(i * p == e);
	}
// ...
```

Translation has no effects on vectors:

```c++
// ...
	// transform-tests
	{ // translate vector
		auto t { translation(5.0f, -3.0f, 2.0f) };
		auto v { mk_vector(-3.0f, 4.0f, 5.0f) };
		assert(t * v == v);
	}
// ...
```

Transforms continue in [4_scaling.md](./4_scaling.md).

