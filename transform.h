#line 17 "4_translation.md"
#pragma once
#include "matrix.h"

#line 23 "4_shearing.md"
constexpr inline Matrix shearing(
	float xy, float xz, float yx, float yz, float zx, float zy
) {
	return {
		1.0f,   xy,   xz, 0.0f,
		  yx, 1.0f,   yz, 0.0f,
		  zx,   zy, 1.0f, 0.0f,
		0.0f, 0.0f, 0.0f, 1.0f
	};
}
#line 115 "4_rotation.md"
constexpr inline Matrix rotate_z(float ang) {
	float c { cosf(ang) };
	float s { sinf(ang) };
	return {
		   c,   -s, 0.0f, 0.0f,
		   s,    c, 0.0f, 0.0f,
		0.0f, 0.0f, 1.0f, 0.0f,
		0.0f, 0.0f, 0.0f, 1.0f
	};
}
#line 78
constexpr inline Matrix rotate_y(float ang) {
	float c { cosf(ang) };
	float s { sinf(ang) };
	return {
		   c, 0.0f,    s, 0.0f,
		0.0f, 1.0f, 0.0f, 0.0f,
		  -s, 0.0f,    c, 0.0f,
		0.0f, 0.0f, 0.0f, 1.0f
	};
}
#line 26
constexpr inline Matrix rotate_x(float ang) {
	float c { cosf(ang) };
	float s { sinf(ang) };
	return {
		1.0f, 0.0f, 0.0f, 0.0f,
		0.0f,    c,   -s, 0.0f,
		0.0f,    s,    c, 0.0f,
		0.0f, 0.0f, 0.0f, 1.0f
	};
}
#line 23 "4_scaling.md"
constexpr inline Matrix scaling(float sx, float sy, float sz) {
	return {
		  sx, 0.0f, 0.0f, 0.0f,
		0.0f,   sy, 0.0f, 0.0f,
		0.0f, 0.0f,   sz, 0.0f,
		0.0f, 0.0f, 0.0f, 1.0f
	};
}
#line 45 "4_translation.md"
constexpr inline Matrix translation(float dx, float dy, float dz) {
	return {
		1.0f, 0.0f, 0.0f,   dx,
		0.0f, 1.0f, 0.0f,   dy,
		0.0f, 0.0f, 1.0f,   dz,
		0.0f, 0.0f, 0.0f, 1.0f
	};
}
#line 20
inline void transform_tests() {
	// transform-tests
#line 31 "4_combining.md"
	{ // chain in reverse order
		auto p { mk_point(1.0f, 0.0f, 1.0f) };
		auto a { rotate_x(M_PI/2.0f) };
		auto b { scaling(5.0f, 5.0f, 5.0f) };
		auto c { translation(10.0f, 5.0f, 7.0f) };
		auto t { c * b * a };
		auto e { mk_point(15.0f, 0.0f, 7.0f) };
		assert(t * p == e);
	}
#line 8
	{ // apply chain
		auto p { mk_point(1.0f, 0.0f, 1.0f) };
		auto a { rotate_x(M_PI/2.0f) };
		auto b { scaling(5.0f, 5.0f, 5.0f) };
		auto c { translation(10.0f, 5.0f, 7.0f) };
		auto p2 { a * p };
		auto e2 { mk_point(1.0f, -1.0f, 0.0f) };
		assert(p2 == e2);
		auto p3 { b * p2 };
		auto e3 { mk_point(5.0f, -5.0f, 0.0f) };
		assert(p3 == e3);
		auto p4 { c * p3 };
		auto e4 { mk_point(15.0f, 0.0f, 7.0f) };
		assert(p4 == e4);
	}
#line 97 "4_shearing.md"
	{ // move z in proportion to y
		auto s { shearing(0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f) };
		auto p { mk_point(2.0f, 3.0f, 4.0f) };
		auto e { mk_point(2.0f, 3.0f, 7.0f) };
		assert(s * p == e);
	}
#line 83
	{ // move z in proportion to x
		auto s { shearing(0.0f, 0.0f, 0.0f, 0.0f, 1.0f, 0.0f) };
		auto p { mk_point(2.0f, 3.0f, 4.0f) };
		auto e { mk_point(2.0f, 3.0f, 6.0f) };
		assert(s * p == e);
	}
#line 69
	{ // move y in proportion to z
		auto s { shearing(0.0f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f) };
		auto p { mk_point(2.0f, 3.0f, 4.0f) };
		auto e { mk_point(2.0f, 7.0f, 4.0f) };
		assert(s * p == e);
	}
#line 55
	{ // move y in proportion to x
		auto s { shearing(0.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.0f) };
		auto p { mk_point(2.0f, 3.0f, 4.0f) };
		auto e { mk_point(2.0f, 5.0f, 4.0f) };
		assert(s * p == e);
	}
#line 41
	{ // move x in proportion to z
		auto s { shearing(0.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.0f) };
		auto p { mk_point(2.0f, 3.0f, 4.0f) };
		auto e { mk_point(6.0f, 3.0f, 4.0f) };
		assert(s * p == e);
	}
#line 8
	{ // move x in proportion to y
		auto s { shearing(1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f) };
		auto p { mk_point(2.0f, 3.0f, 4.0f) };
		auto e { mk_point(5.0f, 3.0f, 4.0f) };
		assert(s * p == e);
	}
#line 97 "4_rotation.md"
	{ // rotate around z-axis
		auto p { mk_point(0.0f, 1.0f, 0.0f) };
		auto hq { rotate_z(M_PI/4.0f) };
		auto fq { rotate_z(M_PI/2.0f) };
		auto he { mk_point(-sqrtf(2.0f)/2.0f, sqrtf(2.0f)/2.0f, 0.0f) };
		auto fe { mk_point(-1.0f, 0.0f, 0.0f) };
		assert(hq * p == he);
		assert(fq * p == fe);
	}
#line 60
	{ // rotate around x-axis
		auto p { mk_point(0.0f, 0.0f, 1.0f) };
		auto hq { rotate_y(M_PI/4.0f) };
		auto fq { rotate_y(M_PI/2.0f) };
		auto he { mk_point(sqrtf(2.0f)/2.0f, 0.0f, sqrtf(2.0f)/2.0f) };
		auto fe { mk_point(1.0f, 0.0f, 0.0f) };
		assert(hq * p == he);
		assert(fq * p == fe);
	}
#line 44
	{ // inverse x-rotation
		auto p { mk_point(0.0f, 1.0f, 0.0f) };
		auto hq { rotate_x(M_PI/4.0f) };
		auto i { inv(hq) };
		auto e { mk_point(0.0f, sqrtf(2.0f)/2.0f, -sqrtf(2.0f)/2.0f) };
		assert(i * p == e);
	}
#line 8
	{ // rotate point around x-axis
		auto p { mk_point(0.0f, 1.0f, 0.0f) };
		auto hq { rotate_x(M_PI/4.0f) };
		auto fq { rotate_x(M_PI/2.0f) };
		auto he { mk_point(0.0f, sqrtf(2.0f)/2.0f, sqrtf(2.0f)/2.0f) };
		auto fe { mk_point(0.0f, 0.0f, 1.0f) };
		assert(hq * p == he);
		assert(fq * p == fe);
	}
#line 70 "4_scaling.md"
	{ // negative scaling
		auto s { scaling(-1, 1, 1) };
		auto p { mk_point(2, 3, 4) };
		auto e { mk_point(-2, 3, 4) };
		assert(s * p == e);
	}
#line 54
	{ // inverse of scaling
		auto s { scaling(2, 3, 4) };
		auto i { inv(s) };
		auto v { mk_vector(-4, 6, 8) };
		auto e { mk_vector(-2, 2, 2) };
		assert(i * v == e);
	}
#line 39
	{ // scale a vector
		auto s { scaling(2, 3, 4) };
		auto v { mk_vector(-4, 6, 8) };
		auto e { mk_vector(-8, 18, 32) };
		assert(s * v == e);
	}
#line 8
	{ // scale a point
		auto s { scaling(2.0f, 3.0f, 4.0f) };
		auto p { mk_point(-4.0f, 6.0f, 8.0f) };
		auto e { mk_point(-8.0f, 18.0f, 32.0f) };
		assert(s * p == e);
	}
#line 77 "4_translation.md"
	{ // translate vector
		auto t { translation(5.0f, -3.0f, 2.0f) };
		auto v { mk_vector(-3.0f, 4.0f, 5.0f) };
		assert(t * v == v);
	}
#line 62
	{ // inverse translation
		auto t { translation(5.0f, -3.0f, 2.0f) };
		auto i { inv(t) };
		auto p { mk_point(-3.0f, 4.0f, 5.0f) };
		auto e { mk_point(-8.0f, 7.0f, 3.0f) };
		assert(i * p == e);
	}
#line 30
	{ // translation
		auto t { translation(5.0f, -3.0f, 2.0f) };
		auto p { mk_point(-3.0f, 4.0f, 5.0f) };
		auto e { mk_point(2.0f, 1.0f, 7.0f) };
		assert(t * p == e);
	}
#line 22
}
