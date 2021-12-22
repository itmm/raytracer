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
	return std::fabs(a - b) < 1e-5f;
}
#line 40

#line 70
struct Tuple {
	float x, y, z, w;
	// methods
#line 105
#line 116
	constexpr bool is_vector() const {
		return eq(w, 0.0f);
	}
#line 105
	constexpr bool is_point() const {
		return eq(w, 1.0f);
	}
#line 49
};
// functions
#line 41
#line 83
#line 162
#line 173
#line 199
#line 231
#line 264
#line 337
#line 349
#line 349
constexpr auto operator*(float f, const Tuple &t) {
	return Tuple {
		f * t.x, f * t.y,
		f * t.z, f * t.w
	};
}
#line 337
#line 415
constexpr auto operator/(const Tuple &t, float f) {
	return (1.0f/f) * t;
}
#line 337
constexpr auto operator-(const Tuple &t) {
	return -1.0f * t;
}
#line 264
constexpr auto operator-(const Tuple &a, const Tuple &b) {
	return Tuple {
		a.x - b.x, a.y - b.y,
		a.z - b.z, a.w - b.w
	};
}
#line 231
constexpr auto operator+(const Tuple &a, const Tuple &b) {
	return Tuple {
		a.x + b.x, a.y + b.y,
		a.z + b.z, a.w + b.w
	};
}
#line 199
inline constexpr auto mk_vector(float x, float y, float z) {
	return Tuple { x, y, z, 0.0f };
}
#line 173
constexpr bool operator==(const Tuple &a, const Tuple &b) {
	return eq(a.x, b.x) && eq(a.y, b.y) &&
		eq(a.z, b.z) && eq(a.w, b.w);
}
#line 162
constexpr auto mk_point(float x, float y, float z) {
	return Tuple { x, y, z, 1.0f };
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
#line 250
#line 279
#line 294
#line 310
#line 324
#line 369
#line 382
#line 397
	{ // dividing at tuple by a scalar
		Tuple a { 1.0f, -2.0f, 3.0f, -4.0f };
		Tuple e { 0.5f, -1.0f, 1.5f, -2.0f };
		assert(a/2.0f == e);
	}
#line 382
	{ // multiplying a tuple by a fraction
		Tuple a { 1.0f, -2.0f, 3.0f, -4.0f };
		Tuple e { 0.5f, -1.0f, 1.5f, -2.0f };
		assert(0.5f * a == e);
	}
#line 369
	{ // multiplying a tuple by a scalar
		Tuple a { 1.0f, -2.0f, 3.0f, -4.0f };
		Tuple e { 3.5f, -7.0f, 10.5f, -14.0f };
		assert(3.5f * a == e);
	}
#line 324
	{ // negating a tuple
		Tuple a { 1.0f, -2.0f, 3.0f, -4.0f };
		Tuple e { -1.0f, 2.0f, -3.0f, 4.0f };
		assert(-a == e);
	}
#line 310
	{ // subtracting a vector from zero vector
		auto zero { mk_vector(0.0f, 0.0f, 0.0f) };
		auto v { mk_vector(1.0f, -2.0f, 3.0f) };
		auto e { mk_vector(-1.0f, 2.0f, -3.0f) };
		assert(zero - v == e);
	}
#line 294
	{ // subtracting two vectors
		auto v1 { mk_vector(3.0f, 2.0f, 1.0f) };
		auto v2 { mk_vector(5.0f, 6.0f, 7.0f) };
		auto e { mk_vector(-2.0f, -4.0f, -6.0f) };
		assert(v1 - v2 == e);
	}
#line 279
	{ // subtracting a vector from a point
		auto p { mk_point(3.0f, 2.0f, 1.0f) };
		auto v { mk_vector(5.0f, 6.0f, 7.0f) };
		auto e { mk_point(-2.0f, -4.0f, -6.0f) };
		assert(p - v == e);
	}
#line 250
	{ // subtracting two points
		auto p1 { mk_point(3.0f, 2.0f, 1.0f) };
		auto p2 { mk_point(5.0f, 6.0f, 7.0f) };
		auto e { mk_vector(-2.0f, -4.0f, -6.0f) };
		assert(p1 - p2 == e);
	}
#line 218
	{ // adding two tuples
		auto p { mk_point(3.0f, -2.0f, 5.0f) };
		auto v { mk_vector(-2.0f, 3.0f, 1.0f) };
		Tuple e { 1.0f, 1.0f, 6.0f, 1.0f };
		assert(p + v == e);
	}
#line 186
	{ // make vector
		auto v { mk_vector(4.0f, -4.0f, 3.0f) };
		Tuple e { 4.0f, -4.0f, 3.0f, 0.0f };
		assert(v == e);
	}
#line 148
	{ // make point
		auto p { mk_point(4.0f, -4.0f, 3.0f) };
		Tuple e { 4.0f, -4.0f, 3.0f, 1.0f };
		assert(p == e);
	}
#line 128
	{ // a tuple with w == 0 is a vector
		Tuple a { 4.3f, -4.2f, 3.1f, 0.0f };
		assert_eq(a.x, 4.3f);
		assert_eq(a.y, -4.2f);
		assert_eq(a.z, 3.1f);
		assert_eq(a.w, 0.0f);
		assert(! a.is_point());
		assert(a.is_vector());
	}
#line 52
	{ // a tuple with w == 1 is a point
		Tuple a { 4.3f, -4.2f, 3.1f, 1.0f };
		assert_eq(a.x, 4.3f);
		assert_eq(a.y, -4.2f);
		assert_eq(a.z, 3.1f);
		assert_eq(a.w, 1.0f);
		assert(a.is_point());
		assert(! a.is_vector());
	}
#line 43
}
