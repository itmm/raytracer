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

```
@Add(types)
	struct Camera {
		int hsize;
		int vsize;
		float field_of_view;
		Matrix transform = identity;
		float half_width;
		float half_height;
		float pixel_size;

		Camera(int hs, int vs, float fov):
			hsize(hs), vsize(vs), field_of_view(fov)
		{
			float half_view = tan(fov/2);
			float aspect = ((float) hs)/vs;
			if (aspect >= 1) {
				half_width = half_view;
				half_height = half_view/aspect;
			} else {
				half_width = half_view * aspect;
				half_height = half_view;
			}
			pixel_size = half_width * 2 / hs;
		}
	};
@End(types)
```

```
@Add(unit-tests) {
	Camera c { 160, 120, M_PI/2 };
	assert(c.hsize == 160);
	assert(c.vsize == 120);
	assert_eq(c.field_of_view, M_PI/2);
	assert(c.transform == identity);
} @End(unit-tests)
```

```
@Add(unit-tests) {
	Camera c { 200, 125, M_PI/2 };
	assert_eq(c.pixel_size, 0.01);
} @End(unit-tests)
```

```
@Add(unit-tests) {
	Camera c { 125, 200, M_PI/2 };
	assert_eq(c.pixel_size, 0.01);
} @End(unit-tests)
```

```
@Add(functions)
	Ray ray_for_pixel(
		const Camera &c, int px, int py
	) {
		float xo = (px + 0.5) * c.pixel_size;
		float yo = (py + 0.5) * c.pixel_size;
		float wx = c.half_width - xo;
		float wy = c.half_height - yo;
		auto i { inv(c.transform) };
		auto p { i * mk_point(wx, wy, -1) };
		auto o { i * mk_point(0, 0, 0) };
		auto d { norm(p - o) };
		return Ray { o, d };
	}
@End(functions)
```

```
@Add(unit-tests) {
	Camera c { 201, 101, M_PI/2 };
	auto r { ray_for_pixel(c, 100, 50) };
	assert(r.origin == mk_point(0, 0, 0));
	assert(r.direction == mk_vector(0, 0, -1));
} @End(unit-tests)
```

```
@Add(unit-tests) {
	Camera c { 201, 101, M_PI/2 };
	auto r { ray_for_pixel(c, 0, 0) };
	assert(r.origin == mk_point(0, 0, 0));
	assert(r.direction == mk_vector(0.66519, 0.33259, -0.66851));
} @End(unit-tests)
```

```
@Add(unit-tests) {
	Camera c { 201, 101, M_PI/2 };
	c.transform = rotate_y(M_PI/4) * translation(0, -2, 5);
	auto r { ray_for_pixel(c, 100, 50) };
	assert(r.origin == mk_point(0, 2, -5));
	float f { sqrtf(2)/2 };
	assert(r.direction == mk_vector(f, 0, -f));
} @End(unit-tests)
```

```
@Add(functions)
	void render(std::ostream &o, const Camera &c, const World &w) {
		mk_ppm(o, c.hsize, c.vsize,
			[&](int x, int y) {
				auto r { ray_for_pixel(c, x, y) };
				return color_at(w, r);
			}
		);
	}
@End(functions)
```

```
@Add(main)
	#if 0
	World w;

	auto floor { std::make_unique<Sphere>() };
	floor->transform = scaling(10, 0.01, 10);
	floor->material = Material {};
	floor->material.color = { 1, 0.9, 0.9 };
	floor->material.specular = 0;

	auto left_wall { std::make_unique<Sphere>() };
	left_wall->transform = translation(0, 0, 5) *
		rotate_y(-M_PI/4) * rotate_x(M_PI/2) *
		scaling(10, 0.01, 10);
	left_wall->material = floor->material;

	auto right_wall { std::make_unique<Sphere>() };
	right_wall->transform = translation(0, 0, 5) *
		rotate_y(M_PI/4) * rotate_x(M_PI/2) *
		scaling(10, 0.01, 10);
	right_wall->material = floor->material;

	auto middle { std::make_unique<Sphere>() };
	middle->transform = translation(-0.5, 1, 0.5);
	middle->material = {};
	middle->material.color = { 0.1, 1, 0.5 };
	middle->material.diffuse = 0.7;
	middle->material.specular = 0.3;

	auto right { std::make_unique<Sphere>() };
	right->transform = translation(1.5, 0.5, -0.5) * scaling(0.5, 0.5, 0.5);
	right->material = {};
	right->material.color = { 0.5, 1, 0.1 };
	right->material.diffuse = 0.7;
	right->material.specular = 0.3;

	auto left { std::make_unique<Sphere>() };
	left->transform = translation(-1.5, 0.33, -0.775) * scaling(0.33, 0.33, 0.33);
	left->material = {};
	left->material.color = { 1, 0.8, 0.1 };
	left->material.diffuse = 0.7;
	left->material.specular = 0.3;

	w.objects.push_back(std::move(floor));
	w.objects.push_back(std::move(left_wall));
	w.objects.push_back(std::move(right_wall));
	w.objects.push_back(std::move(middle));
	w.objects.push_back(std::move(right));
	w.objects.push_back(std::move(left));

	w.lights.push_back(std::move(std::make_unique<Point_Light>(
		mk_point(-10, 10, -10),
		Color {1, 1, 1}
	)));

	Camera c { 400, 200, M_PI/3 };
	c.transform = view_transform(
		mk_point(0, 1.5, -5),
		mk_point(0, 1, 0),
		mk_vector(0, 1, 0)
	);

	std::ofstream o("balls.ppm");
	render(o, c, w);
	#endif
@End(main)
```
