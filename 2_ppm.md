# Write PPM files

Generate images in the PPM format.

First we must establish the unit-tests in `raytracer.cpp`:

```c++
#include "ppm.h"
// ...
	// unit-tests
	ppm_tests();
// ...
```

As the function `ppm_test` is only invoked once, it can be `inline`d and
goes directly to the header `ppm.h`:

```c++
#pragma once
#include "color.h"

inline void ppm_tests() {
	// ppm-tests
}
```

First a test for the expected header:

```c++
// ...
	// ppm-tests
	{ // constructing the ppm header
		auto result { mk_str_ppm(5, 3, [](int x, int y) {
			return Color { 0, 0, 0 };
		})};
		assert(result.find("P3\n5 3\n255\n") == 0);
	}
// ...
```

There is no function to create a string representation yet:

```c++
#pragma once
#include <sstream>

template<typename T>
std::string mk_str_ppm(int w, int h, T t) {
	std::ostringstream out;
	mk_ppm(out, w, h, t);
	return out.str();
}
// ...
```

The function to create a stream representation is missing:


```c++
#pragma once
#include <iostream>

template<typename T>
std::ostream &mk_ppm(std::ostream &o, int w, int h, T t) {
	// write header
	// write pixels
	return o;
}
// ...
```

But still the header is not written yet:

```c++
// ...
	// write header
	o << "P3\n";
	o << w << ' ' << h << '\n';
	o << "255\n";
// ...
```

Now a test with pixel data:


```c++
// ...
	// ppm-tests
	{ // pixel data
		auto result { mk_str_ppm(5, 3, [](int x, int y) {
			Color res { 0, 0, 0 };
			if (x == 0 && y == 0) {
				res = { 1.5, 0, 0 };
			} else if (x == 2 && y == 1) {
				res = { 0, 0.5, 0 };
			} else if (x == 4 && y == 2) {
				res = { -0.5, 0, 1 };
			}
			return res;
		})};
		assert(result == 
			"P3\n"
			"5 3\n"
			"255\n"
			"255 0 0 0 0 0 0 0 0 0 0 0 0 0 0\n"
			"0 0 0 0 0 0 0 128 0 0 0 0 0 0 0\n"
			"0 0 0 0 0 0 0 0 0 0 0 0 0 0 255\n"
		);
	}
// ...
```

No pixels are written yet:

```c++
// ...
	// write pixels
	for (int y = 0; y < h; ++y) {
		std::string line = {};
		for (int x = 0; x < w; ++x) {
			auto c = t(x, y);
			add_color(o, line, c);
		}
		if (! line.empty()) {
			o << line << '\n';
		}
	}
// ...
```

Add color function is missing:


```c++
// ...
#include "color.h"

inline void add_color(std::ostream &o, std::string &l, const Color &c) {
	add_component(o, l, c.red);
	add_component(o, l, c.green);
	add_component(o, l, c.blue);
}
// ...
```

Add component function is missing:


```c++
// ...
#include "color.h"

inline void add_component(std::ostream &o, std::string &l, float c) {
	std::string s { std::to_string(ppm_val(c)) };
	if (s.size() + l.size() < 70) {
		if (! l.empty()) {
			l += ' ';
		}
		l += s;
	} else {
		o << l << '\n';
		l = s;
	}
}
// ...
```

No Ppm value function:

```c++
// ...
#include "color.h"

inline int ppm_val(float v) {
	int res = v * 255 + 0.5;
	if (res > 255) { res = 255; }
	if (res < 0) { res = 0; }
	return res;
}
// ...
```

Splitting long lines

```c++
// ...
	// ppm-tests
	{ // splitting long lines
		auto result { mk_str_ppm(10, 2, [](int x, int y) {
			return Color { 1, 0.8, 0.6 };
		})};
		assert(result == 
			"P3\n"
			"10 2\n"
			"255\n"
			"255 204 153 255 204 153 255 204 153 255 204 153 255 204 153 255 204\n"
			"153 255 204 153 255 204 153 255 204 153 255 204 153\n"
			"255 204 153 255 204 153 255 204 153 255 204 153 255 204 153 255 204\n"
			"153 255 204 153 255 204 153 255 204 153 255 204 153\n"
		);
	}
// ...
```

The tour continues in
[3_creating-matrices.md](./3_creating-matrices.md)

