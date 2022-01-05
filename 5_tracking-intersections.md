# Tracking intersections

Test the values of `Intersections` in `sphere.h`:

```c++
// ...
	// sphere-tests
	{ // intersection values
		Sphere s;
		Intersection i1 { 1.0f, &s };
		Intersection i2 { 2.0f, &s };
		Intersections xs { i1, i2 };
		assert(xs.size() == 2);
		assert_eq(xs[0].t, 1.0f);
		assert_eq(xs[1].t, 2.0f);
	}
// ...
```

Test the objects of `Intersections`:

```c++
// ...
	// sphere-tests
	{ // interaction objects
		auto o { mk_point(0.0f, 0.0f, -5.0f) };
		auto d { mk_vector(0.0f, 0.0f, 1.0f) };
		Ray r { o, d };
		Sphere s;
		auto xs { s.intersect(r) };
		assert(xs.size() == 2);
		assert(xs[0].object == &s);
		assert(xs[1].object == &s);
	}
// ...
```

Continues in [5_identifying-hits.md](./5_identifying-hits.md).

