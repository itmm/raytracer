# Matrices

```
@Add(types)
	class Matrix {
		public:
			@put(methods);
		private:
			float _v[16];
	};
@End(types)
```

```
@def(methods)
	constexpr Matrix(
		float m00, float m01,
			float m02, float m03,
		float m10, float m11,
			float m12, float m13,
		float m20, float m21,
			float m22, float m23,
		float m30, float m31,
			float m32, float m33
	): _v {
		m00, m01, m02, m03,
		m10, m11, m12, m13,
		m20, m21, m22, m23,
		m30, m31, m32, m33
	} {}
@end(methods)
```

```
@add(methods)
	constexpr float operator()(
		int r, int c
	) const {
		return _v[r * 4 + c];
	}
@end(methods)
```

```
@add(methods)
	float &operator()(
		int r, int c
	) {
		return _v[r * 4 + c];
	}
@end(methods)
```

```
@Add(unit-tests) {
	Matrix m {
		1, 2, 3, 4,
		5.5, 6.5, 7.5, 8.5,
		9, 10, 11, 12,
		13.5, 14.5, 15.5, 16.5
	};
	assert_eq(m(0, 0), 1);
	assert_eq(m(0, 3), 4);
	assert_eq(m(1, 0), 5.5);
	assert_eq(m(1, 2), 7.5);
	assert_eq(m(2, 2), 11);
	assert_eq(m(3, 0), 13.5);
	assert_eq(m(3, 2), 15.5);
} @End(unit-tests)
```

```
@add(methods)
	constexpr Matrix(
		float m00, float m01,
		float m10, float m11
	): _v {
		m00, m01, 0, 0,
		m10, m11, 0, 0,
		0, 0, 0, 0,
		0, 0, 0, 0
	} {}
@end(methods)
```

```
@Add(unit-tests) {
	Matrix m {
		-3, 5,
		1, -2
	};
	assert_eq(m(0, 0), -3);
	assert_eq(m(0, 1), 5);
	assert_eq(m(1, 0), 1);
	assert_eq(m(1, 1), -2);
} @End(unit-tests)
```

```
@add(methods)
	constexpr Matrix(
		float m00, float m01, float m02,
		float m10, float m11, float m12,
		float m20, float m21, float m22
	): _v {
		m00, m01, m02, 0,
		m10, m11, m12, 0,
		m20, m21, m22, 0,
		0, 0, 0, 0
	} {}
@end(methods)
```

```
@Add(unit-tests) {
	Matrix m {
		-3, 5, 0,
		1, -2, -7,
		0, 1, 1
	};
	assert_eq(m(0, 0), -3);
	assert_eq(m(1, 1), -2);
	assert_eq(m(2, 2), 1);
} @End(unit-tests)
```

```
@add(methods)
	friend constexpr bool operator==(
		const Matrix &a, const Matrix &b
	);
@end(methods)
```

```
@Add(functions)
	inline constexpr bool operator==(
		const Matrix &a, const Matrix &b
	) {
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
@End(functions)
```

```
@Add(unit-tests) {
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
} @End(unit-tests)
```

```
@Add(functions)
	inline constexpr bool operator!=(
		const Matrix &a, const Matrix &b
	) {
		return !(a == b);
	}
@End(functions)
```

```
@Add(unit-tests) {
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
} @End(unit-tests)
```

```
@add(methods)
	Matrix() = default;
@end(methods)
```

```
@Add(functions)
	inline constexpr float mult_line(
		const Matrix &a, const Matrix &b,
		int r, int c
	) {
		return a(r, 0) * b(0, c) +
			a(r, 1) * b(1, c) +
			a(r, 2) * b(2, c) +
			a(r, 3) * b(3, c);
	}
@End(functions)
```

```
@Add(functions)
	inline constexpr Matrix operator*(
		const Matrix &a, const Matrix &b
	) {
		return {
			mult_line(a, b, 0, 0),
			mult_line(a, b, 0, 1),
			mult_line(a, b, 0, 2),
			mult_line(a, b, 0, 3),
			mult_line(a, b, 1, 0),
			mult_line(a, b, 1, 1),
			mult_line(a, b, 1, 2),
			mult_line(a, b, 1, 3),
			mult_line(a, b, 2, 0),
			mult_line(a, b, 2, 1),
			mult_line(a, b, 2, 2),
			mult_line(a, b, 2, 3),
			mult_line(a, b, 3, 0),
			mult_line(a, b, 3, 1),
			mult_line(a, b, 3, 2),
			mult_line(a, b, 3, 3)
		};
	}
@End(functions)
```

```
@Add(functions)
	std::ostream &operator<<(std::ostream &o, const Matrix &m) {
		o << "(\n";
		for (int r = 0; r < 4; ++r) {
			o << "  (";
			o << m(r, 0);
			for (int c = 1; c < 4; ++c) {
				o << "  " << m(r, c);
			}
			o << ")\n";
		}
		o << ')';
		return o;
	}
@End(functions)
```

```
@Add(unit-tests) {
	Matrix a {
		1, 2, 3, 4,
		5, 6, 7, 8,
		9, 8, 7, 6,
		5, 4, 3, 2
	};
	Matrix b {
		-2, 1, 2, 3,
		3, 2, 1, -1,
		4, 3, 6, 5,
		1, 2, 7, 8
	};
	Matrix e {
		20, 22, 50, 48,
		44, 54, 114, 108,
		40, 58, 110, 102,
		16, 26, 46, 42
	};
	assert(a * b == e);
} @End(unit-tests)
```

```
@Add(functions)
	inline constexpr float mult_line(
		const Matrix &a, const Tuple &t,
		int r
	) {
		return a(r, 0) * t.x +
			a(r, 1) * t.y +
			a(r, 2) * t.z +
			a(r, 3) * t.w;
	}
@End(functions)
```

```
@Add(functions)
	inline constexpr Tuple operator*(
		const Matrix &a, const Tuple &t
	) {
		return {
			mult_line(a, t, 0),
			mult_line(a, t, 1),
			mult_line(a, t, 2),
			mult_line(a, t, 3)
		};
	}
@End(functions)
```

```
@Add(unit-tests) {
	Matrix a {
		1, 2, 3, 4,
		2, 4, 4, 2,
		8, 6, 4, 1,
		0, 0, 0, 1
	};
	Tuple t { 1, 2, 3, 1 };
	Tuple e { 18, 24, 33, 1 };
	assert(a * t == e);
} @End(unit-tests)
```

```
@Add(types)
	constexpr Matrix identity {
		1, 0, 0, 0,
		0, 1, 0, 0,
		0, 0, 1, 0,
		0, 0, 0, 1
	};
@End(types)
```

```
@Add(unit-tests) {
	Matrix a {
		0, 1, 2, 4,
		1, 2, 4, 8,
		2, 4, 8, 16,
		4, 8, 16, 32
	};
	assert(a * identity == a);
} @End(unit-tests)
```

```
@Add(unit-tests) {
	Tuple t {
		1, 2, 3, 4
	};
	assert(identity * t == t);
} @End(unit-tests)
```

```
@Add(functions)
	inline constexpr Matrix trans(
		const Matrix &a
	) {
		return {
			a(0, 0), a(1, 0),
				a(2, 0), a(3, 0),
			a(0, 1), a(1, 1),
				a(2, 1), a(3, 1),
			a(0, 2), a(1, 2),
				a(2, 2), a(3, 2),
			a(0, 3), a(1, 3),
				a(2, 3), a(3, 3)
		};
	}
@End(functions)
```

```
@Add(unit-tests) {
	Matrix a {
		0, 9, 3, 0,
		9, 8, 0, 8,
		1, 8, 5, 3,
		0, 0, 5, 8
	};
	Matrix e {
		0, 9, 1, 0,
		9, 8, 8, 0,
		3, 0, 5, 5,
		0, 8, 3, 8
	};
	assert(trans(a) == e);
} @End(unit-tests)
```

```
@Add(unit-tests) {
	assert(trans(identity) == identity);
} @End(unit-tests)
```

```
@Add(functions)
	inline constexpr float det2(
		const Matrix &a
	) {
		return a(0, 0) * a(1, 1) -
			a(0, 1) * a(1, 0);
	}
@End(functions)
```

```
@Add(unit-tests) {
	Matrix a {
		1, 5,
		-3, 2
	};
	assert_eq(17, det2(a));
} @End(unit-tests)
```

```
@Add(functions)
	Matrix sub(Matrix a, int r, int c) {
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
			a(i, 3) = 0;
			a(3, i) = 0;
		}
		return a;
	}
@End(functions)
```

```
@Add(unit-tests) {
	Matrix a {
		1, 5, 0,
		-3, 2, 7,
		0, 6, -3
	};
	Matrix e {
		-3, 2,
		0, 6
	};
	assert(sub(a, 0, 2) == e);
} @End(unit-tests)
```

```
@Add(unit-tests) {
	Matrix a {
		-6, 1, 1, 6,
		-8, 5, 8, 6,
		-1, 0, 8, 2,
		-7, 1, -1, 1
	};
	Matrix e {
		-6, 1, 6,
		-8, 8, 6,
		-7, -1, 1
	};
	assert(sub(a, 2, 1) == e);
} @End(unit-tests)
```

```
@Add(functions)
	inline float minor3(
		const Matrix &a, int r, int c
	) {
		return det2(sub(a, r, c));
	}
@End(functions)
```

```
@Add(unit-tests) {
	Matrix a {
		3, 5, 0,
		2, -1, -7,
		6, -1, 5
	};
	assert_eq(det2(sub(a, 1, 0)), 25);
	assert_eq(minor3(a, 1, 0), 25);
} @End(unit-tests)
```

```
@Add(functions)
	inline float cofactor3(
		const Matrix &a, int r, int c
	) {
		float m = minor3(a, r, c);
		return ((r + c) & 1) ? -m : m;
	}
@End(functions)
```

```
@Add(unit-tests) {
	Matrix a {
		3, 5, 0,
		2, -1, -7,
		6, -1, 5
	};
	assert_eq(minor3(a, 0, 0), -12);
	assert_eq(cofactor3(a, 0, 0), -12);
	assert_eq(minor3(a, 1, 0), 25);
	assert_eq(cofactor3(a, 1, 0), -25);
} @End(unit-tests)
```

```
@Add(functions)
	inline float det3(
		const Matrix &a
	) {
		float cf1 { cofactor3(a, 0, 0) };
		float cf2 { cofactor3(a, 0, 1) };
		float cf3 { cofactor3(a, 0, 2) };
		return a(0, 0) * cf1 +
			a(0, 1) * cf2 +
			a(0, 2) * cf3;
	}
@End(functions)
```

```
@Add(unit-tests) {
	Matrix a {
		1, 2, 6,
		-5, 8, -4,
		2, 6, 4
	};
	assert_eq(cofactor3(a, 0, 0), 56);
	assert_eq(cofactor3(a, 0, 1), 12);
	assert_eq(cofactor3(a, 0, 2), -46);
	assert_eq(det3(a), -196);
} @End(unit-tests)
```

```
@Add(functions)
	inline float minor4(
		const Matrix &a, int r, int c
	) {
		return det3(sub(a, r, c));
	}
@End(functions)
```

```
@Add(functions)
	inline float cofactor4(
		const Matrix &a, int r, int c
	) {
		float m = minor4(a, r, c);
		return ((r + c) & 1) ? -m : m;
	}
@End(functions)
```

```
@Add(functions)
	inline float det4(
		const Matrix &a
	) {
		float cf1 { cofactor4(a, 0, 0) };
		float cf2 { cofactor4(a, 0, 1) };
		float cf3 { cofactor4(a, 0, 2) };
		float cf4 { cofactor4(a, 0, 3) };
		return a(0, 0) * cf1 +
			a(0, 1) * cf2 +
			a(0, 2) * cf3 +
			a(0, 3) * cf4;
	}
@End(functions)
```

```
@Add(unit-tests) {
	Matrix a {
		-2, -8, 3, 5,
		-3, 1, 7, 3,
		1, 2, -9, 6,
		-6, 7, 7, -9
	};
	assert_eq(cofactor4(a, 0, 0), 690);
	assert_eq(cofactor4(a, 0, 1), 447);
	assert_eq(cofactor4(a, 0, 2), 210);
	assert_eq(cofactor4(a, 0, 3), 51);
	assert_eq(det4(a), -4071);
} @End(unit-tests)
```

```
@Add(functions)
	inline bool is_invertible(
		const Matrix &a
	) {
		return ! eq(det4(a), 0);
	}
@End(functions)
```

```
@Add(unit-tests) {
	Matrix a {
		6, 4, 4, 4,
		5, 5, 7, 6,
		4, -9, 3, -7,
		9, 1, 7, -6
	};
	assert_eq(det4(a), -2120);
	assert(is_invertible(a));
} @End(unit-tests)
```

```
@Add(unit-tests) {
	Matrix a {
		-4, 2, -2, 3,
		9, 6, 2, 6,
		0, -5, 1, -5,
		0, 0, 0, 0
	};
	assert_eq(det4(a), 0);
	assert(! is_invertible(a));
} @End(unit-tests)
```

```
@Add(includes)
	#include <exception>
@End(includes)
```

```
@Add(functions)
	Matrix inv(const Matrix &a) {
		Matrix res {};
		float d { det4(a) };
		if (eq(d, 0)) {
			std::cerr << a << '\n';
			throw std::invalid_argument("inv");
		}
		for (int r = 3; r >= 0; --r) {
			for (int c = 3; c >= 0; --c) {
				float cf = cofactor4(
					a, r, c
				);
				res(c, r) = cf / d;
			}
		}
		return res;
	}
@End(functions)
```

```
@Add(unit-tests) {
	Matrix a {
		-5, 2, 6, -8,
		1, -5, 1, 8,
		7, 7, -6, -7,
		1, -3, 7, 4
	};
	assert_eq(det4(a), 532);
	assert_eq(cofactor4(a, 2, 3), -160);
	assert_eq(cofactor4(a, 3, 2), 105);
	auto b { inv(a) };
	assert_eq(b(3, 2), -160.0/532.0);
	assert_eq(b(2, 3), 105.0/532.0);
	Matrix e {
		0.21805, 0.45113, 0.24060, -0.04511,
		-0.80827, -1.45677, -0.44361, 0.52068,
		-0.07895, -0.22368, -0.05263, 0.19737,
		-0.52256, -0.81391, -0.30075, 0.30639
	};
	assert(b == e);
} @End(unit-tests)
```

```
@Add(unit-tests) {
	Matrix a {
		8, -5, 9, 2,
		7, 5, 6, 1,
		-6, 0, 9, 6,
		-3, 0, -9, -4
	};
	Matrix e {
		-0.15385, -0.15385, -0.28205, -0.53846,
		-0.07692, 0.12308, 0.02564, 0.03077,
		0.35897, 0.35897, 0.43590, 0.92308,
		-0.69231, -0.69231, -0.76923, -1.92308
	};
	assert(inv(a) == e);
} @End(unit-tests)
```

```
@Add(unit-tests) {
	Matrix a {
		9, 3, 0, 9,
		-5, -2, -6, -3,
		-4, 9, 6, 4,
		-7, 6, 6, 2
	};
	Matrix e {
		-0.04074, -0.07778, 0.14444, -0.22222,
		-0.07778, 0.03333, 0.36667, -0.33333,
		-0.02901, -0.14630, -0.10926, 0.12963,
		0.17778, 0.06667, -0.26667, 0.33333
	};
	assert(inv(a) == e);
} @End(unit-tests)
```

```
@Add(unit-tests) {
	Matrix a {
		3, -9, 7, 3,
		3, -8, 2, -9,
		-4, 4, 4, 1,
		-6, 5, -1, 1
	};
	Matrix b {
		8, 2, 2, 2,
		3, -1, 7, 0,
		7, 0, 5, 4,
		6, -2, 0, 5
	};
	Matrix c { a * b };
	assert(c * inv(b) == a);
} @End(unit-tests)
```
