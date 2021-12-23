# Color Operations

## Adding

The first test tries to add colors in `color.h`:


```c++
// ...
	// color-tests
	{ // add two colors
		Color c1 { 0.9f, 0.6f, 0.75f };
		Color c2 { 0.7f, 0.1f, 0.25f };
		Color e { 1.6f, 0.7f, 1.0f };
		assert(c1 + c2 == e);
	}
// ...
```

Of course the operation must first be defined:

```c++
// ...
struct Color {
	// ...
};
inline auto operator+(const Color &a, const Color &b) {
	return Color {
		a.red + b.red,
		a.green + b.green,
		a.blue + b.blue
	};
}
// ...
```

Also equality must be implemented

```c++
// ...
#include "tuple.h"
inline bool operator==(const Color &a, const Color &b) {
	return eq(a.red, b.red) &&
		eq(a.green, b.green) &&
		eq(a.blue, b.blue);
}
// ...
```

## Subtracting

The following test checks, if subtraction is working:

```c++
// ...
	// color-tests
	{ // subtract two colors
		Color c1 { 0.9f, 0.6f, 0.75f };
		Color c2 { 0.7f, 0.1f, 0.25f };
		Color e { 0.2f, 0.5f, 0.5f };
		assert(c1 - c2 == e);
	}
// ...
```

Also the function must be declared first:

```c++
// ...
struct Color {
	// ...
};
inline auto operator-(const Color &a, const Color &b) {
	return Color {
		a.red - b.red,
		a.green - b.green,
		a.blue - b.blue
	};
}
// ...
```

## Scalar Multiplication

A test case for scalar multiplication:

```c++
// ...
	// color-tests
	{ // scalar multiplication
		Color c { 0.2f, 0.3f, 0.4f };
		Color e { 0.4f, 0.6f, 0.8f };
		assert(c * 2.0f == e);
	}
// ...
```

Implement the missing function:

```C++
// ...
struct Color {
	// ...
};
inline auto operator*(const Color &c, float f) {
	return Color {
		c.red * f, c.green * f,
		c.blue * f
	};
}
// ...
```

## Hadamard product

Test case for multiplying two color component by component:

```c++
// ...
	// color-tests
	{ // hadamard product
		Color c1 { 1.0f, 0.2f, 0.4f };
		Color c2 { 0.9f, 1.0f, 0.1f };
		Color e { 0.9f, 0.2f, 0.04f };
		assert(c1 * c2 == e);
	}
// ...
```

Implement the function

```c++
// ...
struct Color {
	// ...
};
inline auto operator*(const Color &a, const Color &b) {
	return Color {
		a.red * b.red,
		a.green * b.green,
		a.blue * b.blue
	};
}
// ...
```

