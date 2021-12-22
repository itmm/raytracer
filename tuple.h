#line 39
#line 39
#line 39
#line 39
#line 39
#line 39
#line 39
#line 39
#line 39
#line 39
#line 39
#line 39
#line 39
#line 39
#line 39
#line 39
#line 39
#line 39
#line 39
#line 39
#line 39
#line 39
#line 39
#line 39
#line 39
#line 39
#line 39
#pragma once
#line 92
	
#include <cmath>
constexpr bool eq(float a, float b) {
	return std::fabs(a - b) < 1e-5;
}
#line 40

#line 70
struct Tuple {
	float x, y, z, w;
	// methods
#line 105
#line 116
	constexpr bool is_vector() const {
		return eq(w, 0);
	}
#line 105
	constexpr bool is_point() const {
		return eq(w, 1);
	}
#line 49
};
// functions
#line 41
#line 83
#line 162
#line 173
#line 199
#line 230
#line 256
#line 317
#line 326
#line 326
constexpr auto operator*(float f, const Tuple &t) {
	return Tuple {
		f * t.x, f * t.y,
		f * t.z, f * t.w
	};
}
#line 317
#line 378
constexpr auto operator/(const Tuple &t, float f) {
	return (1/f) * t;
}
#line 317
constexpr auto operator-(const Tuple &t) {
	return -1 * t;
}
#line 256
constexpr auto operator-(const Tuple &a, const Tuple &b) {
	return Tuple {
		a.x - b.x, a.y - b.y,
		a.z - b.z, a.w - b.w
	};
}
#line 230
constexpr auto operator+(const Tuple &a, const Tuple &b) {
	return Tuple {
		a.x + b.x, a.y + b.y,
		a.z + b.z, a.w + b.w
	};
}
#line 199
inline constexpr auto mk_vector(float x, float y, float z) {
	return Tuple { x, y, z, 0 };
}
#line 173
constexpr bool operator==(const Tuple &a, const Tuple &b) {
	return eq(a.x, b.x) && eq(a.y, b.y) &&
		eq(a.z, b.z) && eq(a.w, b.w);
}
#line 162
constexpr auto mk_point(float x, float y, float z) {
	return Tuple { x, y, z, 1 };
}
#line 83
#include <cassert>
#define assert_eq(a, b) assert(eq((a), (b)))
#line 41
inline void tuple_tests() {
	// tuple-tests
#line 52
#line 128
#line 148
#line 186
#line 218
#line 244
#line 268
#line 280
#line 294
#line 306
#line 341
#line 352
#line 363
	{ // dividing at tuple by a scalar
		Tuple a { 1, -2, 3, -4 };
		Tuple e { 0.5, -1, 1.5, -2 };
		assert(a/2 == e);
	}
#line 352
	{ // multiplying a tuple by a fraction
		Tuple a { 1, -2, 3, -4 };
		Tuple e { 0.5, -1, 1.5, -2 };
		assert(0.5 * a == e);
	}
#line 341
	{ // multiplying a tuple by a scalar
		Tuple a { 1, -2, 3, -4 };
		Tuple e { 3.5, -7, 10.5, -14 };
		assert(3.5 * a == e);
	}
#line 306
	{ // negating a tuple
		Tuple a { 1, -2, 3, -4 };
		Tuple e { -1, 2, -3, 4 };
		assert(-a == e);
	}
#line 294
	{ // subtracting a vector from zero vector
		auto zero { mk_vector(0, 0, 0) };
		auto v { mk_vector(1, -2, 3) };
		auto e { mk_vector(-1, 2, -3) };
		assert(zero - v == e);
	}
#line 280
	{ // subtracting two vectors
		auto v1 { mk_vector(3, 2, 1) };
		auto v2 { mk_vector(5, 6, 7) };
		auto e { mk_vector(-2, -4, -6) };
		assert(v1 - v2 == e);
	}
#line 268
	{ // subtracting a vector from a point
		auto p { mk_point(3, 2, 1) };
		auto v { mk_vector(5, 6, 7) };
		auto e { mk_point(-2, -4, -6) };
		assert(p - v == e);
	}
#line 244
	{ // subtracting two points
		auto p1 { mk_point(3, 2, 1) };
		auto p2 { mk_point(5, 6, 7) };
		auto e { mk_vector(-2, -4, -6) };
		assert(p1 - p2 == e);
	}
#line 218
	{ // adding two tuples
		auto p { mk_point(3, -2, 5) };
		auto v { mk_vector(-2, 3, 1) };
		Tuple e { 1, 1, 6, 1 };
		assert(p + v == e);
	}
#line 186
	{ // make vector
		auto v { mk_vector(4, -4, 3) };
		Tuple e { 4, -4, 3, 0 };
		assert(v == e);
	}
#line 148
	{ // make point
		auto p { mk_point(4, -4, 3) };
		Tuple e { 4, -4, 3, 1 };
		assert(p == e);
	}
#line 128
	{ // a tuple with w == 0 is a vector
		Tuple a { 4.3, -4.2, 3.1, 0 };
		assert_eq(a.x, 4.3);
		assert_eq(a.y, -4.2);
		assert_eq(a.z, 3.1);
		assert(a.w == 0);
		assert(! a.is_point());
		assert(a.is_vector());
	}
#line 52
	{ // a tuple with w == 1 is a point
		Tuple a { 4.3, -4.2, 3.1, 1 };
		assert_eq(a.x, 4.3);
		assert_eq(a.y, -4.2);
		assert_eq(a.z, 3.1);
		assert(a.w == 1);
		assert(a.is_point());
		assert(! a.is_vector());
	}
#line 43
}
