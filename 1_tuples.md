# Points and Vectors

Include in `raytracer.cpp`:

```c++
#include "tuple.h"
// ...
	// unit-tests
	tuple_tests();
// ...
```

Header goes to `tuple.h`:

```c++
// ...
inline void tuple_tests() {
	// tuple-tests
}
```

```c++
// ...
	// tuple-tests
	{ // first test
		Tuple a { 4.3, -4.2, 3.1, 1 };
		assert_eq(a.x, 4.3);
		assert_eq(a.y, -4.2);
		assert_eq(a.z, 3.1);
		assert(a.w == 1);
		assert(a.is_point());
		assert(! a.is_vector());
	}
// ...
```

```C++
struct Tuple {
	float x, y, z, w;
	// methods
};
// functions
// ...
```

```c++
#include <cassert>
#define assert_eq(a, b) assert(eq((a), (b)))
// ...
```

```c++
#include <cmath>
constexpr bool eq(float a, float b) {
	return std::fabs(a - b) < 1e-5;
}
// ...
```

```c++
// ...
	// methods
	constexpr bool is_point() const {
		return eq(w, 1);
	}
// ...
```

```c++
// ...
	// methods
	constexpr bool is_vector() const {
		return w == 0;
	}
// ...
```

```c++
// ...
	// tuple-tests
	{ // second test
		Tuple a { 4.3, -4.2, 3.1, 0 };
		assert_eq(a.x, 4.3);
		assert_eq(a.y, -4.2);
		assert_eq(a.z, 3.1);
		assert(a.w == 0);
		assert(! a.is_point());
		assert(a.is_vector());
	}
// ...
```

## Create Points and Vectors

```c++
// ...
	// tuple-tests
	{ // make point
		auto p { mk_point(4, -4, 3) };
		Tuple e { 4, -4, 3, 1 };
		assert(p == e);
	}
// ...
```

```c++
// ...
// functions
constexpr auto mk_point(float x, float y, float z) {
	return Tuple { x, y, z, 1 };
}
// ...
```

```c++
// ...
// functions
constexpr bool operator==(const Tuple &a, const Tuple &b) {
	return eq(a.x, b.x) && eq(a.y, b.y) &&
		eq(a.z, b.z) && eq(a.w, b.w);
}
// ...
```

```c++
// ...
	// tuple-tests
	{ // make vector
		auto v { mk_vector(4, -4, 3) };
		Tuple e { 4, -4, 3, 0 };
		assert(v == e);
	}
// ...
```

```c++
// ...
// functions
inline constexpr auto mk_vector(float x, float y, float z) {
	return Tuple { x, y, z, 0 };
}
// ...
```
