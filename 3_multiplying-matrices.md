# Multiplying Matrices

Unit Test for full matrix multiply in `matrix.h`:

```c++
// ...
	// matrix-tests
	{ // matrix multiply
		Matrix a {
			1.0f, 2.0f, 3.0f, 4.0f,
			5.0f, 6.0f, 7.0f, 8.0f,
			9.0f, 8.0f, 7.0f, 6.0f,
			5.0f, 4.0f, 3.0f, 2.0f
		};
		Matrix b {
			-2.0f, 1.0f, 2.0f,  3.0f,
			 3.0f, 2.0f, 1.0f, -1.0f,
			 4.0f, 3.0f, 6.0f,  5.0f,
			 1.0f, 2.0f, 7.0f,  8.0f
		};
		Matrix e {
			20.0f, 22.0f,  50.0f,  48.0f,
			44.0f, 54.0f, 114.0f, 108.0f,
			40.0f, 58.0f, 110.0f, 102.0f,
			16.0f, 26.0f,  46.0f,  42.0f
		};
		assert(a * b == e);
	}
// ...
```

Define operator:

```c++
// ...
class Matrix {
	// ...
};
inline constexpr Matrix operator*(const Matrix &a, const Matrix &b) {
	return {
		mult_line(a, b, 0, 0), mult_line(a, b, 0, 1),
			mult_line(a, b, 0, 2), mult_line(a, b, 0, 3),
		mult_line(a, b, 1, 0), mult_line(a, b, 1, 1),
			mult_line(a, b, 1, 2), mult_line(a, b, 1, 3),
		mult_line(a, b, 2, 0), mult_line(a, b, 2, 1),
			mult_line(a, b, 2, 2), mult_line(a, b, 2, 3),
		mult_line(a, b, 3, 0), mult_line(a, b, 3, 1),
			mult_line(a, b, 3, 2), mult_line(a, b, 3, 3)
	};
}
// ...
```

Define `multi_line`:

```c++
// ...
class Matrix {
	// ...
};
inline constexpr float mult_line(const Matrix &a, const Matrix &b, int r, int c) {
	return a(r, 0) * b(0, c) + a(r, 1) * b(1, c) +
		a(r, 2) * b(2, c) + a(r, 3) * b(3, c);
}
// ...
```

Multiply a matrix with a tuple:


```c++
// ...
	// matrix-tests
	{ // matrix/tuple multiplication
		Matrix a {
			1.0f, 2.0f, 3.0f, 4.0f,
			2.0f, 4.0f, 4.0f, 2.0f,
			8.0f, 6.0f, 4.0f, 1.0f,
			0.0f, 0.0f, 0.0f, 1.0f
		};
		Tuple t { 1.0f, 2.0f, 3.0f, 1.0f };
		Tuple e { 18.0f, 24.0f, 33.0f, 1.0f };
		assert(a * t == e);
	}
// ...
```

Define tuple multiplication:


```c++
// ...
#include "tuple.h"
inline constexpr Tuple operator*(const Matrix &a, const Tuple &t) {
	return {
		mult_line(a, t, 0), mult_line(a, t, 1),
		mult_line(a, t, 2), mult_line(a, t, 3)
	};
}
// ...
```

Define missing function:

```c++
// ...
#include "tuple.h"
inline constexpr float mult_line(const Matrix &a, const Tuple &t, int r) {
	return a(r, 0) * t.x + a(r, 1) * t.y + a(r, 2) * t.z + a(r, 3) * t.w;
}
// ...
```

Next part in
[3_identity-matrix.md](./3_identity-matrix.md)
