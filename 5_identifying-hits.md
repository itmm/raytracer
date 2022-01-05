# Identifying Hits

Test for two hits in`sphere.h`:

```c++
// ...
	// sphere-tests
	{ // two positive intersections
		Sphere s;
		Intersection i1 { 1.0f, &s };
		Intersection i2 { 2.0f, &s };
		Intersections xs { i2, i1 };
		auto i { hit(xs) };
		assert(*i == i1);
	}
// ...
```

Define `hit` function:

```c++
// ...
class Intersections: public std::vector<Intersection> {
	// ...
};
inline auto hit(Intersections &xs) {
	for (auto i = xs.begin(); i != xs.end(); ++i) {
		if (i->t >= 0.0f) { return i; }
	}
	return xs.end();
}
// ...
```

Define equality for `Intersection`:

```c++
// ...
struct Intersection {
	// ...
};
inline constexpr bool operator==(const Intersection &a, const Intersection &b) {
	return a.object == b.object && eq(a.t, b.t);
}
// ...
```

Test with one negative intersection:

```c++
// ...
	// sphere-tests
	{ // one negative intersection
		Sphere s;
		Intersection i1 { -1.0f, &s };
		Intersection i2 { 1.0f, &s };
		Intersections xs { i2, i1 };
		auto i { hit(xs) };
		assert(*i == i2);
	}
// ...
```

Test with only negative intersections:

```c++
// ...
	// sphere-tests
	{ // only negative intersections
		Sphere s;
		Intersection i1 { -2.0f, &s };
		Intersection i2 { -1.0f, &s };
		Intersections xs { i2, i1 };
		auto i { hit(xs) };
		assert(i == xs.end());
	}
// ...
```

Test that the lowest non-negative intersection is chosen:

```c++
// ...
	// sphere-tests
	{ // lowest non-negative
		Sphere s;
		Intersection i1 { 5.0f, &s };
		Intersection i2 { 7.0f, &s };
		Intersection i3 { -3.0f, &s };
		Intersection i4 { 2.0f, &s };
		Intersections xs { i1, i2, i3, i4 };
		auto i { hit(xs) };
		assert(*i == i4);
	}
// ...
```

Next topic is 
[5_transforming-rays-and-spheres.md](./5_transforming-rays-and-spheres.md).
