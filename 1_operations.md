# Points and Vectors

## Adding Tuples

in `tuple.h`:

```c++
// ...
	// tuple-tests
	{ // adding two tuples
		auto p { mk_point(3, -2, 5) };
		auto v { mk_vector(-2, 3, 1) };
		Tuple e { 1, 1, 6, 1 };
		assert(p + v == e);
	}
// ...
```

```c++
// ...
// functions
constexpr auto operator+(const Tuple &a, const Tuple &b) {
	return Tuple {
		a.x + b.x, a.y + b.y,
		a.z + b.z, a.w + b.w
	};
}
// ...
```

## Subtracting Tuples

```c++
// ...
	// tuple-tests
	{ // subtracting two points
		auto p1 { mk_point(3, 2, 1) };
		auto p2 { mk_point(5, 6, 7) };
		auto e { mk_vector(-2, -4, -6) };
		assert(p1 - p2 == e);
	}
// ...
```

```c++
// ...
// functions
constexpr auto operator-(const Tuple &a, const Tuple &b) {
	return Tuple {
		a.x - b.x, a.y - b.y,
		a.z - b.z, a.w - b.w
	};
}
// ...
```

```c++
// ...
	// tuple-tests
	{ // subtracting a vector from a point
		auto p { mk_point(3, 2, 1) };
		auto v { mk_vector(5, 6, 7) };
		auto e { mk_point(-2, -4, -6) };
		assert(p - v == e);
	}
// ...
```

```c++
// ...
	// tuple-tests
	{ // subtracting two vectors
		auto v1 { mk_vector(3, 2, 1) };
		auto v2 { mk_vector(5, 6, 7) };
		auto e { mk_vector(-2, -4, -6) };
		assert(v1 - v2 == e);
	}
// ...
```

## Negating a Tuple

```c++
// ...
	// tuple-tests
	{ // subtracting a vector from zero vector
		auto zero { mk_vector(0, 0, 0) };
		auto v { mk_vector(1, -2, 3) };
		auto e { mk_vector(-1, 2, -3) };
		assert(zero - v == e);
	}
// ...
```

```c++
// ...
	// tuple-tests
	{ // negating a tuple
		Tuple a { 1, -2, 3, -4 };
		Tuple e { -1, 2, -3, 4 };
		assert(-a == e);
	}
// ...
```

```c++
// ...
// functions
constexpr auto operator-(const Tuple &t) {
	return -1 * t;
}
// ...
```

```c++
// ...
// functions
constexpr auto operator*(float f, const Tuple &t) {
	return Tuple {
		f * t.x, f * t.y,
		f * t.z, f * t.w
	};
}
// ...
```


## Scalar Multiplication

```c++
// ...
	// tuple-tests
	{ // multiplying a tuple by a scalar
		Tuple a { 1, -2, 3, -4 };
		Tuple e { 3.5, -7, 10.5, -14 };
		assert(3.5 * a == e);
	}
// ...
```

```c++
// ...
	// tuple-tests
	{ // multiplying a tuple by a fraction
		Tuple a { 1, -2, 3, -4 };
		Tuple e { 0.5, -1, 1.5, -2 };
		assert(0.5 * a == e);
	}
// ...
```

```c++
// ...
	// tuple-tests
	{ // dividing at tuple by a scalar
		Tuple a { 1, -2, 3, -4 };
		Tuple e { 0.5, -1, 1.5, -2 };
		assert(a/2 == e);
	}
// ...
```

```c++
// ...
// functions
// ...
constexpr auto operator*(float f, const Tuple &t) {
	// ...
}
constexpr auto operator/(const Tuple &t, float f) {
	return (1/f) * t;
}
// ...
```

## Magnitude

```
@Add(functions)
	inline constexpr float abs(const Tuple &t) {
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
	inline constexpr Tuple norm(const Tuple &t) {
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
	inline constexpr float dot(
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
	inline constexpr auto cross(
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
