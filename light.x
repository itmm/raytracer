# Lighting

```
@Add(functions)
	inline Tuple normal_at(
		Sphere &s, const Tuple &w
	) {
		auto i { inv(s.transform) };
		auto o { i * w };
		auto on { o - mk_point(0, 0, 0) };
		auto wn { trans(i) * on };
		wn.w = 0;
		return norm(wn);
	}
@End(functions)
```

```
@Add(unit-tests) {
	Sphere s;
	auto p { mk_point(1, 0, 0) } ;
	auto n { normal_at(s, p) };
	auto e { mk_vector(1, 0, 0) };
	assert(n == e);
} @End(unit-tests)
```

```
@Add(unit-tests) {
	Sphere s;
	auto p { mk_point(0, 1, 0) } ;
	auto n { normal_at(s, p) };
	auto e { mk_vector(0, 1, 0) };
	assert(n == e);
} @End(unit-tests)
```

```
@Add(unit-tests) {
	Sphere s;
	auto p { mk_point(0, 0, 1) } ;
	auto n { normal_at(s, p) };
	auto e { mk_vector(0, 0, 1) };
	assert(n == e);
} @End(unit-tests)
```

```
@Add(unit-tests) {
	Sphere s;
	float f { sqrtf(3)/3 };
	auto p { mk_point(f, f, f) } ;
	auto n { normal_at(s, p) };
	auto e { mk_vector(f, f, f) };
	assert(n == e);
} @End(unit-tests)
```

```
@Add(unit-tests) {
	Sphere s;
	float f { sqrtf(3)/3 };
	auto p { mk_point(f, f, f) } ;
	auto n { normal_at(s, p) };
	assert(n == norm(n));
} @End(unit-tests)
```

```
@Add(unit-tests) {
	Sphere s;
	s.transform = translation(0, 1, 0);
	auto n { normal_at(s, mk_point(0, 1.70711, -0.70711)) };
	auto e { mk_vector(0, 0.70711, -0.70711) };
	assert(e == n);
} @End(unit-tests)
```

```
@Add(unit-tests) {
	Sphere s;
	s.transform = scaling(1, 0.5, 1) * rotate_z(M_PI/5);
	float f { sqrtf(2)/2 };
	auto n { normal_at(s, mk_point(0, f, -f)) };
	auto e { mk_vector(0, 0.97014, -0.24254) };
	assert(e == n);
} @End(unit-tests)
```
