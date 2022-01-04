# Scaling

Test Scaling on points:

```c++
// ...
	// transform-tests
	{ // scale a point
		auto s { scaling(2.0f, 3.0f, 4.0f) };
		auto p { mk_point(-4.0f, 6.0f, 8.0f) };
		auto e { mk_point(-8.0f, 18.0f, 32.0f) };
		assert(s * p == e);
	}
// ...
```

Define missing function:

```c++
// ...
#include "matrix.h"

constexpr inline Matrix scaling(float sx, float sy, float sz) {
	return {
		  sx, 0.0f, 0.0f, 0.0f,
		0.0f,   sy, 0.0f, 0.0f,
		0.0f, 0.0f,   sz, 0.0f,
		0.0f, 0.0f, 0.0f, 1.0f
	};
}
// ...
```

Test Scaling on vectors:

```c++
// ...
	// transform-tests
	{ // scale a vector
		auto s { scaling(2, 3, 4) };
		auto v { mk_vector(-4, 6, 8) };
		auto e { mk_vector(-8, 18, 32) };
		assert(s * v == e);
	}
// ...
```

Test inverse of scaling:


```c++
// ...
	// transform-tests
	{ // inverse of scaling
		auto s { scaling(2, 3, 4) };
		auto i { inv(s) };
		auto v { mk_vector(-4, 6, 8) };
		auto e { mk_vector(-2, 2, 2) };
		assert(i * v == e);
	}
// ...
```

Reflection is negative scaling:


```c++
// ...
	// transform-tests
	{ // negative scaling
		auto s { scaling(-1, 1, 1) };
		auto p { mk_point(2, 3, 4) };
		auto e { mk_point(-2, 3, 4) };
		assert(s * p == e);
	}
// ...
```

Next transform in [4_rotation.md](./4_rotation.md).

