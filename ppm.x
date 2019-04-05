# Write PPM files

```
@Add(includes)
	#include <iostream>
@End(includes)
```

```
@Add(functions)
	@put(needed by mk ppm)
	template<typename T>
	std::ostream &mk_ppm(
		std::ostream &o,
		int w, int h, T t
	) {
		@put(write header);
		@put(write pixels);
		return o;
	}
@End(functions)
```

```
@def(write header)
	o << "P3\n";
	o << w << ' ' << h << '\n';
	o << "255\n";
@end(write header)
```

```
@def(needed by mk ppm)
	inline int ppm_val(float v) {
		int res = v * 255 + 0.5;
		if (res > 255) { res = 255; }
		if (res < 0) { res = 0; }
		return res;
	}
@end(needed by mk ppm)
```

```
@add(needed by mk ppm)
	inline void add_component(
		std::ostream &o, std::string &l,
		float c
	) {
		std::string s {
			std::to_string(ppm_val(c))
		};
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
@end(needed by mk ppm)
```

```
@add(needed by mk ppm)
	inline void add_color(
		std::ostream &o, std::string &l,
		const Color &c
	) {
		add_component(o, l, c.red);
		add_component(o, l, c.green);
		add_component(o, l, c.blue);
	}
@end(needed by mk ppm)
```

```
@def(write pixels)
	for (int y = 0; y < h; ++y) {
		std::string line = {};
		for (int x = 0; x < w; ++x) {
			auto c = t(x, y, w, h);
			add_color(o, line, c);
		}
		if (! line.empty()) {
			o << line << '\n';
		}
	}
@end(write pixels)
```

```
@Add(includes)
	#include <sstream>
@End(includes)
```

```
@Add(unit-tests) {
	std::ostringstream oss;
	mk_ppm(oss, 5, 3,
		[](int x, int y, int, int) {
			Color res { 0, 0, 0 };
			if (x == 0 && y == 0) {
				res = { 1.5, 0, 0 };
			} else if (x == 2 && y == 1) {
				res = { 0, 0.5, 0 };
			} else if (x == 4 && y == 2) {
				res = { -0.5, 0, 1 };
			}
			return res;
		}
	);
	assert(oss.str() ==
		"P3\n"
		"5 3\n"
		"255\n"
		"255 0 0 0 0 0 0 0 0 0 0 0 0 "
			"0 0\n"
		"0 0 0 0 0 0 0 128 0 0 0 0 0 "
			"0 0\n"
		"0 0 0 0 0 0 0 0 0 0 0 0 0 0 "
			"255\n"
	);
} @End(unit-tests)
```

```
@Add(unit-tests) {
	std::ostringstream oss;
	mk_ppm(oss, 10, 2,
		[](int, int, int, int) {
			return Color { 1, 0.8, 0.6 };
		}
	);
	assert(oss.str() ==
		"P3\n"
		"10 2\n"
		"255\n"
		"255 204 153 255 204 153 255 204 "
			"153 255 204 153 255 204 153 "
			"255 204\n"
		"153 255 204 153 255 204 153 255 "
			"204 153 255 204 153\n"
		"255 204 153 255 204 153 255 204 "
			"153 255 204 153 255 204 153 "
			"255 204\n"
		"153 255 204 153 255 204 153 255 "
			"204 153 255 204 153\n"
	);
} @End(unit-tests)
```
