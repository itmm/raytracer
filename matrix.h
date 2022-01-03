#line 17 "3_creating-matrices.md"
#pragma once
#line 52

class Matrix {
	public:
#line 200
		friend constexpr bool operator==(const Matrix &a, const Matrix &b);
#line 154
		// 3x3
		constexpr Matrix(
			float m00, float m01, float m02,
			float m10, float m11, float m12,
			float m20, float m21, float m22
		): _v {
			 m00,  m01,  m02, 0.0f,
			 m10,  m11,  m12, 0.0f,
			 m20,  m21,  m22, 0.0f,
			0.0f, 0.0f, 0.0f, 0.0f
		} {}
#line 114
		// 2x2
		constexpr Matrix(
			float m00, float m01,
			float m10, float m11
		): _v {
			 m00,  m01, 0.0f, 0.0f,
			 m10,  m11, 0.0f, 0.0f,
			0.0f, 0.0f, 0.0f, 0.0f,
			0.0f, 0.0f, 0.0f, 0.0f
		} {}
#line 78
		constexpr float operator()(int r, int c) const {
			return _v[r * 4 + c];
		}
		float &operator()(int r, int c) {
			return _v[r * 4 + c];
		}
#line 55
		constexpr Matrix(
			float m00, float m01, float m02, float m03,
			float m10, float m11, float m12, float m13,
			float m20, float m21, float m22, float m23,
			float m30, float m31, float m32, float m33
		): _v {
			m00, m01, m02, m03,
			m10, m11, m12, m13,
			m20, m21, m22, m23,
			m30, m31, m32, m33
		} {}
	private:
		float _v[16];
};
#line 61 "3_multiplying-matrices.md"
inline constexpr float mult_line(const Matrix &a, const Matrix &b, int r, int c) {
	return a(r, 0) * b(0, c) + a(r, 1) * b(1, c) +
		a(r, 2) * b(2, c) + a(r, 3) * b(3, c);
}
#line 39
inline constexpr Matrix operator*(const Matrix &a, const Matrix &b) {
	return {
		mult_line(a, b, 0, 0), mult_line(a, b, 0, 1),
			mult_line(a, b, 0, 2), mult_line(a, b, 0, 3),
		mult_line(a, b, 1, 0), mult_line(a, b, 1, 1),
			mult_line(a, b, 1, 2), mult_line(a, b, 1, 3),
		mult_line(a, b, 2, 0), mult_line(a, b, 2, 1),
			mult_line(a, b, 2, 2), mult_line(a, b, 2, 3),
		mult_line(a, b, 3, 0), mult_line(a, b, 3, 1),
			mult_line(a, b, 3, 2), mult_line(a, b, 3, 3)
	};
}
#line 18 "3_creating-matrices.md"
#include "tuple.h"
#line 108 "3_multiplying-matrices.md"
inline constexpr float mult_line(const Matrix &a, const Tuple &t, int r) {
	return a(r, 0) * t.x + a(r, 1) * t.y + a(r, 2) * t.z + a(r, 3) * t.w;
}
#line 94
inline constexpr Tuple operator*(const Matrix &a, const Tuple &t) {
	return {
		mult_line(a, t, 0), mult_line(a, t, 1),
			mult_line(a, t, 2), mult_line(a, t, 3)
	};
}
#line 205 "3_creating-matrices.md"
inline constexpr bool operator==(const Matrix &a, const Matrix &b) {
	const float *ai = a._v;
	const float *bi = b._v;
	const float *ae = ai + 16;
	for (; ai < ae; ++ai, ++bi) {
		if (! eq(*ai, *bi)) {
			return false;
		}
	}
	return true;
}
#line 249
inline constexpr bool operator!=(const Matrix &a, const Matrix &b) {
	return !(a == b);
}
#line 19

inline void matrix_tests() {
	// matrix-tests
#line 74 "3_multiplying-matrices.md"
	{ // matrix/tuple multiplication
		Matrix a {
			1, 2, 3, 4,
			2, 4, 4, 2,
			8, 6, 4, 1,
			0, 0, 0, 1
		};
		Tuple t { 1, 2, 3, 1 };
		Tuple e { 18, 24, 33, 1 };
		assert(a * t == e);
	}
#line 8
	{ // matrix multiply
		Matrix a {
			1, 2, 3, 4,
			5, 6, 7, 8,
			9, 8, 7, 6,
			5, 4, 3, 2
		};
		Matrix b {
			-2, 1, 2, 3,
			3, 2, 1, -1,
			4, 3, 6, 5,
			1, 2, 7, 8
		};
		Matrix e {
			20, 22, 50, 48,
			44, 54, 114, 108,
			40, 58, 110, 102,
			16, 26, 46, 42
		};
		assert(a * b == e);
	}
#line 224 "3_creating-matrices.md"
	{ // check for inequality
		Matrix a {
			1, 2, 3, 4,
			5, 6, 7, 8,
			9, 8, 7, 6,
			5, 4, 3, 2
		};
		Matrix b {
			2, 3, 4, 5,
			6, 7, 8, 9,
			8, 7, 6, 5,
			4, 3, 2, 1
		};
		assert(a != b);
	}
#line 176
	{ // check for equality
		Matrix a {
			1, 2, 3, 4,
			5, 6, 7, 8,
			9, 8, 7, 6,
			5, 4, 3, 2
		};
		Matrix b {
			1, 2, 3, 4,
			5, 6, 7, 8,
			9, 8, 7, 6,
			5, 4, 3, 2
		};
		assert(a == b);
	}
#line 135
	{ // constructing 3x3 matrix
		Matrix m {
			-3.0f,  5.0f,  0.0f,
			 1.0f, -2.0f, -7.0f,
			 0.0f,  1.0f,  1.0f
		};
		assert_eq(m(0, 0), -3.0f);
		assert_eq(m(1, 1), -2.0f);
		assert_eq(m(2, 2), 1.0f);
	}
#line 95
	{ // constructing 2x2 matrix
		Matrix m {
			-3.0f,  5.0f,
			 1.0f, -2.0f
		};
		assert_eq(m(0, 0), -3.0f);
		assert_eq(m(0, 1), 5.0f);
		assert_eq(m(1, 0), 1.0f);
		assert_eq(m(1, 1), -2.0f);
	}
#line 30
	{ // constructing 4x4 matrix
		Matrix m {
			 1.0f,  2.0f,  3.0f,  4.0f,
			 5.5f,  6.5f,  7.5f,  8.5f,
			 9.0f, 10.0f, 11.0f, 12.0f,
			13.5f, 14.5f, 15.5f, 16.5f
		};
		assert_eq(m(0, 0), 1.0f);
		assert_eq(m(0, 3), 4.0f);
		assert_eq(m(1, 0), 5.5f);
		assert_eq(m(1, 2), 7.5f);
		assert_eq(m(2, 2), 11.0f);
		assert_eq(m(3, 0), 13.5f);
		assert_eq(m(3, 2), 15.5f);
	}
#line 22
}
