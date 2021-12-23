#line 17 "2_representing-colors.md"
#pragma once
#line 44

struct Color {
	float red, green, blue;
};
#line 18
#include "tuple.h"

inline void color_tests() {
	// color-tests
#line 30
	{ // test specific color
		Color c { -0.5, 0.4, 1.7 };
		assert_eq(c.red, -0.5);
		assert_eq(c.green, 0.4);
		assert_eq(c.blue, 1.7);
	}
#line 22
}
