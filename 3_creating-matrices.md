# Matrices

First we must establish the unit-tests in `raytracer.cpp`:

```c++
#include "matrix.h"
// ...
	// unit-tests
	matrix_tests();
// ...
```

As the function `matrix_tests` is only invoked once, it can be `inline`d and
goes directly to the header `matrix.h`:

```c++
#pragma once
#include "tuple.h"

inline void matrix_tests() {
	// matrix-tests
}
```

First a test to access the matrix values

```c++
// ...
	// matrix-tests
	{ // constructing 4x4 matrix
		Matrix m {
			 1.0f,  2.0f,  3.0f,  4.0f,
			 5.5f,  6.5f,  7.5f,  8.5f,
			 9.0f, 10.0f, 11.0f, 12.0f,
			13.5f, 14.5f, 15.5f, 16.5f
		};
		assert_eq(m(0, 0), 1.0f);
		assert_eq(m(0, 3), 4.0f);
		assert_eq(m(1, 0), 5.5f);
		assert_eq(m(1, 2), 7.5f);
		assert_eq(m(2, 2), 11.0f);
		assert_eq(m(3, 0), 13.5f);
		assert_eq(m(3, 2), 15.5f);
	}
// ...
```

Matrix class is not defined yet:

```c++
#pragma once

class Matrix {
	public:
		constexpr Matrix(
			float m00, float m01, float m02, float m03,
			float m10, float m11, float m12, float m13,
			float m20, float m21, float m22, float m23,
			float m30, float m31, float m32, float m33
		): _v {
			m00, m01, m02, m03,
			m10, m11, m12, m13,
			m20, m21, m22, m23,
			m30, m31, m32, m33
		} {}
	private:
		float _v[16];
};
// ...
```

No access operator defined yet:

```c++
// ...
class Matrix {
	public:
		constexpr float operator()(int r, int c) const {
			return _v[r * 4 + c];
		}
		float &operator()(int r, int c) {
			return _v[r * 4 + c];
		}
	// ...
};
// ...
```

Create 2x2 matrix:


```c++
// ...
	// matrix-tests
	{ // constructing 2x2 matrix
		Matrix m {
			-3.0f,  5.0f,
			 1.0f, -2.0f
		};
		assert_eq(m(0, 0), -3.0f);
		assert_eq(m(0, 1), 5.0f);
		assert_eq(m(1, 0), 1.0f);
		assert_eq(m(1, 1), -2.0f);
	}
// ...
```

Missing 2x2 constructor:

```c++
// ...
class Matrix {
	public:
		// 2x2
		constexpr Matrix(
			float m00, float m01,
			float m10, float m11
		): _v {
			 m00,  m01, 0.0f, 0.0f,
			 m10,  m11, 0.0f, 0.0f,
			0.0f, 0.0f, 0.0f, 0.0f,
			0.0f, 0.0f, 0.0f, 0.0f
		} {}
	// ...
};
// ...
```

Create 3x3 matrix


```c++
// ...
	// matrix-tests
	{ // constructing 3x3 matrix
		Matrix m {
			-3.0f,  5.0f,  0.0f,
			 1.0f, -2.0f, -7.0f,
			 0.0f,  1.0f,  1.0f
		};
		assert_eq(m(0, 0), -3.0f);
		assert_eq(m(1, 1), -2.0f);
		assert_eq(m(2, 2), 1.0f);
	}
// ...
```

Missing 3x3 constructor:

```c++
// ...
class Matrix {
	public:
		// 3x3
		constexpr Matrix(
			float m00, float m01, float m02,
			float m10, float m11, float m12,
			float m20, float m21, float m22
		): _v {
			 m00,  m01,  m02, 0.0f,
			 m10,  m11,  m12, 0.0f,
			 m20,  m21,  m22, 0.0f,
			0.0f, 0.0f, 0.0f, 0.0f
		} {}
	// ...
};
// ...
```

Check two matrices for equality:


```c++
// ...
	// matrix-tests
	{ // check for equality
		Matrix a {
			1, 2, 3, 4,
			5, 6, 7, 8,
			9, 8, 7, 6,
			5, 4, 3, 2
		};
		Matrix b {
			1, 2, 3, 4,
			5, 6, 7, 8,
			9, 8, 7, 6,
			5, 4, 3, 2
		};
		assert(a == b);
	}
// ...
```

Define operator:

```c++
// ...
class Matrix {
	public:
		friend constexpr bool operator==(const Matrix &a, const Matrix &b);
	// ...
};
// ...
#include "tuple.h"
inline constexpr bool operator==(const Matrix &a, const Matrix &b) {
	const float *ai = a._v;
	const float *bi = b._v;
	const float *ae = ai + 16;
	for (; ai < ae; ++ai, ++bi) {
		if (! eq(*ai, *bi)) {
			return false;
		}
	}
	return true;
}
// ...
```

Check two matrices for inequality:

```c++
// ...
	// matrix-tests
	{ // check for inequality
		Matrix a {
			1, 2, 3, 4,
			5, 6, 7, 8,
			9, 8, 7, 6,
			5, 4, 3, 2
		};
		Matrix b {
			2, 3, 4, 5,
			6, 7, 8, 9,
			8, 7, 6, 5,
			4, 3, 2, 1
		};
		assert(a != b);
	}
// ...
```

Define operator:

```c++
// ...
inline constexpr bool operator==(const Matrix &a, const Matrix &b) {
	// ...
}
inline constexpr bool operator!=(const Matrix &a, const Matrix &b) {
	return !(a == b);
}
// ...
```

Next comes
[3_multiplying-matrices.md](3_multiplying-matrices.md).

