# Points and Vectors

## Definition

```
@Def(types)
	struct Tuple {
		float x, y, z, w;
		@put(methods);
	};
@End(types)
```

```
@Def(includes)
	#include <cassert>
	#include <cmath>
@End(includes)
```

```
@Def(functions)
	inline bool eq(float a, float b) {
		return std::fabs(a - b) < 1e-5;
	}
@End(functions)
```

```
@Add(functions)
	#define assert_eq(a, b) \
		assert(eq((a), (b)))
@End(functions)
```

```
@def(methods)
	bool is_point() const {
		return w == 1;
	}
@end(methods)
```

```
@add(methods)
	bool is_vector() const {
		return w == 0;
	}
@end(methods)
```

```
@Def(unit-tests) {
	Tuple a { 4.3, -4.2, 3.1, 1 };
	assert_eq(a.x, 4.3);
	assert_eq(a.y, -4.2);
	assert_eq(a.z, 3.1);
	assert(a.w == 1);
	assert(a.is_point());
	assert(! a.is_vector());
} @End(unit-tests)
```

```
@Add(unit-tests) {
	Tuple a { 4.3, -4.2, 3.1, 0 };
	assert_eq(a.x, 4.3);
	assert_eq(a.y, -4.2);
	assert_eq(a.z, 3.1);
	assert(a.w == 0);
	assert(! a.is_point());
	assert(a.is_vector());
} @End(unit-tests)
```

## Create Points and Vectors

```
@Add(functions)
	inline auto mk_point(
		float x, float y, float z
	) {
		return Tuple { x, y, z, 1 };
	}
@End(functions)
```

```
@Add(functions)
	bool operator==(
		const Tuple &a, const Tuple &b
	) {
		return a.w == b.w &&
			eq(a.x, b.x) &&
			eq(a.y, b.y) &&
			eq(a.z, b.z);
	}
@End(functions)
```

```
@Add(unit-tests) {
	auto p { mk_point(4, -4, 3) };
	Tuple e { 4, -4, 3, 1 };
	assert(p == e);
} @End(unit-tests)
```

```
@Add(functions)
	inline auto mk_vector(
		float x, float y, float z
	) {
		return Tuple { x, y, z, 0 };
	}
@End(functions)
```

```
@Add(unit-tests) {
	auto v { mk_vector(4, -4, 3) };
	Tuple e { 4, -4, 3, 0 };
	assert(v == e);
} @End(unit-tests)
```

## Adding Tupels

```
@Add(functions)
	inline auto operator+(
		const Tuple &a, const Tuple &b
	) {
		return Tuple {
			a.x + b.x, a.y + b.y,
			a.z + b.z, a.w + b.w
		};
	}
@End(functions)
```

```
@Add(unit-tests) {
	auto p { mk_point(3, -2, 5) };
	auto v { mk_vector(-2, 3, 1) };
	Tuple e { 1, 1, 6, 1 };
	assert(p + v == e);
} @End(unit-tests)
```

## Subtracting Tupels

```
@Add(functions)
	inline auto operator-(
		const Tuple &a, const Tuple &b
	) {
		return Tuple {
			a.x - b.x, a.y - b.y,
			a.z - b.z, a.w - b.w
		};
	}
@End(functions)
```

```
@Add(unit-tests) {
	auto p1 { mk_point(3, 2, 1) };
	auto p2 { mk_point(5, 6, 7) };
	auto e { mk_vector(-2, -4, -6) };
	assert(p1 - p2 == e);
} @End(unit-tests)
```

```
@Add(unit-tests) {
	auto p { mk_point(3, 2, 1) };
	auto v { mk_vector(5, 6, 7) };
	auto e { mk_point(-2, -4, -6) };
	assert(p - v == e);
} @End(unit-tests)
```

```
@Add(unit-tests) {
	auto v1 { mk_vector(3, 2, 1) };
	auto v2 { mk_vector(5, 6, 7) };
	auto e { mk_vector(-2, -4, -6) };
	assert(v1 - v2 == e);
} @End(unit-tests)
```

## Negating a Tuple

```
@Add(unit-tests) {
	auto zero { mk_vector(0, 0, 0) };
	auto v { mk_vector(1, -2, 3) };
	auto e { mk_vector(-1, 2, -3) };
	assert(zero - v == e);
} @End(unit-tests)
```

```
@Add(functions)
	inline auto operator*(
		float f, const Tuple &t
	) {
		return Tuple {
			f * t.x, f * t.y,
			f * t.z, f * t.w
		};
	}
@End(functions)
```

```
@Add(functions)
	inline auto operator-(
		const Tuple &t
	) {
		return -1 * t;
	}
@End(functions)
```

```
@Add(unit-tests) {
	Tuple a { 1, -2, 3, -4 };
	Tuple e { -1, 2, -3, 4 };
	assert(-a == e);
} @End(unit-tests)
```

## Scalar Multiplication

```
@Add(unit-tests) {
	Tuple a { 1, -2, 3, -4 };
	Tuple e { 3.5, -7, 10.5, -14 };
	assert(3.5 * a == e);
} @End(unit-tests)
```

```
@Add(unit-tests) {
	Tuple a { 1, -2, 3, -4 };
	Tuple e { 0.5, -1, 1.5, -2 };
	assert(0.5 * a == e);
} @End(unit-tests)
```

```
@Add(functions)
	inline auto operator/(
		const Tuple &t, float f
	) {
		return (1/f) * t;
	}
@End(functions)
```

```
@Add(unit-tests) {
	Tuple a { 1, -2, 3, -4 };
	Tuple e { 0.5, -1, 1.5, -2 };
	assert(a/2 == e);
} @End(unit-tests)
```

## Magnitude

```
@Add(functions)
	inline float abs(const Tuple &t) {
		return sqrtf(
			t.x * t.x + t.y * t.y +
			t.z * t.z + t.w * t.w
		);
	}
@End(functions)
```

```
@Add(unit-tests) {
	auto v { mk_vector(1, 0, 0) };
	assert_eq(1, abs(v));
} @End(unit-tests)
```

```
@Add(unit-tests) {
	auto v { mk_vector(0, 1, 0) };
	assert_eq(1, abs(v));
} @End(unit-tests)
```

```
@Add(unit-tests) {
	auto v { mk_vector(0, 0, 1) };
	assert_eq(1, abs(v));
} @End(unit-tests)
```

```
@Add(unit-tests) {
	auto v { mk_vector(1, 2, 3) };
	assert_eq(sqrtf(14), abs(v));
} @End(unit-tests)
```

```
@Add(unit-tests) {
	auto v { mk_vector(-1, -2, -3) };
	assert_eq(sqrtf(14), abs(v));
} @End(unit-tests)
```

# Normalization

```
@Add(functions)
	inline Tuple norm(const Tuple &t) {
		float m = abs(t);
		return eq(m, 1) ? t : t/m;
	}
@End(functions)
```

```
@Add(unit-tests) {
	auto v { mk_vector(4, 0, 0) };
	auto e { mk_vector(1, 0, 0) };
	assert(norm(v) == e);
} @End(unit-tests)
```

```
@Add(unit-tests) {
	auto v { mk_vector(1, 2, 3) };
	auto e { mk_vector(
		0.26726, 0.53452, 0.80178
	) };
	assert(norm(v) == e);
} @End(unit-tests)
```

```
@Add(unit-tests) {
	auto v { mk_vector(1, 2, 3) };
	assert_eq(1, abs(norm(v)));
} @End(unit-tests)
```

## Dot Product

```
@Add(functions)
	inline float dot(
		const Tuple &a, const Tuple &b
	) {
		return a.x * b.x + a.y * b.y +
			a.z * b.z + a.w * b.w;
	}
@End(functions)
```

```
@Add(unit-tests) {
	auto a { mk_vector(1, 2, 3) };
	auto b { mk_vector(2, 3, 4) };
	assert_eq(20, dot(a, b));
} @End(unit-tests)
```

## Cross Product

```
@Add(functions)
	inline auto cross(
		const Tuple &a, const Tuple &b
	) {
		return mk_vector(
			a.y * b.z - a.z * b.y,
			a.z * b.x - a.x * b.z,
			a.x * b.y - a.y * b.x
		);
	}
@End(functions)
```

```
@Add(unit-tests) {
	auto a { mk_vector(1, 2, 3) };
	auto b { mk_vector(2, 3, 4) };
	auto e { mk_vector(-1, 2, -1) };
	assert(cross(a, b) == e);
	assert(cross(b, a) == -e);
} @End(unit-tests)
```
