#line 30
#line 30
#line 51
#line 60
#line 66
#line 66
#line 66
#line 66
#line 66
#line 66
#line 66
#line 66
#line 66
#line 66
#line 66
#line 66
#line 66
#line 66
#line 66
#line 66
#line 66
#line 66
#line 66
#line 66
#line 66
#line 66
#line 66
#include <cmath>
constexpr bool eq(float a, float b) {
	return std::fabs(a - b) < 1e-5;
}
#line 60
#include <cassert>
#define assert_eq(a, b) assert(eq((a), (b)))
#line 51
struct Tuple {
	float x, y, z, w;
	// methods
#line 76
#line 85
	constexpr bool is_vector() const {
		return w == 0;
	}
#line 76
	constexpr bool is_point() const {
		return eq(w, 1);
	}
#line 75
};
// functions
#line 30
#line 122
#line 131
#line 152
#line 178
#line 204
#line 265
#line 274
#line 274
constexpr auto operator*(float f, const Tuple &t) {
	return Tuple {
		f * t.x, f * t.y,
		f * t.z, f * t.w
	};
}
#line 265
#line 326
constexpr auto operator/(const Tuple &t, float f) {
	return (1/f) * t;
}
#line 265
constexpr auto operator-(const Tuple &t) {
	return -1 * t;
}
#line 204
constexpr auto operator-(const Tuple &a, const Tuple &b) {
	return Tuple {
		a.x - b.x, a.y - b.y,
		a.z - b.z, a.w - b.w
	};
}
#line 178
constexpr auto operator+(const Tuple &a, const Tuple &b) {
	return Tuple {
		a.x + b.x, a.y + b.y,
		a.z + b.z, a.w + b.w
	};
}
#line 152
inline constexpr auto mk_vector(float x, float y, float z) {
	return Tuple { x, y, z, 0 };
}
#line 131
constexpr bool operator==(const Tuple &a, const Tuple &b) {
	return eq(a.x, b.x) && eq(a.y, b.y) &&
		eq(a.z, b.z) && eq(a.w, b.w);
}
#line 122
constexpr auto mk_point(float x, float y, float z) {
	return Tuple { x, y, z, 1 };
}
#line 30
inline void tuple_tests() {
	// tuple-tests
#line 38
#line 94
#line 111
#line 141
#line 166
#line 192
#line 216
#line 228
#line 242
#line 254
#line 289
#line 300
#line 311
	{ // dividing at tuple by a scalar
		Tuple a { 1, -2, 3, -4 };
		Tuple e { 0.5, -1, 1.5, -2 };
		assert(a/2 == e);
	}
#line 300
	{ // multiplying a tuple by a fraction
		Tuple a { 1, -2, 3, -4 };
		Tuple e { 0.5, -1, 1.5, -2 };
		assert(0.5 * a == e);
	}
#line 289
	{ // multiplying a tuple by a scalar
		Tuple a { 1, -2, 3, -4 };
		Tuple e { 3.5, -7, 10.5, -14 };
		assert(3.5 * a == e);
	}
#line 254
	{ // negating a tuple
		Tuple a { 1, -2, 3, -4 };
		Tuple e { -1, 2, -3, 4 };
		assert(-a == e);
	}
#line 242
	{ // subtracting a vector from zero vector
		auto zero { mk_vector(0, 0, 0) };
		auto v { mk_vector(1, -2, 3) };
		auto e { mk_vector(-1, 2, -3) };
		assert(zero - v == e);
	}
#line 228
	{ // subtracting two vectors
		auto v1 { mk_vector(3, 2, 1) };
		auto v2 { mk_vector(5, 6, 7) };
		auto e { mk_vector(-2, -4, -6) };
		assert(v1 - v2 == e);
	}
#line 216
	{ // subtracting a vector from a point
		auto p { mk_point(3, 2, 1) };
		auto v { mk_vector(5, 6, 7) };
		auto e { mk_point(-2, -4, -6) };
		assert(p - v == e);
	}
#line 192
	{ // subtracting two points
		auto p1 { mk_point(3, 2, 1) };
		auto p2 { mk_point(5, 6, 7) };
		auto e { mk_vector(-2, -4, -6) };
		assert(p1 - p2 == e);
	}
#line 166
	{ // adding two tuples
		auto p { mk_point(3, -2, 5) };
		auto v { mk_vector(-2, 3, 1) };
		Tuple e { 1, 1, 6, 1 };
		assert(p + v == e);
	}
#line 141
	{ // make vector
		auto v { mk_vector(4, -4, 3) };
		Tuple e { 4, -4, 3, 0 };
		assert(v == e);
	}
#line 111
	{ // make point
		auto p { mk_point(4, -4, 3) };
		Tuple e { 4, -4, 3, 1 };
		assert(p == e);
	}
#line 94
	{ // second test
		Tuple a { 4.3, -4.2, 3.1, 0 };
		assert_eq(a.x, 4.3);
		assert_eq(a.y, -4.2);
		assert_eq(a.z, 3.1);
		assert(a.w == 0);
		assert(! a.is_point());
		assert(a.is_vector());
	}
#line 38
	{ // first test
		Tuple a { 4.3, -4.2, 3.1, 1 };
		assert_eq(a.x, 4.3);
		assert_eq(a.y, -4.2);
		assert_eq(a.z, 3.1);
		assert(a.w == 1);
		assert(a.is_point());
		assert(! a.is_vector());
	}
#line 32
}
