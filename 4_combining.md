# Combining Transforms

Apply a chain of transforms:

```c++
// ...
	// transform-tests
	{ // apply chain
		auto p { mk_point(1.0f, 0.0f, 1.0f) };
		auto a { rotate_x(M_PI/2.0f) };
		auto b { scaling(5.0f, 5.0f, 5.0f) };
		auto c { translation(10.0f, 5.0f, 7.0f) };
		auto p2 { a * p };
		auto e2 { mk_point(1.0f, -1.0f, 0.0f) };
		assert(p2 == e2);
		auto p3 { b * p2 };
		auto e3 { mk_point(5.0f, -5.0f, 0.0f) };
		assert(p3 == e3);
		auto p4 { c * p3 };
		auto e4 { mk_point(15.0f, 0.0f, 7.0f) };
		assert(p4 == e4);
	}
// ...
```

Apply in reverse order:

```c++
// ...
	// transform-tests
	{ // chain in reverse order
		auto p { mk_point(1.0f, 0.0f, 1.0f) };
		auto a { rotate_x(M_PI/2.0f) };
		auto b { scaling(5.0f, 5.0f, 5.0f) };
		auto c { translation(10.0f, 5.0f, 7.0f) };
		auto t { c * b * a };
		auto e { mk_point(15.0f, 0.0f, 7.0f) };
		assert(t * p == e);
	}
// ...
```

Next section is [5_creating-rays.md](./5_creating-rays.md).
