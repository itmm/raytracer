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
