# Transforming rays and spheres

Test for ray translation `sphere.h`:

```c++
// ...
#include "matrix.h"
#include "transform.h"
Ray transform(const Ray &r, const Matrix &m);
// ...
	// sphere-tests
	{ // translate ray
		auto o { mk_point(1.0f, 2.0f, 3.0f) };
		auto d { mk_vector(0.0f, 1.0f, 0.0f) };
		Ray r { o, d };
		auto m { translation(3.0f, 4.0f, 5.0f) };
		auto r2 { transform(r, m) };
		auto eo { mk_point(4.0f, 6.0f, 8.0f) };
		assert(r2.origin == eo);
		assert(r2.direction == d);
	}
// ...
```

Test scaling a ray:

```c++
// ...
	// sphere-tests
	{ // scale ray
		auto o { mk_point(1.0f, 2.0f, 3.0f) };
		auto d { mk_vector(0.0f, 1.0f, 0.0f) };
		Ray r { o, d };
		auto m { scaling(2.0f, 3.0f, 4.0f) };
		auto r2 { transform(r, m) };
		auto eo { mk_point(2.0f, 6.0f, 12.0f) };
		auto ed { mk_vector(0.0f, 3.0f, 0.0f) };
		assert(r2.origin == eo);
		assert(r2.direction == ed);
	}
// ...
```

A sphere should have `identity` as its default transform:

```c++
// ...
	// sphere-tests
	{ // spheres default transform
		Sphere s;
		assert(s.transform == identity);
	}
// ...
```

Test sphere's translation:

```c++
// ...
	// sphere-tests
	{ // spheres translation
		Sphere s;
		auto m { translation(2.0f, 3.0f, 4.0f) };
		s.transform = m;
		s.inv_transform = inv(m);
		assert(s.transform == m);
	}
// ...
```

Intersect with scaled sphere:

```c++
// ...
	// sphere-tests
	{ // scaled sphere
		auto o { mk_point(0.0f, 0.0f, -5.0f) };
		auto d { mk_vector(0.0f, 0.0f, 1.0f) };
		Ray r { o, d };
		Sphere s;
		s.transform = scaling(2.0f, 2.0f, 2.0f);
		s.inv_transform = inv(s.transform);
		auto xs { s.intersect(r) };
		assert(xs.size() == 2);
		assert_eq(xs[0].t, 3.0f);
		assert_eq(xs[1].t, 7.0f);
	}
// ...
```

Intersect with translated sphere:

```c++
// ...
	// sphere-tests
	{ // translated sphere
		auto o { mk_point(0.0f, 0.0f, -5.0f) };
		auto d { mk_vector(0.0f, 0.0f, 1.0f) };
		Ray r { o, d };
		Sphere s;
		s.transform = translation(5.0f, 0.0f, 0.0f);
		s.inv_transform = inv(s.transform);
		auto xs { s.intersect(r) };
		assert(xs.size() == 0);
	}
// ...
```

Putting it together in [5_silhouette.md](./5_silhouette.md).
