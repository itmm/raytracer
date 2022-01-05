# Inverting matrices

Testing 2x2 determinant in `matrix.h`:


```c++
// ...
	// matrix-tests
	{ // 2x2 determinant
		Matrix a {
			 1.0f, 5.0f,
			-3.0f, 2.0f
		};
		assert_eq(17.0f, det2(a));
	}
// ...
```

Define `det2`:

```c++
// ...
class Matrix {
	// ...
};
inline constexpr float det2(const Matrix &a) {
	return a(0, 0) * a(1, 1) - a(0, 1) * a(1, 0);
}
// ...
```

Test submatrix functionality:

```c++
// ...
	// matrix-tests
	{ // test 2x2 submatrix
		Matrix a {
			 1.0f, 5.0f,  0.0f,
			-3.0f, 2.0f,  7.0f,
			 0.0f, 6.0f, -3.0f
		};
		Matrix e {
			-3.0f, 2.0f,
			 0.0f, 6.0f
		};
		assert(sub(a, 0, 2) == e);
	}
// ...
```

Implement `sub`:

```c++
// ...
class Matrix {
	// ...
};
inline Matrix sub(Matrix a, int r, int c) {
	while (r < 3) {
		int i = r + 1;
		for (int k = 3; k >= 0; --k) {
			a(r, k) = a(i, k);
		}
		r = i;
	}
	while (c < 3) {
		int i = c + 1;
		for (int k = 3; k >= 0; --k) {
			a(k, c) = a(k, i);
		}
		c = i;
	}
	for (int i = 3; i >= 0; --i) {
		a(i, 3) = 0.0f;
		a(3, i) = 0.0f;
	}
	return a;
}
// ...
```

Test 3x3 submatrix:

```c++
// ...
	// matrix-tests
	{ // test 3x3 submatrix
		Matrix a {
			-6.0f, 1.0f,  1.0f, 6.0f,
			-8.0f, 5.0f,  8.0f, 6.0f,
			-1.0f, 0.0f,  8.0f, 2.0f,
			-7.0f, 1.0f, -1.0f, 1.0f
		};
		Matrix e {
			-6.0f,  1.0f, 6.0f,
			-8.0f,  8.0f, 6.0f,
			-7.0f, -1.0f, 1.0f
		};
		assert(sub(a, 2, 1) == e);
	}
// ...
```

Check that the minor of a matrix is the determinant of the submatrix:

```c++
// ...
	// matrix-tests
	{ // minor3
		Matrix a {
			3.0f,  5.0f,  0.0f,
			2.0f, -1.0f, -7.0f,
			6.0f, -1.0f,  5.0f
		};
		assert_eq(det2(sub(a, 1, 0)), 25.0f);
		assert_eq(minor3(a, 1, 0), 25.0f);
	}
// ...
```

Define `minor3`:

```c++
// ...
inline constexpr float det2(const Matrix &a) {
	// ...
}
inline float minor3(const Matrix &a, int r, int c) {
	return det2(sub(a, r, c));
}
// ...
```

Test cofactors:

```c++
// ...
	// matrix-tests
	{ // cofactor
		Matrix a {
			3.0f,  5.0f,  0.0f,
			2.0f, -1.0f, -7.0f,
			6.0f, -1.0f,  5.0f
		};
		assert_eq(minor3(a, 0, 0), -12.0f);
		assert_eq(cofactor3(a, 0, 0), -12.0f);
		assert_eq(minor3(a, 1, 0), 25.0f);
		assert_eq(cofactor3(a, 1, 0), -25.0f);
	}
// ...
```

Define `cofactor`:

```c++
// ...
inline float minor3(const Matrix &a, int r, int c) {
	// ...
}
inline float cofactor3(const Matrix &a, int r, int c) {
	float m = minor3(a, r, c);
	return ((r + c) & 1) ? -m : m;
}
// ...
```

Test 3x3 determinant:

```c++
// ...
	// matrix-tests
	{ // 3x3 determinant
		Matrix a {
			 1.0f, 2.0f,  6.0f,
			-5.0f, 8.0f, -4.0f,
			 2.0f, 6.0f,  4.0f
		};
		assert_eq(cofactor3(a, 0, 0), 56.0f);
		assert_eq(cofactor3(a, 0, 1), 12.0f);
		assert_eq(cofactor3(a, 0, 2), -46.0f);
		assert_eq(det3(a), -196.0f);
	}
// ...
```

Define `det3`:

```c++
// ...
inline float cofactor3(const Matrix &a, int r, int c) {
	// ...
}
inline float det3(const Matrix &a) {
	float cf1 { cofactor3(a, 0, 0) };
	float cf2 { cofactor3(a, 0, 1) };
	float cf3 { cofactor3(a, 0, 2) };
	return a(0, 0) * cf1 + a(0, 1) * cf2 + a(0, 2) * cf3;
}
// ...
```

Test full determinant:


```c++
// ...
	// matrix-tests
	{ // full determinant
		Matrix a {
			-2.0f, -8.0f,  3.0f,  5.0f,
			-3.0f,  1.0f,  7.0f,  3.0f,
			 1.0f,  2.0f, -9.0f,  6.0f,
			-6.0f,  7.0f,  7.0f, -9.0f
		};
		assert_eq(cofactor4(a, 0, 0), 690.0f);
		assert_eq(cofactor4(a, 0, 1), 447.0f);
		assert_eq(cofactor4(a, 0, 2), 210.0f);
		assert_eq(cofactor4(a, 0, 3), 51.0f);
		assert_eq(det4(a), -4071.0f);
	}
// ...
```

Needs `cofactor4`:


```c++
// ...
inline float det3(const Matrix &a) {
	// ...
}
inline float cofactor4(const Matrix &a, int r, int c) {
	float m = minor4(a, r, c);
	return ((r + c) & 1) ? -m : m;
}
// ...
```

Needs `minor4`:

```c++
// ...
inline float det3(const Matrix &a) {
	// ...
}
inline float minor4(const Matrix &a, int r, int c) {
	return det3(sub(a, r, c));
}
// ...
```

Needs `det4`:

```c++
// ...
inline float cofactor4(const Matrix &a, int r, int c) {
	// ...
}
inline float det4(const Matrix &a) {
	float cf1 { cofactor4(a, 0, 0) };
	float cf2 { cofactor4(a, 0, 1) };
	float cf3 { cofactor4(a, 0, 2) };
	float cf4 { cofactor4(a, 0, 3) };
	return a(0, 0) * cf1 + a(0, 1) * cf2 + a(0, 2) * cf3 + a(0, 3) * cf4;
}
// ...
```

## Implementing Inversion

Check if matrix with negative determinant is invertible:

```c++
// ...
	// matrix-tests
	{ // negative determinant is invertible
		Matrix a {
			6.0f,  4.0f, 4.0f,  4.0f,
			5.0f,  5.0f, 7.0f,  6.0f,
			4.0f, -9.0f, 3.0f, -7.0f,
			9.0f,  1.0f, 7.0f, -6.0f
		};
		assert_eq(det4(a), -2120.0f);
		assert(is_invertible(a));
	}
// ...
```

Implement needed function:

```c++
// ...
#include "tuple.h"
inline bool is_invertible(const Matrix &a) {
	return ! eq(det4(a), 0.0f);
}
// ...
```

Check singular matrix:


```c++
// ...
	// matrix-tests
	{ // singular matrix is not invertible
		Matrix a {
			-4.0f,  2.0f, -2.0f,  3.0f,
			 9.0f,  6.0f,  2.0f,  6.0f,
			 0.0f, -5.0f,  1.0f, -5.0f,
			 0.0f,  0.0f,  0.0f,  0.0f
		};
		assert_eq(det4(a), 0.0f);
		assert(! is_invertible(a));
	}
// ...
```

Check full inversion:

```c++
// ...
	// matrix-tests
	{ // invert matrix
		Matrix a {
			-5.0f,  2.0f,  6.0f, -8.0f,
			 1.0f, -5.0f,  1.0f,  8.0f,
			 7.0f,  7.0f, -6.0f, -7.0f,
			 1.0f, -3.0f,  7.0f,  4.0f
		};
		assert_eq(det4(a), 532.0f);
		assert_eq(cofactor4(a, 2, 3), -160.0f);
		assert_eq(cofactor4(a, 3, 2), 105.0f);
		auto b { inv(a) };
		assert_eq(b(3, 2), -160.0f/532.0f);
		assert_eq(b(2, 3), 105.0f/532.0f);
		Matrix e {
			 0.21805f,  0.45113f,  0.24060f, -0.04511f,
			-0.80827f, -1.45677f, -0.44361f,  0.52068f,
			-0.07895f, -0.22368f, -0.05263f,  0.19737f,
			-0.52256f, -0.81391f, -0.30075f,  0.30639f
		};
		assert(b == e);
	}
// ...
```

Define `inv`:

```c++
// ...
inline bool is_invertible(const Matrix &a) {
	// ...
}
#include <stdexcept>
inline Matrix inv(const Matrix &a) {
	Matrix res {};
	float d { det4(a) };
	if (eq(d, 0.0f)) {
		throw std::invalid_argument("inv");
	}
	for (int r = 3; r >= 0; --r) {
		for (int c = 3; c >= 0; --c) {
			float cf = cofactor4(a, r, c);
			res(c, r) = cf / d;
		}
	}
	return res;
}
// ...
```

Needs default constructor:

```c++
// ...
class Matrix {
	public:
		Matrix() = default;
	// ...
};
// ...
```

Unit-Test for another matrix inversion:

```c++
// ...
	// matrix-tests
	{ // invert 2nd matrix
		Matrix a {
			 8.0f, -5.0f,  9.0f,  2.0f,
			 7.0f,  5.0f,  6.0f,  1.0f,
			-6.0f,  0.0f,  9.0f,  6.0f,
			-3.0f,  0.0f, -9.0f, -4.0f
		};
		Matrix e {
			-0.15385f, -0.15385f, -0.28205f, -0.53846f,
			-0.07692f,  0.12308f,  0.02564f,  0.03077f,
			 0.35897f,  0.35897f,  0.43590f,  0.92308f,
			-0.69231f, -0.69231f, -0.76923f, -1.92308f
		};
		assert(inv(a) == e);
	}
// ...
```

Unit-Test third matrix:

```c++
// ...
	// matrix-tests
	{ // invert 3rd matrix
		Matrix a {
			 9.0f,  3.0f,  0.0f,  9.0f,
			-5.0f, -2.0f, -6.0f, -3.0f,
			-4.0f,  9.0f,  6.0f,  4.0f,
			-7.0f,  6.0f,  6.0f,  2.0f
		};
		Matrix e {
			-0.04074f, -0.07778f,  0.14444f, -0.22222f,
			-0.07778f,  0.03333f,  0.36667f, -0.33333f,
			-0.02901f, -0.14630f, -0.10926f,  0.12963f,
			 0.17778f,  0.06667f, -0.26667f,  0.33333f
		};
		assert(inv(a) == e);
	}
// ...
```

Multiply a product by the inverse second matrix:

```c++
// ...
	// matrix-tests
	{ // multiply by inverse
		Matrix a {
			 3.0f, -9.0f,  7.0f,  3.0f,
			 3.0f, -8.0f,  2.0f, -9.0f,
			-4.0f,  4.0f,  4.0f,  1.0f,
			-6.0f,  5.0f, -1.0f,  1.0f
		};
		Matrix b {
			8.0f,  2.0f, 2.0f, 2.0f,
			3.0f, -1.0f, 7.0f, 0.0f,
			7.0f,  0.0f, 5.0f, 4.0f,
			6.0f, -2.0f, 0.0f, 5.0f
		};
		Matrix c { a * b };
		assert(c * inv(b) == a);
	}
// ...
```

The next part is in [4_translation.md](./4_translation.md).
