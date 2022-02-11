#line 67 "6_phong-reflection-model.md"
#pragma once
#include "color.h"

#line 99
struct Material {
	Color color { 1, 1, 1 };
	float ambient { 0.1 };
	float diffuse { 0.9 };
	float specular { 0.9 };
	float shininess { 200 };
};
#line 144
inline bool operator==(const Material &a, const Material &b) {
	return a.color == b.color &&
		eq(a.ambient, b.ambient) &&
		eq(a.diffuse, b.diffuse) &&
		eq(a.specular, b.specular) &&
		eq(a.shininess, b.shininess);
}
#line 70
inline void material_tests() {
	// material-tests
#line 81
	{ // default material attributes
		Material m;
		Color e { 1, 1, 1 };
		assert(m.color == e);
		assert_eq(0.1, m.ambient);
		assert_eq(0.9, m.diffuse);
		assert_eq(0.9, m.specular);
		assert_eq(200, m.shininess);
	}
#line 72
}
