# The Transposing matrices

Testing transposing matrices in `matrix.h`:


```c++
// ...
	// matrix-tests
	{ // transpose test
		Matrix a {
			0.0f, 9.0f, 3.0f, 0.0f,
			9.0f, 8.0f, 0.0f, 8.0f,
			1.0f, 8.0f, 5.0f, 3.0f,
			0.0f, 0.0f, 5.0f, 8.0f
		};
		Matrix e {
			0.0f, 9.0f, 1.0f, 0.0f,
			9.0f, 8.0f, 8.0f, 0.0f,
			3.0f, 0.0f, 5.0f, 5.0f,
			0.0f, 8.0f, 3.0f, 8.0f
		};
		assert(trans(a) == e);
	}
// ...
```

Define function:

```c++
// ...
class Matrix {
	// ...
};
inline constexpr Matrix trans(const Matrix &a) {
	return {
		a(0, 0), a(1, 0), a(2, 0), a(3, 0),
		a(0, 1), a(1, 1), a(2, 1), a(3, 1),
		a(0, 2), a(1, 2), a(2, 2), a(3, 2),
		a(0, 3), a(1, 3), a(2, 3), a(3, 3)
	};
}
// ...
```

Check that the identity matrix is its own transpose:

```c++
// ...
	// matrix-tests
	{ // transpose identity matrix
		assert(trans(identity) == identity);
	}
// ...
```

Next steps in
[3_inverting-matrices.md](./3_inverting-matrices.md).
