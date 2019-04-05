# Colors

```
@Add(types)
	struct Color {
		float red, green, blue;
	};
@End(types)
```

```
@Add(unit-tests) {
	Color c { -0.5, 0.4, 1.7 };
	assert_eq(c.red, -0.5);
	assert_eq(c.green, 0.4);
	assert_eq(c.blue, 1.7);
} @End(unit-tests)
```

## Adding and Subtracting

```
@Add(functions)
	inline auto operator+(
		const Color &a, const Color &b
	) {
		return Color {
			a.red + b.red,
			a.green + b.green,
			a.blue + b.blue
		};
	}
@End(functions)
```

```
@Add(functions)
	inline bool operator==(
		const Color &a, const Color &b
	) {
		return eq(a.red, b.red) &&
			eq(a.green, b.green) &&
			eq(a.blue, b.blue);
	}
@End(functions)
```

```
@Add(unit-tests) {
	Color c1 { 0.9, 0.6, 0.75 };
	Color c2 { 0.7, 0.1, 0.25 };
	Color e { 1.6, 0.7, 1 };
	assert(c1 + c2 == e);
} @End(unit-tests)
```

```
@Add(functions)
	inline auto operator-(
		const Color &a, const Color &b
	) {
		return Color {
			a.red - b.red,
			a.green - b.green,
			a.blue - b.blue
		};
	}
@End(functions)
```

```
@Add(unit-tests) {
	Color c1 { 0.9, 0.6, 0.75 };
	Color c2 { 0.7, 0.1, 0.25 };
	Color e { 0.2, 0.5, 0.5 };
	assert(c1 - c2 == e);
} @End(unit-tests)
```

```
@Add(functions)
	inline auto operator*(
		const Color &c, float f
	) {
		return Color {
			c.red * f, c.green * f,
			c.blue * f
		};
	}
@End(functions)
```

```
@Add(unit-tests) {
	Color c { 0.2, 0.3, 0.4 };
	Color e { 0.4, 0.6, 0.8 };
	assert(c * 2 == e);
} @End(unit-tests)
```

```
@Add(functions)
	inline auto operator*(
		const Color &a, const Color &b
	) {
		return Color {
			a.red * b.red,
			a.green * b.green,
			a.blue * b.blue
		};
	}
@End(functions)
```

```
@Add(unit-tests) {
	Color c1 { 1, 0.2, 0.4 };
	Color c2 { 0.9, 1, 0.1 };
	Color e { 0.9, 0.2, 0.04 };
	assert(c1 * c2 == e);
} @End(unit-tests)
```

