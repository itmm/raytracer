# Shearing

Move x in proportion to y:

```c++
// ...
	// transform-tests
	{ // move x in proportion to y
		auto s { shearing(1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f) };
		auto p { mk_point(2.0f, 3.0f, 4.0f) };
		auto e { mk_point(5.0f, 3.0f, 4.0f) };
		assert(s * p == e);
	}
// ...
```

Define missing function:

```c++
// ...
#include "matrix.h"

constexpr inline Matrix shearing(
	float xy, float xz, float yx, float yz, float zx, float zy
) {
	return {
		1.0f,   xy,   xz, 0.0f,
		  yx, 1.0f,   yz, 0.0f,
		  zx,   zy, 1.0f, 0.0f,
		0.0f, 0.0f, 0.0f, 1.0f
	};
}
// ...
```

Move x in proportion to z:

```c++
// ...
	// transform-tests
	{ // move x in proportion to z
		auto s { shearing(0.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.0f) };
		auto p { mk_point(2.0f, 3.0f, 4.0f) };
		auto e { mk_point(6.0f, 3.0f, 4.0f) };
		assert(s * p == e);
	}
// ...
```

Move y in proportion to x:

```c++
// ...
	// transform-tests
	{ // move y in proportion to x
		auto s { shearing(0.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.0f) };
		auto p { mk_point(2.0f, 3.0f, 4.0f) };
		auto e { mk_point(2.0f, 5.0f, 4.0f) };
		assert(s * p == e);
	}
// ...
```

Move y in proportion to z:

```c++
// ...
	// transform-tests
	{ // move y in proportion to z
		auto s { shearing(0.0f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f) };
		auto p { mk_point(2.0f, 3.0f, 4.0f) };
		auto e { mk_point(2.0f, 7.0f, 4.0f) };
		assert(s * p == e);
	}
// ...
```

Move z in proportion to x:

```c++
// ...
	// transform-tests
	{ // move z in proportion to x
		auto s { shearing(0.0f, 0.0f, 0.0f, 0.0f, 1.0f, 0.0f) };
		auto p { mk_point(2.0f, 3.0f, 4.0f) };
		auto e { mk_point(2.0f, 3.0f, 6.0f) };
		assert(s * p == e);
	}
// ...
```

Move z in proportion to y:

```c++
// ...
	// transform-tests
	{ // move z in proportion to y
		auto s { shearing(0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f) };
		auto p { mk_point(2.0f, 3.0f, 4.0f) };
		auto e { mk_point(2.0f, 3.0f, 7.0f) };
		assert(s * p == e);
	}
// ...
```

Combining transforms in [4_combining.md](./4_combining.md).

