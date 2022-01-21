# Reflecting vectors

Test a reflection funciton in `tuple.h`:

```c++
// ...
	// tuple-tests
	{ // reflecting at 45 degrees
		auto v { mk_vector(1, -1, 0) };
		auto n { mk_vector(0, 1, 0) };
		auto e { mk_vector(1, 1, 0) };
		assert(reflect(v, n) == e);
	}
// ...
```

And add this function:

```c++
// ...
constexpr auto operator-(const Tuple &a, const Tuple &b) {
	// ...
}
inline Tuple reflect(const Tuple &v, const Tuple &n) {
	return v - 2 * dot(v, n) * n;
}
// ...
```

Test reflecting off a slanted surface:

```c++
// ...
	// tuple-tests
	{ // reflecting off slanted surface
		auto v { mk_vector(0, -1, 0) };
		float f { sqrtf(2)/2 };
		auto n { mk_vector(f, f, 0) };
		auto e { mk_vector(1, 0, 0) };
		assert(reflect(v, n) == e);
	}
// ...
```

Continuous in [6_phong-reflection-model.md](./6_phong-reflection-model.md).
