# Points and Directions

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
	#define assert_eq(a, b) \
		assert(std::fabs( \
			(a) - (b)) < 1e-6 \
		)
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
