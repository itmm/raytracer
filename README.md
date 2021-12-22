# Ray Tracer Challenge

This is a piece-by-piece development of the Ray Tracer Challenge by Jamis Buck
in C++. It uses my `md-patcher` tool to develop the source code piece by piece.

The start is easy. In the file `raytracer.cpp` there is a `main`-function that
simply runs all unit-tests. Here is the initial content of `raytracer.cpp`:

```c++
static void run_tests() {
	// unit-tests
}

int main(int argc, char **argv) {
	run_tests();
}
```

The source continues in the file
[1_tuples.md](./1_tuples.md).
