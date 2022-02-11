#line 19 "2_ppm.md"
#pragma once
#line 61
#include <iostream>

template<typename T>
std::ostream &mk_ppm(std::ostream &o, int w, int h, T t) {
	// write header
#line 77
	o << "P3\n";
	o << w << ' ' << h << '\n';
	o << "255\n";
#line 66
	// write pixels
#line 118
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
#line 67
	return o;
}
#line 45
#include <sstream>

template<typename T>
std::string mk_str_ppm(int w, int h, T t) {
	std::ostringstream out;
	mk_ppm(out, w, h, t);
	return out.str();
}
#line 20
#include "color.h"

#line 174
inline int ppm_val(float v) {
	int res = v * 255 + 0.5;
	if (res > 255) { res = 255; }
	if (res < 0) { res = 0; }
	return res;
}
#line 153
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
#line 138
inline void add_color(std::ostream &o, std::string &l, const Color &c) {
	add_component(o, l, c.red);
	add_component(o, l, c.green);
	add_component(o, l, c.blue);
}
#line 22
inline void ppm_tests() {
	// ppm-tests
#line 188
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
#line 89
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
#line 32
	{ // constructing the ppm header
		auto result { mk_str_ppm(5, 3, [](int x, int y) {
			return Color { 0, 0, 0 };
		})};
		assert(result.find("P3\n5 3\n255\n") == 0);
	}
#line 24
}
