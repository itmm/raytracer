# Points and Vectors

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

```
@Add(functions)
	inline Tuple mk_point(
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
	auto p = mk_point(4, -4, 3);
	auto e = Tuple { 4, -4, 3, 1 };
	assert(p == e);
} @End(unit-tests)
```

```
@Add(functions)
	inline Tuple mk_vector(
		float x, float y, float z
	) {
		return Tuple { x, y, z, 0 };
	}
@End(functions)
```

```
@Add(unit-tests) {
	auto v = mk_vector(4, -4, 3);
	auto e = Tuple { 4, -4, 3, 0 };
	assert(v == e);
} @End(unit-tests)
```
