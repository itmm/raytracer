# Representing Colors

First we must establish the unit-tests in `raytracer.cpp`:

```c++
#include "color.h"
// ...
	// unit-tests
	color_tests();
// ...
```

As the function `color_test` is only invoked once, it can be `inline`d and
goes directly to the header `color.h`:

```c++
#pragma once
#include "tuple.h"

inline void color_tests() {
	// color-tests
}
```

A quick test asserts our expectations about color:

```c++
// ...
	// color-tests
	{ // test specific color
		Color c { -0.5f, 0.4f, 1.7f };
		assert_eq(c.red, -0.5f);
		assert_eq(c.green, 0.4f);
		assert_eq(c.blue, 1.7f);
	}
// ...
```

Of course we need to define the `Color` `struct` to make the test work:


```c++
#pragma once

struct Color {
	float red, green, blue;
};
// ...
```

The next part is in [2_color-operations.md](./2_color-operations.md)
