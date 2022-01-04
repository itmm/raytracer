# Rotation

Rotate a point around the x-axis:

```c++
// ...
	// transform-tests
	{ // rotate point around x-axis
		auto p { mk_point(0.0f, 1.0f, 0.0f) };
		auto hq { rotate_x(M_PI/4.0f) };
		auto fq { rotate_x(M_PI/2.0f) };
		auto he { mk_point(0.0f, sqrtf(2.0f)/2.0f, sqrtf(2.0f)/2.0f) };
		auto fe { mk_point(0.0f, 0.0f, 1.0f) };
		assert(hq * p == he);
		assert(fq * p == fe);
	}
// ...
```

Define missing function:

```c++
// ...
#include "matrix.h"

constexpr inline Matrix rotate_x(float ang) {
	float c { cosf(ang) };
	float s { sinf(ang) };
	return {
		1.0f, 0.0f, 0.0f, 0.0f,
		0.0f,    c,   -s, 0.0f,
		0.0f,    s,    c, 0.0f,
		0.0f, 0.0f, 0.0f, 1.0f
	};
}
// ...
```

Inverse x-rotation:

```c++
// ...
	// transform-tests
	{ // inverse x-rotation
		auto p { mk_point(0.0f, 1.0f, 0.0f) };
		auto hq { rotate_x(M_PI/4.0f) };
		auto i { inv(hq) };
		auto e { mk_point(0.0f, sqrtf(2.0f)/2.0f, -sqrtf(2.0f)/2.0f) };
		assert(i * p == e);
	}
// ...
```

Rotate around y-axis:


```c++
// ...
	// transform-tests
	{ // rotate around x-axis
		auto p { mk_point(0.0f, 0.0f, 1.0f) };
		auto hq { rotate_y(M_PI/4.0f) };
		auto fq { rotate_y(M_PI/2.0f) };
		auto he { mk_point(sqrtf(2.0f)/2.0f, 0.0f, sqrtf(2.0f)/2.0f) };
		auto fe { mk_point(1.0f, 0.0f, 0.0f) };
		assert(hq * p == he);
		assert(fq * p == fe);
	}
// ...
```

Define missing function:

```c++
// ...
#include "matrix.h"

constexpr inline Matrix rotate_y(float ang) {
	float c { cosf(ang) };
	float s { sinf(ang) };
	return {
		   c, 0.0f,    s, 0.0f,
		0.0f, 1.0f, 0.0f, 0.0f,
		  -s, 0.0f,    c, 0.0f,
		0.0f, 0.0f, 0.0f, 1.0f
	};
}
// ...
```

Rotate around z-axis:


```c++
// ...
	// transform-tests
	{ // rotate around z-axis
		auto p { mk_point(0.0f, 1.0f, 0.0f) };
		auto hq { rotate_z(M_PI/4.0f) };
		auto fq { rotate_z(M_PI/2.0f) };
		auto he { mk_point(-sqrtf(2.0f)/2.0f, sqrtf(2.0f)/2.0f, 0.0f) };
		auto fe { mk_point(-1.0f, 0.0f, 0.0f) };
		assert(hq * p == he);
		assert(fq * p == fe);
	}
// ...
```

Define missing function:

```c++
// ...
#include "matrix.h"

constexpr inline Matrix rotate_z(float ang) {
	float c { cosf(ang) };
	float s { sinf(ang) };
	return {
		   c,   -s, 0.0f, 0.0f,
		   s,    c, 0.0f, 0.0f,
		0.0f, 0.0f, 1.0f, 0.0f,
		0.0f, 0.0f, 0.0f, 1.0f
	};
}
// ...
```

The last transform is in [4_shearing.md](./4_shearing.md).

