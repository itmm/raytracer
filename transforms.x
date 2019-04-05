# Transformations

```
@Add(functions)
	constexpr inline Matrix translation(
		float dx, float dy, float dz
	) {
		return {
			1, 0, 0, dx,
			0, 1, 0, dy,
			0, 0, 1, dz,
			0, 0, 0, 1
		};
	}
@End(functions)
```

```
@Add(functions)
	std::ostream &operator<<(
		std::ostream &o, const Tuple &t
	) {
		o << '(' << t.x << "  " <<
			t.y << "  " << t.z <<
			"  " << t.w << ')';
		return o;
	}
@End(functions)
```

```
@Add(unit-tests) {
	auto t { translation(5, -3, 2) };
	auto p { mk_point(-3, 4, 5) };
	auto e { mk_point(2, 1, 7) };
	assert(t * p == e);
} @End(unit-tests)
```

```
@Add(unit-tests) {
	auto t { translation(5, -3, 2) };
	auto i { inv(t) };
	auto p { mk_point(-3, 4, 5) };
	auto e { mk_point(-8, 7, 3) };
	assert(i * p == e);
} @End(unit-tests)
```

```
@Add(unit-tests) {
	auto t { translation(5, -3, 2) };
	auto v { mk_vector(-3, 4, 5) };
	assert(t * v == v);
} @End(unit-tests)
```

```
@Add(functions)
	constexpr inline Matrix scaling(
		float sx, float sy, float sz
	) {
		return {
			sx, 0, 0, 0,
			0, sy, 0, 0,
			0, 0, sz, 0,
			0, 0, 0, 1
		};
	}
@End(functions)
```

```
@Add(unit-tests) {
	auto s { scaling(2, 3, 4) };
	auto p { mk_point(-4, 6, 8) };
	auto e { mk_point(-8, 18, 32) };
	assert(s * p == e);
} @End(unit-tests)
```

```
@Add(unit-tests) {
	auto s { scaling(2, 3, 4) };
	auto v { mk_vector(-4, 6, 8) };
	auto e { mk_vector(-8, 18, 32) };
	assert(s * v == e);
} @End(unit-tests)
```

```
@Add(unit-tests) {
	auto s { scaling(2, 3, 4) };
	auto i { inv(s) };
	auto v { mk_vector(-4, 6, 8) };
	auto e { mk_vector(-2, 2, 2) };
	assert(i * v == e);
} @End(unit-tests)
```

```
@Add(unit-tests) {
	auto s { scaling(-1, 1, 1) };
	auto p { mk_point(2, 3, 4) };
	auto e { mk_point(-2, 3, 4) };
	assert(s * p == e);
} @End(unit-tests)
```

```
@Add(functions)
	constexpr inline Matrix rotate_x(
		float ang
	) {
		float c { cosf(ang) };
		float s { sinf(ang) };
		return {
			1, 0, 0, 0,
			0, c, -s, 0,
			0, s, c, 0,
			0, 0, 0, 1
		};
	}
@End(functions)
```

```
@Add(unit-tests) {
	auto p { mk_point(0, 1, 0) };
	auto hq { rotate_x(M_PI/4) };
	auto fq { rotate_x(M_PI/2) };
	auto he { mk_point(0, sqrtf(2)/2, sqrtf(2)/2) };
	auto fe { mk_point(0, 0, 1) };
	assert(hq * p == he);
	assert(fq * p == fe);
} @End(unit-tests)
```

```
@Add(unit-tests) {
	auto p { mk_point(0, 1, 0) };
	auto hq { rotate_x(M_PI/4) };
	auto i { inv(hq) };
	auto e { mk_point(0, sqrtf(2)/2, -sqrtf(2)/2) };
	assert(i * p == e);
} @End(unit-tests)
```

```
@Add(functions)
	constexpr inline Matrix rotate_y(
		float ang
	) {
		float c { cosf(ang) };
		float s { sinf(ang) };
		return {
			c, 0, s, 0,
			0, 1, 0, 0,
			-s, 0, c, 0,
			0, 0, 0, 1
		};
	}
@End(functions)
```

```
@Add(unit-tests) {
	auto p { mk_point(0, 0, 1) };
	auto hq { rotate_y(M_PI/4) };
	auto fq { rotate_y(M_PI/2) };
	auto he { mk_point(sqrtf(2)/2, 0, sqrtf(2)/2) };
	auto fe { mk_point(1, 0, 0) };
	assert(hq * p == he);
	assert(fq * p == fe);
} @End(unit-tests)
```

```
@Add(functions)
	constexpr inline Matrix rotate_z(
		float ang
	) {
		float c { cosf(ang) };
		float s { sinf(ang) };
		return {
			c, -s, 0, 0,
			s, c, 0, 0,
			0, 0, 1, 0,
			0, 0, 0, 1
		};
	}
@End(functions)
```

```
@Add(unit-tests) {
	auto p { mk_point(0, 1, 0) };
	auto hq { rotate_z(M_PI/4) };
	auto fq { rotate_z(M_PI/2) };
	auto he { mk_point(-sqrtf(2)/2, sqrtf(2)/2, 0) };
	auto fe { mk_point(-1, 0, 0) };
	assert(hq * p == he);
	assert(fq * p == fe);
} @End(unit-tests)
```

```
@Add(functions)
	constexpr inline Matrix shearing(
		float xy, float xz, float yx,
		float yz, float zx, float zy
	) {
		return {
			1, xy, xz, 0,
			yx, 1, yz, 0,
			zx, zy, 1, 0,
			0, 0, 0, 1
		};
	}
@End(functions)
```

```
@Add(unit-tests) {
	auto s { shearing(1, 0, 0, 0, 0, 0) };
	auto p { mk_point(2, 3, 4) };
	auto e { mk_point(5, 3, 4) };
	assert(s * p == e);
} @End(unit-tests)
```

```
@Add(unit-tests) {
	auto s { shearing(0, 1, 0, 0, 0, 0) };
	auto p { mk_point(2, 3, 4) };
	auto e { mk_point(6, 3, 4) };
	assert(s * p == e);
} @End(unit-tests)
```

```
@Add(unit-tests) {
	auto s { shearing(0, 0, 1, 0, 0, 0) };
	auto p { mk_point(2, 3, 4) };
	auto e { mk_point(2, 5, 4) };
	assert(s * p == e);
} @End(unit-tests)
```

```
@Add(unit-tests) {
	auto s { shearing(0, 0, 0, 1, 0, 0) };
	auto p { mk_point(2, 3, 4) };
	auto e { mk_point(2, 7, 4) };
	assert(s * p == e);
} @End(unit-tests)
```

```
@Add(unit-tests) {
	auto s { shearing(0, 0, 0, 0, 1, 0) };
	auto p { mk_point(2, 3, 4) };
	auto e { mk_point(2, 3, 6) };
	assert(s * p == e);
} @End(unit-tests)
```

```
@Add(unit-tests) {
	auto s { shearing(0, 0, 0, 0, 0, 1) };
	auto p { mk_point(2, 3, 4) };
	auto e { mk_point(2, 3, 7) };
	assert(s * p == e);
} @End(unit-tests)
```

```
@Add(unit-tests) {
	auto p { mk_point(1, 0, 1) };
	auto a { rotate_x(M_PI/2) };
	auto b { scaling(5, 5, 5) };
	auto c { translation(10, 5, 7) };
	auto p2 { a * p };
	auto e2 { mk_point(1, -1, 0) };
	assert(p2 == e2);
	auto p3 { b * p2 };
	auto e3 { mk_point(5, -5, 0) };
	assert(p3 == e3);
	auto p4 { c * p3 };
	auto e4 { mk_point(15, 0, 7) };
	assert(p4 == e4);
} @End(unit-tests)
```

```
@Add(unit-tests) {
	auto p { mk_point(1, 0, 1) };
	auto a { rotate_x(M_PI/2) };
	auto b { scaling(5, 5, 5) };
	auto c { translation(10, 5, 7) };
	auto t { c * b * a };
	auto e { mk_point(15, 0, 7) };
	assert(t * p == e);
} @End(unit-tests)
```

