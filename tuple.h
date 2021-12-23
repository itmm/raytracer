#line 19 "1_tuples.md"
#pragma once
#line 72
	
#include <cmath>
constexpr bool eq(float a, float b) {
	return std::fabs(a - b) < 1e-5f;
}
#line 20

#line 50
struct Tuple {
	float x, y, z, w;
	// methods
#line 96
	constexpr bool is_vector() const {
		return eq(w, 0.0f);
	}
#line 85
	constexpr bool is_point() const {
		return eq(w, 1.0f);
	}
#line 53
};
// functions
#line 357 "1_operations.md"
constexpr float dot(const Tuple &a, const Tuple &b) {
	return a.x * b.x + a.y * b.y +
		a.z * b.z + a.w * b.w;
}
#line 232
constexpr float abs(const Tuple &t) {
	return sqrtf(
		t.x * t.x + t.y * t.y +
		t.z * t.z + t.w * t.w
	);
}
#line 141
constexpr auto operator*(float f, const Tuple &t) {
	return Tuple {
		f * t.x, f * t.y,
		f * t.z, f * t.w
	};
}
#line 207
constexpr auto operator/(const Tuple &t, float f) {
	return (1.0f/f) * t;
}
#line 298
constexpr Tuple norm(const Tuple &t) {
	float m = abs(t);
	return eq(m, 1.0f) ? t : t/m;
}
#line 129
constexpr auto operator-(const Tuple &t) {
	return -1.0f * t;
}
#line 56
constexpr auto operator-(const Tuple &a, const Tuple &b) {
	return Tuple {
		a.x - b.x, a.y - b.y,
		a.z - b.z, a.w - b.w
	};
}
#line 23
constexpr auto operator+(const Tuple &a, const Tuple &b) {
	return Tuple {
		a.x + b.x, a.y + b.y,
		a.z + b.z, a.w + b.w
	};
}
#line 179 "1_tuples.md"
constexpr auto mk_vector(float x, float y, float z) {
	return Tuple { x, y, z, 0.0f };
}
#line 392 "1_operations.md"
constexpr auto cross(const Tuple &a, const Tuple &b) {
	return mk_vector(
		a.y * b.z - a.z * b.y,
		a.z * b.x - a.x * b.z,
		a.x * b.y - a.y * b.x
	);
}
#line 153 "1_tuples.md"
constexpr bool operator==(const Tuple &a, const Tuple &b) {
	return eq(a.x, b.x) && eq(a.y, b.y) &&
		eq(a.z, b.z) && eq(a.w, b.w);
}
#line 142
constexpr auto mk_point(float x, float y, float z) {
	return Tuple { x, y, z, 1.0f };
}
#line 63
#include <cassert>
#define assert_eq(a, b) assert(eq((a), (b)))
#line 21
inline void tuple_tests() {
	// tuple-tests
#line 373 "1_operations.md"
	{ // test of cross product
		auto a { mk_vector(1.0f, 2.0f, 3.0f) };
		auto b { mk_vector(2.0f, 3.0f, 4.0f) };
		auto e { mk_vector(-1.0f, 2.0f, -1.0f) };
		assert(cross(a, b) == e);
		assert(cross(b, a) == -e);
	}
#line 344
	{ // test of dot product
		auto a { mk_vector(1.0f, 2.0f, 3.0f) };
		auto b { mk_vector(2.0f, 3.0f, 4.0f) };
		assert_eq(20.0f, dot(a, b));
	}
#line 329
	{ // length of norm vector
		auto v { mk_vector(1.0f, 2.0f, 3.0f) };
		assert_eq(1.0f, abs(norm(v)));
	}
#line 313
	{ // normalizing (1, 2, 3)
		auto v { mk_vector(1.0f, 2.0f, 3.0f) };
		auto e { mk_vector(
			0.26726f, 0.53452f, 0.80178f
		) };
		assert(norm(v) == e);
	}
#line 281
	{ // normalize (4, 0, 0)
		auto v { mk_vector(4.0f, 0.0f, 0.0f) };
		auto e { mk_vector(1.0f, 0.0f, 0.0f) };
		assert(norm(v) == e);
	}
#line 262
	{ // check length on non-unit vector
		auto v { mk_vector(1.0f, 2.0f, 3.0f) };
		assert_eq(sqrtf(14.0f), abs(v));
	}
	{ // check length of negated non-unit vector
		auto v { mk_vector(-1.0f, -2.0f, -3.0f) };
		assert_eq(sqrtf(14.0f), abs(v));
	}
#line 246
	{ // checking length of second unit-vector
		auto v { mk_vector(0.0f, 1.0f, 0.0f) };
		assert_eq(1.0f, abs(v));
	}
	{ // checking length of third unit-vector
		auto v { mk_vector(0.0f, 0.0f, 1.0f) };
		assert_eq(1.0f, abs(v));
	}
#line 220
	{ // checking length of first unit-vector
		auto v { mk_vector(1.0f, 0.0f, 0.0f) };
		assert_eq(1.0f, abs(v));
	}
#line 189
	{ // dividing at tuple by a scalar
		Tuple a { 1.0f, -2.0f, 3.0f, -4.0f };
		Tuple e { 0.5f, -1.0f, 1.5f, -2.0f };
		assert(a/2.0f == e);
	}
#line 174
	{ // multiplying a tuple by a fraction
		Tuple a { 1.0f, -2.0f, 3.0f, -4.0f };
		Tuple e { 0.5f, -1.0f, 1.5f, -2.0f };
		assert(0.5f * a == e);
	}
#line 161
	{ // multiplying a tuple by a scalar
		Tuple a { 1.0f, -2.0f, 3.0f, -4.0f };
		Tuple e { 3.5f, -7.0f, 10.5f, -14.0f };
		assert(3.5f * a == e);
	}
#line 116
	{ // negating a tuple
		Tuple a { 1.0f, -2.0f, 3.0f, -4.0f };
		Tuple e { -1.0f, 2.0f, -3.0f, 4.0f };
		assert(-a == e);
	}
#line 102
	{ // subtracting a vector from zero vector
		auto zero { mk_vector(0.0f, 0.0f, 0.0f) };
		auto v { mk_vector(1.0f, -2.0f, 3.0f) };
		auto e { mk_vector(-1.0f, 2.0f, -3.0f) };
		assert(zero - v == e);
	}
#line 86
	{ // subtracting two vectors
		auto v1 { mk_vector(3.0f, 2.0f, 1.0f) };
		auto v2 { mk_vector(5.0f, 6.0f, 7.0f) };
		auto e { mk_vector(-2.0f, -4.0f, -6.0f) };
		assert(v1 - v2 == e);
	}
#line 71
	{ // subtracting a vector from a point
		auto p { mk_point(3.0f, 2.0f, 1.0f) };
		auto v { mk_vector(5.0f, 6.0f, 7.0f) };
		auto e { mk_point(-2.0f, -4.0f, -6.0f) };
		assert(p - v == e);
	}
#line 42
	{ // subtracting two points
		auto p1 { mk_point(3.0f, 2.0f, 1.0f) };
		auto p2 { mk_point(5.0f, 6.0f, 7.0f) };
		auto e { mk_vector(-2.0f, -4.0f, -6.0f) };
		assert(p1 - p2 == e);
	}
#line 10
	{ // adding two tuples
		auto p { mk_point(3.0f, -2.0f, 5.0f) };
		auto v { mk_vector(-2.0f, 3.0f, 1.0f) };
		Tuple e { 1.0f, 1.0f, 6.0f, 1.0f };
		assert(p + v == e);
	}
#line 166 "1_tuples.md"
	{ // make vector
		auto v { mk_vector(4.0f, -4.0f, 3.0f) };
		Tuple e { 4.0f, -4.0f, 3.0f, 0.0f };
		assert(v == e);
	}
#line 128
	{ // make point
		auto p { mk_point(4.0f, -4.0f, 3.0f) };
		Tuple e { 4.0f, -4.0f, 3.0f, 1.0f };
		assert(p == e);
	}
#line 108
	{ // a tuple with w == 0 is a vector
		Tuple a { 4.3f, -4.2f, 3.1f, 0.0f };
		assert_eq(a.x, 4.3f);
		assert_eq(a.y, -4.2f);
		assert_eq(a.z, 3.1f);
		assert_eq(a.w, 0.0f);
		assert(! a.is_point());
		assert(a.is_vector());
	}
#line 32
	{ // a tuple with w == 1 is a point
		Tuple a { 4.3f, -4.2f, 3.1f, 1.0f };
		assert_eq(a.x, 4.3f);
		assert_eq(a.y, -4.2f);
		assert_eq(a.z, 3.1f);
		assert_eq(a.w, 1.0f);
		assert(a.is_point());
		assert(! a.is_vector());
	}
#line 23
}
