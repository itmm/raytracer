# Shadows

```
@Add(unit-tests) {
	Material m;
	auto pos { mk_point(0, 0, 0) };
	auto eyev { mk_vector(0, 0, -1) };
	auto normalv { mk_vector(0, 0, -1) };
	Point_Light l { mk_point(0, 0, -10), { 1, 1, 1 } };
	bool in_shadow = true;
	Color e { 0.1, 0.1, 0.1 };
	assert(lighting(m, l, pos, eyev, normalv, in_shadow) == e);
} @End(unit-tests)
```

```
@Add(functions)
	bool is_shadowed(const World &w, const Tuple &p) {
		for (auto &l : w.lights) {
			auto v = l->position - p;
			float dist = abs(v);
			auto dir { norm(v) };
			Ray r { p, dir };
			auto xs { intersect_world(w, r) };
			auto h { hit(xs) };
			if (h != xs.end() && h->t < dist) {
				return true;
			}
		}
		return false;
	}
@End(functions)
```

```
@Add(unit-tests) {
	auto w = default_world();
	assert(! is_shadowed(w, mk_point(0, 10, 0)));
} @End(unit-tests)
```

```
@Add(unit-tests) {
	auto w = default_world();
	assert(is_shadowed(w, mk_point(10, -10, 10)));
} @End(unit-tests)
```

```
@Add(unit-tests) {
	auto w = default_world();
	assert(! is_shadowed(w, mk_point(-20, 20, -20)));
} @End(unit-tests)
```

```
@Add(unit-tests) {
	auto w = default_world();
	assert(! is_shadowed(w, mk_point(-2, 2, -2)));
} @End(unit-tests)
```

```
@Add(unit-tests) {
	Ray r { mk_point(0, 0, -5), mk_vector(0, 0, 1) };
	Sphere s;
	s.transform = translation(0, 0, 1);
	Intersection i { 5, &s };
	auto cmps { prepare_computation(i, r) };
	assert(cmps.over_point.z < -1e-5/2);
	assert(cmps.point.z > cmps.over_point.z);
} @End(unit-tests)
```
