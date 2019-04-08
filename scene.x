# Making a Scene

```
@Add(includes)
	#include <memory>
@End(includes)
```

```
@Add(types)
	struct World {
		std::vector<std::unique_ptr<Object>> objects;
		std::vector<std::unique_ptr<Point_Light>> lights;
	};
@End(types)
```

```
@Add(unit-tests) {
	World w;
	assert(w.objects.empty());
	assert(w.lights.empty());
} @End(unit-tests)
```

```
@Def(point light elements)
	Point_Light(
		const Tuple &t, const Color &c
	):
		position {t}, 
		intensity {c}
	{}
@End(point light elements)
```

```
@Add(functions)
	World default_world() {
		World w;
		w.lights.push_back(std::make_unique<Point_Light>(
			mk_point(-10, 10, -10),
			Color {1, 1, 1}
		));
		std::unique_ptr<Object> s1 { new Sphere() };
		s1->material.color = { 0.8, 1, 0.6 };
		s1->material.diffuse = 0.7;
		s1->material.specular = 0.2;
		w.objects.push_back(std::move(s1));
		std::unique_ptr<Object> s2 { new Sphere() };
		s2->transform = scaling(0.5, 0.5, 0.5);
		w.objects.push_back(std::move(s2));
		return w;
	}
@End(functions)
```

```
@Add(functions)
	bool operator==(
		const Point_Light &a,
		const Point_Light &b
	) {
		return a.position == b.position &&
			a.intensity == b.intensity;
	}
@End(functions)
```

```
@Add(functions)
	bool operator==(
		const Object &a,
		const Object &b
	) {
		return typeid(a) == typeid(b) &&
			a.material == b.material &&
			a.transform == b.transform;
	}
@End(functions)
```

```
@Add(unit-tests) {
	auto w { default_world() };
	Point_Light le {
		mk_point(-10, 10, -10),
		{ 1, 1, 1 }
	};
	assert(w.lights.size() >= 1);
	assert(*w.lights[0] == le);
	Sphere s1;
	s1.material.color = { 0.8, 1, 0.6 };
	s1.material.diffuse = 0.7;
	s1.material.specular = 0.2;
	assert(w.objects.size() >= 2);
	assert(*w.objects[0] == s1);
	Sphere s2;
	s2.transform = scaling(0.5, 0.5, 0.5);
	assert(*w.objects[1] == s2);
} @End(unit-tests)
```

```
@Add(functions)
	Intersections intersect_world(
		const World &w, const Ray &r
	) {
		Intersections res {};
		for (auto &o : w.objects) {
			auto i { o->intersect(r) };
			res.insert(res.end(), i.begin(), i.end());
		}
		std::sort(res.begin(), res.end());
		return res;
	}
@End(functions)
```

```
@Add(unit-tests) {
	auto w { default_world() };
	auto p { mk_point(0, 0, -5) };
	auto v { mk_vector(0, 0, 1) };
	Ray r { p, v };
	auto xs { intersect_world(w, r) };
	assert(xs.size() == 4);
	assert_eq(xs[0].t, 4);
	assert_eq(xs[1].t, 4.5);
	assert_eq(xs[2].t, 5.5);
	assert_eq(xs[3].t, 6);
} @End(unit-tests)
```

```
@Add(types)
	struct Computation {
		float t;
		Object *object;
		Tuple point;
		Tuple eyev;
		Tuple normalv;
		bool inside;
	};
@End(types)
```

```
@Add(functions)
	Computation prepare_computation(
		const Intersection &i,
		const Ray &r
	) {
		Tuple p { r.pos(i.t) };
		Computation c {
			i.t,
			i.object,
			p,
			-r.direction,
			i.object->normal_at(p)
		};
		c.inside = dot(c.normalv, c.eyev) < 0;
		if (c.inside) {
			c.normalv = -c.normalv;
		}
		return c;
	}
@End(functions)
```

```
@Add(unit-tests) {
	auto p { mk_point(0, 0, -5) };
	auto v { mk_vector(0, 0, 1) };
	Ray r { p, v };
	Sphere s;
	Intersection i { 4, &s };
	auto c { prepare_computation(i, r) };
	assert_eq(c.t, 4);
	assert(c.object == i.object);
	assert(c.point == mk_point(0, 0, -1));
	assert(c.eyev == mk_vector(0, 0, -1));
	assert(c.normalv == mk_vector(0, 0, -1));
} @End(unit-tests)
```

```
@Add(unit-tests) {
	auto p { mk_point(0, 0, -5) };
	auto v { mk_vector(0, 0, 1) };
	Ray r { p, v };
	Sphere s;
	Intersection i { 4, &s };
	auto c { prepare_computation(i, r) };
	assert_eq(c.t, 4);
	assert(! c.inside);
} @End(unit-tests)
```

```
@Add(unit-tests) {
	auto p { mk_point(0, 0, 0) };
	auto v { mk_vector(0, 0, 1) };
	Ray r { p, v };
	Sphere s;
	Intersection i { 1, &s };
	auto c { prepare_computation(i, r) };
	assert(c.point == mk_point(0, 0, 1));
	assert(c.eyev == mk_vector(0, 0, -1));
	assert(c.inside);
	assert(c.normalv == mk_vector(0, 0, -1));
} @End(unit-tests)
```

```
@Add(unit-tests) {
	auto w { default_world() };
	Ray r { mk_point(0, 0, -5), mk_vector(0, 0, 1) };
	auto &s { *w.objects[0] };
	Intersection i { 4, &s };
	auto cmp { prepare_computation(i, r) };
	auto c { shade_hit(w, cmp) };
	Color e { 0.38066, 0.47583, 0.2855 };
	assert(c == e);
} @End(unit-tests)
```

```
@Add(functions)
	inline Color &operator+=(
		Color &d, const Color &s
	) {
		d.red += s.red;
		d.green += s.green;
		d.blue += s.blue;
		return d;
	}
@End(functions)
```

```
@Add(functions)
	Color shade_hit(
		const World &w,
		const Computation &cmp
	) {
		Color res { 0, 0, 0};
		for (auto &l: w.lights) {
			res += lighting(
				cmp.object->material,
				*l,
				cmp.point, cmp.eyev,
				cmp.normalv
			);
		}
		return res;
	}
@End(functions)
```

```
@Add(unit-tests) {
	auto w { default_world() };
	w.lights[0] = std::make_unique<Point_Light>(
		mk_point(0, 0.25, 0), Color { 1, 1, 1 }
	);

	Ray r { mk_point(0, 0, 0), mk_vector(0, 0, 1) };
	auto &s { *w.objects[1] };
	Intersection i { 0.5, &s };
	auto cmp { prepare_computation(i, r) };
	auto c { shade_hit(w, cmp) };
	Color e { 0.90498, 0.90498, 0.90498 };
	assert(c == e);
} @End(unit-tests)
```

```
@Add(functions)
	Color color_at(
		const World &w,
		const Ray &r
	) {
		auto xs { intersect_world(w, r) };
		auto i { hit(xs) };
		if (i == xs.end()) {
			return { 0, 0, 0 };
		}
		auto pc { prepare_computation(*i, r) };
		return shade_hit(w, pc);
	}
@End(functions)
```

```
@Add(unit-tests) {
	auto w { default_world() };
	Ray r { mk_point(0, 0, -5), mk_vector(0, 1, 0) };
	auto c { color_at(w, r) };
	Color e { 0, 0, 0 };
	assert(c == e);
} @End(unit-tests)
```

```
@Add(unit-tests) {
	auto w { default_world() };
	Ray r { mk_point(0, 0, -5), mk_vector(0, 0, 1) };
	auto c { color_at(w, r) };
	Color e { 0.38066, 0.47583, 0.2855 };
	assert(c == e);
} @End(unit-tests)
```

```
@Add(unit-tests) {
	auto w { default_world() };
	auto &outer { *w.objects[0] };
	outer.material.ambient = 1;
	auto &inner { *w.objects[1] };
	inner.material.ambient = 1;
	Ray r { mk_point(0, 0, 0.75), mk_vector(0, 0, -1) };
	auto c { color_at(w, r) };
	assert(c == inner.material.color);
} @End(unit-tests)
```

```
@Add(functions)
	Matrix view_transform(
		const Tuple &from,
		const Tuple &to,
		const Tuple &up
	) {
		auto forward { norm(to - from) };
		auto upn { norm(up) };
		auto left { cross(forward, upn) };
		auto true_up { cross(left, forward) };
		return Matrix {
			left.x, left.y, left.z, 0,
			true_up.x, true_up.y, true_up.z, 0,
			-forward.x, -forward.y, -forward.z, 0,
			0, 0, 0, 1
		} * translation(-from.x, -from.y, -from.z);
	}
@End(functions)
```

```
@Add(unit-tests) {
	auto from { mk_point(0, 0, 0) };
	auto to { mk_point(0, 0, -1) };
	auto up { mk_vector(0, 1, 0) };
	assert(view_transform(from, to, up) == identity);
} @End(unit-tests)
```

```
@Add(unit-tests) {
	auto from { mk_point(0, 0, 0) };
	auto to { mk_point(0, 0, 1) };
	auto up { mk_vector(0, 1, 0) };
	assert(view_transform(from, to, up) == scaling(-1, 1, -1));
} @End(unit-tests)
```

```
@Add(unit-tests) {
	auto from { mk_point(0, 0, 8) };
	auto to { mk_point(0, 0, 1) };
	auto up { mk_vector(0, 1, 0) };
	assert(view_transform(from, to, up) == translation(0, 0, -8));
} @End(unit-tests)
```

```
@Add(unit-tests) {
	auto from { mk_point(1, 3, 2) };
	auto to { mk_point(4, -2, 8) };
	auto up { mk_vector(1, 1, 0) };
	Matrix e {
		-0.50709, 0.50709, 0.67612, -2.36643,
		0.76772, 0.60609, 0.12122, -2.82843,
		-0.35857, 0.59761, -0.71714, 0.00000,
		0.00000, 0.00000, 0.00000, 1.00000
	};
	assert(view_transform(from, to, up) == e );
} @End(unit-tests)
```

