# The Identity Matrix

Testing multiplication with the identity matrix in `matrix.h`:

```c++
// ...
	// matrix-tests
	{ // matrix multiply with identity
		Matrix a {
			0.0f, 1.0f,  2.0f,  4.0f,
			1.0f, 2.0f,  4.0f,  8.0f,
			2.0f, 4.0f,  8.0f, 16.0f,
			4.0f, 8.0f, 16.0f, 32.0f
		};
		assert(a * identity == a);
	}
// ...
```

Define identity matrix:

```c++
// ...
class Matrix {
	// ...
};
constexpr Matrix identity {
	1.0f, 0.0f, 0.0f, 0.0f,
	0.0f, 1.0f, 0.0f, 0.0f,
	0.0f, 0.0f, 1.0f, 0.0f,
	0.0f, 0.0f, 0.0f, 1.0f
};
// ...
```

Test multiplication with tuple:

```c++
// ...
	// matrix-tests
	{ // tuple multiply with identity
		Tuple t {
			1.0f, 2.0f, 3.0f, 4.0f
		};
		assert(identity * t == t);
	}
// ...
```

Continue in
[3_transposing-matrices.md](./3_transposing-matrices.md).
