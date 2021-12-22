# Points and Vectors

In this document I add the `class` to store vectors and points.
First I add a function in `raytracer.cpp` that invokes the unit-tests:


```c++
#include "tuple.h"
// ...
	// unit-tests
	tuple_tests();
// ...
```

As the function `tuple_test` is only invoked once, it can be `inline`d and
goes directly to the header `tuple.h`:

```c++
#pragma once

inline void tuple_tests() {
	// tuple-tests
}
```

The first test checks if all the attributes are set and the tuple is
correctly identified as a point, not a vector:

```c++
// ...
	// tuple-tests
	{ // a tuple with w == 1 is a point
		Tuple a { 4.3f, -4.2f, 3.1f, 1.0f };
		assert_eq(a.x, 4.3f);
		assert_eq(a.y, -4.2f);
		assert_eq(a.z, 3.1f);
		assert_eq(a.w, 1.0f);
		assert(a.is_point());
		assert(! a.is_vector());
	}
// ...
```

Of course this test fails now. Let's try to fix it.
First I need the `class` with all the needed attributes in `tuple.h`:

```C++
#pragma once

struct Tuple {
	float x, y, z, w;
	// methods
};
// functions
// ...
```

But the function to assert the value of numbers is missing:

```c++
// ...
// functions
#include <cassert>
#define assert_eq(a, b) assert(eq((a), (b)))
// ...
```

And this function needs a function to compare them with a grain of salt:

```c++
#pragma once
	
#include <cmath>
constexpr bool eq(float a, float b) {
	return std::fabs(a - b) < 1e-5f;
}
// ...
```
As mentioned in the comment of the first unit-test, a tuple is a point,
if the `w` component is `1`. Here is the code in `tuple.h`:

```c++
// ...
	// methods
	constexpr bool is_point() const {
		return eq(w, 1.0f);
	}
// ...
```
And a tuple is a vector if the `w` component is `0`. Here is the code in
`tuple.h`:

```c++
// ...
	// methods
	constexpr bool is_vector() const {
		return eq(w, 0.0f);
	}
// ...
```

As the first test now passes, let's try a second one.
This time a vector is created:

```c++
// ...
	// tuple-tests
	{ // a tuple with w == 0 is a vector
		Tuple a { 4.3f, -4.2f, 3.1f, 0.0f };
		assert_eq(a.x, 4.3f);
		assert_eq(a.y, -4.2f);
		assert_eq(a.z, 3.1f);
		assert_eq(a.w, 0.0f);
		assert(! a.is_point());
		assert(a.is_vector());
	}
// ...
```

## Create Points and Vectors

The following test tries to directly create a point and compare it to a
reference tuple.

```c++
// ...
	// tuple-tests
	{ // make point
		auto p { mk_point(4.0f, -4.0f, 3.0f) };
		Tuple e { 4.0f, -4.0f, 3.0f, 1.0f };
		assert(p == e);
	}
// ...
```

Of course the test fails again. First I need a function to create a
point:

```c++
// ...
// functions
constexpr auto mk_point(float x, float y, float z) {
	return Tuple { x, y, z, 1.0f };
}
// ...
```

And another function to compare tuples:

```c++
// ...
// functions
constexpr bool operator==(const Tuple &a, const Tuple &b) {
	return eq(a.x, b.x) && eq(a.y, b.y) &&
		eq(a.z, b.z) && eq(a.w, b.w);
}
// ...
```

Now the test passes.
The next test creates directly a vector:

```c++
// ...
	// tuple-tests
	{ // make vector
		auto v { mk_vector(4.0f, -4.0f, 3.0f) };
		Tuple e { 4.0f, -4.0f, 3.0f, 0.0f };
		assert(v == e);
	}
// ...
```

Here also the factory function is missing:

```c++
// ...
// functions
constexpr auto mk_vector(float x, float y, float z) {
	return Tuple { x, y, z, 0.0f };
}
// ...
```

Now the tests all pass.

The journey continues in the file
[1_operations.md](./1_operations.md).
