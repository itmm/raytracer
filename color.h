#line 17 "2_representing-colors.md"
#pragma once
#line 44

struct Color {
	float red, green, blue;
};
#line 137 "2_color-operations.md"
inline auto operator*(const Color &a, const Color &b) {
	return Color {
		a.red * b.red,
		a.green * b.green,
		a.blue * b.blue
	};
}
#line 105
inline auto operator*(const Color &c, float f) {
	return Color {
		c.red * f, c.green * f,
		c.blue * f
	};
}
#line 73
inline auto operator-(const Color &a, const Color &b) {
	return Color {
		a.red - b.red,
		a.green - b.green,
		a.blue - b.blue
	};
}
#line 27
inline auto operator+(const Color &a, const Color &b) {
	return Color {
		a.red + b.red,
		a.green + b.green,
		a.blue + b.blue
	};
}
#line 18 "2_representing-colors.md"
#include "tuple.h"
#line 42 "2_color-operations.md"
inline bool operator==(const Color &a, const Color &b) {
	return eq(a.red, b.red) &&
		eq(a.green, b.green) &&
		eq(a.blue, b.blue);
}
#line 19 "2_representing-colors.md"

inline void color_tests() {
	// color-tests
#line 121 "2_color-operations.md"
	{ // hadamard product
		Color c1 { 1.0f, 0.2f, 0.4f };
		Color c2 { 0.9f, 1.0f, 0.1f };
		Color e { 0.9f, 0.2f, 0.04f };
		assert(c1 * c2 == e);
	}
#line 90
	{ // scalar multiplication
		Color c { 0.2f, 0.3f, 0.4f };
		Color e { 0.4f, 0.6f, 0.8f };
		assert(c * 2.0f == e);
	}
#line 57
	{ // subtract two colors
		Color c1 { 0.9f, 0.6f, 0.75f };
		Color c2 { 0.7f, 0.1f, 0.25f };
		Color e { 0.2f, 0.5f, 0.5f };
		assert(c1 - c2 == e);
	}
#line 11
	{ // add two colors
		Color c1 { 0.9f, 0.6f, 0.75f };
		Color c2 { 0.7f, 0.1f, 0.25f };
		Color e { 1.6f, 0.7f, 1.0f };
		assert(c1 + c2 == e);
	}
#line 30 "2_representing-colors.md"
	{ // test specific color
		Color c { -0.5f, 0.4f, 1.7f };
		assert_eq(c.red, -0.5f);
		assert_eq(c.green, 0.4f);
		assert_eq(c.blue, 1.7f);
	}
#line 22
}
