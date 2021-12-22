# Points and Vectors

## Adding Tuples

The next unit-test in `tuple.h` tries to add a tuple with a point:

```c++
// ...
	// tuple-tests
	{ // adding two tuples
		auto p { mk_point(3.0f, -2.0f, 5.0f) };
		auto v { mk_vector(-2.0f, 3.0f, 1.0f) };
		Tuple e { 1.0f, 1.0f, 6.0f, 1.0f };
		assert(p + v == e);
	}
// ...
```
It fails, because the addition operation is not defined yet:

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

Now the unit-test passes.


## Subtracting Tuples

The next test tries to subtract two points. The result should be a vector:

```c++
// ...
	// tuple-tests
	{ // subtracting two points
		auto p1 { mk_point(3.0f, 2.0f, 1.0f) };
		auto p2 { mk_point(5.0f, 6.0f, 7.0f) };
		auto e { mk_vector(-2.0f, -4.0f, -6.0f) };
		assert(p1 - p2 == e);
	}
// ...
```

This test fails, because the subtraction operation is not defined yet:

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

The next test validates that it is possible to subtract a vector from a
point. The result is a point:

```c++
// ...
	// tuple-tests
	{ // subtracting a vector from a point
		auto p { mk_point(3.0f, 2.0f, 1.0f) };
		auto v { mk_vector(5.0f, 6.0f, 7.0f) };
		auto e { mk_point(-2.0f, -4.0f, -6.0f) };
		assert(p - v == e);
	}
// ...
```

This unit-test checks that two vectors can be subtracted from each other.
The result is a vector:

```c++
// ...
	// tuple-tests
	{ // subtracting two vectors
		auto v1 { mk_vector(3.0f, 2.0f, 1.0f) };
		auto v2 { mk_vector(5.0f, 6.0f, 7.0f) };
		auto e { mk_vector(-2.0f, -4.0f, -6.0f) };
		assert(v1 - v2 == e);
	}
// ...
```

## Negating a Tuple

Negating a tuple can be achieved by subtracting it from the zero vector:

```c++
// ...
	// tuple-tests
	{ // subtracting a vector from zero vector
		auto zero { mk_vector(0.0f, 0.0f, 0.0f) };
		auto v { mk_vector(1.0f, -2.0f, 3.0f) };
		auto e { mk_vector(-1.0f, 2.0f, -3.0f) };
		assert(zero - v == e);
	}
// ...
```

But a faster way should be possible:

```c++
// ...
	// tuple-tests
	{ // negating a tuple
		Tuple a { 1.0f, -2.0f, 3.0f, -4.0f };
		Tuple e { -1.0f, 2.0f, -3.0f, 4.0f };
		assert(-a == e);
	}
// ...
```

The test fails, because the negation operation is not defined yet:

```c++
// ...
// functions
constexpr auto operator-(const Tuple &t) {
	return -1.0f * t;
}
// ...
```

The test still fails, because the scalar multiplication (that is used
by the negation) is not defined yet.

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

Now the test is running.


## Scalar Multiplication

The scalar multiplication is already working, because it was needed to
implement the negation:

```c++
// ...
	// tuple-tests
	{ // multiplying a tuple by a scalar
		Tuple a { 1.0f, -2.0f, 3.0f, -4.0f };
		Tuple e { 3.5f, -7.0f, 10.5f, -14.0f };
		assert(3.5f * a == e);
	}
// ...
```

It does not matter, if the scalar is only a fraction:

```c++
// ...
	// tuple-tests
	{ // multiplying a tuple by a fraction
		Tuple a { 1.0f, -2.0f, 3.0f, -4.0f };
		Tuple e { 0.5f, -1.0f, 1.5f, -2.0f };
		assert(0.5f * a == e);
	}
// ...
```

## Scalar Division

But the direct division is not working yet:

```c++
// ...
	// tuple-tests
	{ // dividing at tuple by a scalar
		Tuple a { 1.0f, -2.0f, 3.0f, -4.0f };
		Tuple e { 0.5f, -1.0f, 1.5f, -2.0f };
		assert(a/2.0f == e);
	}
// ...
```

So the division operation is implemented. As it uses the multiplication
it must be inserted after the multiplication operation:

```c++
// ...
// functions
// ...
constexpr auto operator*(float f, const Tuple &t) {
	// ...
}
constexpr auto operator/(const Tuple &t, float f) {
	return (1.0f/f) * t;
}
// ...
```

## Magnitude

Check if the magnitude of the first unit-vector is one:

```c++
// ...
	// tuple-tests
	{ // checking length of first unit-vector
		auto v { mk_vector(1.0f, 0.0f, 0.0f) };
		assert_eq(1.0f, abs(v));
	}
// ...
```

The test fails, because the function is not defined yet:

```c++
// ...
// functions
constexpr float abs(const Tuple &t) {
	return sqrtf(
		t.x * t.x + t.y * t.y +
		t.z * t.z + t.w * t.w
	);
}
// ...
```

Check the length of the other unit-vectors:

```c++
// ...
	// tuple-tests
	{ // checking length of second unit-vector
		auto v { mk_vector(0.0f, 1.0f, 0.0f) };
		assert_eq(1.0f, abs(v));
	}
	{ // checking length of third unit-vector
		auto v { mk_vector(0.0f, 0.0f, 1.0f) };
		assert_eq(1.0f, abs(v));
	}
// ...
```

The next two tests check vectors that are not unit-vectors:

```c++
// ...
	// tuple-tests
	{ // check length on non-unit vector
		auto v { mk_vector(1.0f, 2.0f, 3.0f) };
		assert_eq(sqrtf(14.0f), abs(v));
	}
	{ // check length of negated non-unit vector
		auto v { mk_vector(-1.0f, -2.0f, -3.0f) };
		assert_eq(sqrtf(14.0f), abs(v));
	}
// ...
```


# Normalization

Try a simple normalization:

```c++
// ...
	// tuple-tests
	{ // normalize (4, 0, 0)
		auto v { mk_vector(4.0f, 0.0f, 0.0f) };
		auto e { mk_vector(1.0f, 0.0f, 0.0f) };
		assert(norm(v) == e);
	}
// ...
```

Of course, the test is not working, because the function is not defined yet:

```c++
// ...
// functions
// ...
constexpr auto operator/(const Tuple &t, float f) {
	// ...
}
constexpr Tuple norm(const Tuple &t) {
	float m = abs(t);
	return eq(m, 1.0f) ? t : t/m;
}
// ...
```

The function must be put in the right place to see the division and length
function.

Now I can also test a different vector:

```c++
// ...
	// tuple-tests
	{ // normalizing (1, 2, 3)
		auto v { mk_vector(1.0f, 2.0f, 3.0f) };
		auto e { mk_vector(
			0.26726f, 0.53452f, 0.80178f
		) };
		assert(norm(v) == e);
	}
// ...
```

Just to be safe, another test verifies that the length of the result is
right:

```c++
// ...
	// tuple-tests
	{ // length of norm vector
		auto v { mk_vector(1.0f, 2.0f, 3.0f) };
		assert_eq(1.0f, abs(norm(v)));
	}
// ...
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
