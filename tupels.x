# Points and Vectors

## Definition

```
@Def(types)
	struct Tuple {
		float x, y, z, w;
		bool is_point() const {
			return w == 1;
		}
		bool is_vector() const {
			return w == 0;
		}
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
	inline auto operator-(
		const Tuple &t
	) {
		return Tuple {
			-t.x, -t.y, -t.z, -t.w
		};
	}
@End(functions)
```

```
@Add(unit-tests) {
	Tuple a { 1, -2, 3, -4 };
	Tuple e { -1, 2, -3, 4 };
	assert(-a == e);
} @End(unit-tests)
