# Lighting

```
@Add(object attribs)
	virtual Tuple normal_at(
		const Tuple &w
	) = 0;
@End(object attribs)
```

```
@Add(sphere attribs)
	Tuple normal_at(
		const Tuple &w
	) override;
@End(sphere attribs)
```

```
@Add(functions)
	Tuple Sphere::normal_at(
		const Tuple &w
	) {
		auto i { inv_transform };
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
	auto n { s.normal_at(p) };
	auto e { mk_vector(1, 0, 0) };
	assert(n == e);
} @End(unit-tests)
```

```
@Add(unit-tests) {
	Sphere s;
	auto p { mk_point(0, 1, 0) } ;
	auto n { s.normal_at(p) };
	auto e { mk_vector(0, 1, 0) };
	assert(n == e);
} @End(unit-tests)
```

```
@Add(unit-tests) {
	Sphere s;
	auto p { mk_point(0, 0, 1) } ;
	auto n { s.normal_at(p) };
	auto e { mk_vector(0, 0, 1) };
	assert(n == e);
} @End(unit-tests)
```

```
@Add(unit-tests) {
	Sphere s;
	float f { sqrtf(3)/3 };
	auto p { mk_point(f, f, f) } ;
	auto n { s.normal_at(p) };
	auto e { mk_vector(f, f, f) };
	assert(n == e);
} @End(unit-tests)
```

```
@Add(unit-tests) {
	Sphere s;
	float f { sqrtf(3)/3 };
	auto p { mk_point(f, f, f) } ;
	auto n { s.normal_at(p) };
	assert(n == norm(n));
} @End(unit-tests)
```

```
@Add(unit-tests) {
	Sphere s;
	s.transform = translation(0, 1, 0);
	s.inv_transform = inv(s.transform);
	auto n { s.normal_at(mk_point(0, 1.70711, -0.70711)) };
	auto e { mk_vector(0, 0.70711, -0.70711) };
	assert(e == n);
} @End(unit-tests)
```

```
@Add(unit-tests) {
	Sphere s;
	s.transform = scaling(1, 0.5, 1) * rotate_z(M_PI/5);
	s.inv_transform = inv(s.transform);
	float f { sqrtf(2)/2 };
	auto n { s.normal_at(mk_point(0, f, -f)) };
	auto e { mk_vector(0, 0.97014, -0.24254) };
	assert(e == n);
} @End(unit-tests)
```

```
@Add(functions)
	inline Tuple reflect(
		const Tuple &v, const Tuple &n
	) {
		return v - 2 * dot(v, n) * n;
	}
@End(functions)
```

```
@Add(unit-tests) {
	auto v { mk_vector(1, -1, 0) };
	auto n { mk_vector(0, 1, 0) };
	auto e { mk_vector(1, 1, 0) };
	assert(reflect(v, n) == e);
} @End(unit-tests)
```

```
@Add(unit-tests) {
	auto v { mk_vector(0, -1, 0) };
	float f { sqrtf(2)/2 };
	auto n { mk_vector(f, f, 0) };
	auto e { mk_vector(1, 0, 0) };
	assert(reflect(v, n) == e);
} @End(unit-tests)
```

```
@Add(types)
	struct Point_Light {
		Tuple position;
		Color intensity;
		@Put(point light elements);
	};
@End(types)
```

```
@Add(unit-tests) {
	Color i { 1, 1, 1 };
	auto p { mk_point(0, 0, 0) };
	Point_Light l { p, i };
	assert(l.position == p);
	assert(l.intensity == i);
} @End(unit-tests)
```

```
@Add(needed by object)
	struct Material {
		Color color { 1, 1, 1 };
		float ambient { 0.1 };
		float diffuse { 0.9 };
		float specular { 0.9 };
		float shininess { 200 };
	};
@End(needed by object)
```

```
@Add(unit-tests) {
	Material m;
	Color e { 1, 1, 1 };
	assert(m.color == e);
	assert_eq(0.1, m.ambient);
	assert_eq(0.9, m.diffuse);
	assert_eq(0.9, m.specular);
	assert_eq(200, m.shininess);
} @End(unit-tests)
```

```
@Add(object attribs)
	Material material;
@End(object attribs)
```

```
@Add(functions)
	inline bool operator==(
		const Material &a,
		const Material &b
	) {
		return a.color == b.color &&
			eq(a.ambient, b.ambient) &&
			eq(a.diffuse, b.diffuse) &&
			eq(a.specular, b.specular) &&
			eq(a.shininess, b.shininess);
	}
@End(functions)
```

```
@Add(unit-tests) {
	Sphere s;
	Material m;
	assert(s.material == m);
} @End(unit-tests)
```

```
@Add(unit-tests) {
	Sphere s;
	Material m;
	m.ambient = 1;
	s.material = m;
	assert(s.material == m);
} @End(unit-tests)
```

```
@Add(functions)
	std::ostream &operator<<(
		std::ostream &o,
		const Color &c
	) {
		return o << '(' << c.red <<
			"  " << c.green << "  " <<
			c.blue << ')';
	}
@End(functions)
```

```
@Add(functions)
	Color lighting(
		const Material &m,
		const Point_Light &l,
		const Tuple &p,
		const Tuple &e,
		const Tuple &n,
		bool in_shadow = false
	) {
		Color res { 0, 0, 0 };
		@put(lighting);
		return res;
	}
@End(functions)
```

```
@Add(unit-tests) {
	Material m;
	auto pos { mk_point(0, 0, 0) };
	auto eye { mk_vector(0, 0, -1) };
	auto n { mk_vector(0, 0, -1) };
	auto lp { mk_point(0, 0, -10) };
	Color lc { 1, 1, 1 };
	Point_Light l { lp, lc };
	Color e { 1.9, 1.9, 1.9 };
	assert(lighting(m, l, pos, eye, n) == e);
} @End(unit-tests)
```

```
@def(lighting)
	auto ec { m.color * l.intensity };
	res = ec * m.ambient;
	auto lv { norm(l.position - p) };
	auto ldn { dot(lv, n) };
	if (ldn >= 0 && ! in_shadow) {
		res = res + ec * m.diffuse * ldn;
		auto r { reflect(-lv, n) };
		auto rde { dot(r, e) };
		if (rde >= 0) {
			auto f { powf(rde, m.shininess) };
			res = res + l.intensity * m.specular * f;
		}
	}
@end(lighting)
```

```
@Add(unit-tests) {
	Material m;
	auto pos { mk_point(0, 0, 0) };
	float f { sqrtf(2)/2 };
	auto eye { mk_vector(0, f, -f) };
	auto n { mk_vector(0, 0, -1) };
	auto lp { mk_point(0, 0, -10) };
	Color lc { 1, 1, 1 };
	Point_Light l { lp, lc };
	Color e { 1, 1, 1 };
	assert(lighting(m, l, pos, eye, n) == e);
} @End(unit-tests)
```

```
@Add(unit-tests) {
	Material m;
	auto pos { mk_point(0, 0, 0) };
	auto eye { mk_vector(0, 0, -1) };
	auto n { mk_vector(0, 0, -1) };
	auto lp { mk_point(0, 10, -10) };
	Color lc { 1, 1, 1 };
	Point_Light l { lp, lc };
	float f { 0.7364 };
	Color e { f, f, f };
	assert(lighting(m, l, pos, eye, n) == e);
} @End(unit-tests)
```

```
@Add(unit-tests) {
	Material m;
	auto pos { mk_point(0, 0, 0) };
	float f { sqrtf(2)/2 };
	auto eye { mk_vector(0, -f, -f) };
	auto n { mk_vector(0, 0, -1) };
	auto lp { mk_point(0, 10, -10) };
	Color lc { 1, 1, 1 };
	Point_Light l { lp, lc };
	float g { 1.6364 };
	Color e { g, g, g };
	assert(lighting(m, l, pos, eye, n) == e);
} @End(unit-tests)
```

```
@Add(unit-tests) {
	Material m;
	auto pos { mk_point(0, 0, 0) };
	auto eye { mk_vector(0, 0, -1) };
	auto n { mk_vector(0, 0, -1) };
	auto lp { mk_point(0, 0, 10) };
	Color lc { 1, 1, 1 };
	Point_Light l { lp, lc };
	Color e { 0.1, 0.1, 0.1 };
	assert(lighting(m, l, pos, eye, n) == e);
} @End(unit-tests)
```

```
@Add(main)
	#if 0
	auto ray_origin { mk_point(0, 0, -5) };
	float wall_z { 10 };
	float wall_size { 7 };
	int canvas_pixels { 100 };
	float pixel_size { wall_size / canvas_pixels };
	float half { wall_size / 2 };
	Color red { 1, 0, 0 };
	Color black { 0, 0, 0 };
	Sphere shape;
	shape.material.color = { 1, 0.2, 1 };
	Point_Light light {
		mk_point(-10, 10, -10),
		{ 1, 1, 1 }
	};
	std::ofstream o("ball.ppm");
	mk_ppm(o, canvas_pixels, canvas_pixels,
		[&](int x, int y) {
			float world_y { half - pixel_size * y };
			float world_x { -half + pixel_size * x };
			auto pos { mk_point(world_x, world_y, wall_z) };
			Ray r { ray_origin, norm(pos - ray_origin) };
			auto xs { shape.intersect(r) };
			auto i { hit(xs) };
			if (i == xs.end()) { return black; }
			auto hp { r.pos(i->t) };
			auto n { i->object->normal_at(hp) };
			auto e { -r.direction };
			auto c { lighting(i->object->material, light, hp, e, n) };
			return c;
		}
	);
	#endif
@End(main)
```
