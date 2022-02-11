#line 17 "3_creating-matrices.md"
#pragma once
#line 52

class Matrix {
	public:
#line 380 "3_inverting-matrices.md"
		Matrix() = default;
#line 200 "3_creating-matrices.md"
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
#line 59 "3_inverting-matrices.md"
inline Matrix sub(Matrix a, int r, int c) {
	while (r < 3) {
		int i = r + 1;
		for (int k = 3; k >= 0; --k) {
			a(r, k) = a(i, k);
		}
		r = i;
	}
	while (c < 3) {
		int i = c + 1;
		for (int k = 3; k >= 0; --k) {
			a(k, c) = a(k, i);
		}
		c = i;
	}
	for (int i = 3; i >= 0; --i) {
		a(i, 3) = 0.0f;
		a(3, i) = 0.0f;
	}
	return a;
}
#line 26
inline constexpr float det2(const Matrix &a) {
	return a(0, 0) * a(1, 1) - a(0, 1) * a(1, 0);
}
#line 129
inline float minor3(const Matrix &a, int r, int c) {
	return det2(sub(a, r, c));
}
#line 161
inline float cofactor3(const Matrix &a, int r, int c) {
	float m = minor3(a, r, c);
	return ((r + c) & 1) ? -m : m;
}
#line 194
inline float det3(const Matrix &a) {
	float cf1 { cofactor3(a, 0, 0) };
	float cf2 { cofactor3(a, 0, 1) };
	float cf3 { cofactor3(a, 0, 2) };
	return a(0, 0) * cf1 + a(0, 1) * cf2 + a(0, 2) * cf3;
}
#line 247
inline float minor4(const Matrix &a, int r, int c) {
	return det3(sub(a, r, c));
}
#line 233
inline float cofactor4(const Matrix &a, int r, int c) {
	float m = minor4(a, r, c);
	return ((r + c) & 1) ? -m : m;
}
#line 260
inline float det4(const Matrix &a) {
	float cf1 { cofactor4(a, 0, 0) };
	float cf2 { cofactor4(a, 0, 1) };
	float cf3 { cofactor4(a, 0, 2) };
	float cf4 { cofactor4(a, 0, 3) };
	return a(0, 0) * cf1 + a(0, 1) * cf2 + a(0, 2) * cf3 + a(0, 3) * cf4;
}
#line 34 "3_transposing-matrices.md"
inline constexpr Matrix trans(const Matrix &a) {
	return {
		a(0, 0), a(1, 0), a(2, 0), a(3, 0),
		a(0, 1), a(1, 1), a(2, 1), a(3, 1),
		a(0, 2), a(1, 2), a(2, 2), a(3, 2),
		a(0, 3), a(1, 3), a(2, 3), a(3, 3)
	};
}
#line 27 "3_identity-matrix.md"
constexpr Matrix identity {
	1.0f, 0.0f, 0.0f, 0.0f,
	0.0f, 1.0f, 0.0f, 0.0f,
	0.0f, 0.0f, 1.0f, 0.0f,
	0.0f, 0.0f, 0.0f, 1.0f
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
#line 295 "3_inverting-matrices.md"
inline bool is_invertible(const Matrix &a) {
	return ! eq(det4(a), 0.0f);
}
#line 356
#include <stdexcept>
inline Matrix inv(const Matrix &a) {
	Matrix res {};
	float d { det4(a) };
	if (eq(d, 0.0f)) {
		throw std::invalid_argument("inv");
	}
	for (int r = 3; r >= 0; --r) {
		for (int c = 3; c >= 0; --c) {
			float cf = cofactor4(a, r, c);
			res(c, r) = cf / d;
		}
	}
	return res;
}
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
#line 437 "3_inverting-matrices.md"
	{ // multiply by inverse
		Matrix a {
			 3.0f, -9.0f,  7.0f,  3.0f,
			 3.0f, -8.0f,  2.0f, -9.0f,
			-4.0f,  4.0f,  4.0f,  1.0f,
			-6.0f,  5.0f, -1.0f,  1.0f
		};
		Matrix b {
			8.0f,  2.0f, 2.0f, 2.0f,
			3.0f, -1.0f, 7.0f, 0.0f,
			7.0f,  0.0f, 5.0f, 4.0f,
			6.0f, -2.0f, 0.0f, 5.0f
		};
		Matrix c { a * b };
		assert(c * inv(b) == a);
	}
#line 414
	{ // invert 3rd matrix
		Matrix a {
			 9.0f,  3.0f,  0.0f,  9.0f,
			-5.0f, -2.0f, -6.0f, -3.0f,
			-4.0f,  9.0f,  6.0f,  4.0f,
			-7.0f,  6.0f,  6.0f,  2.0f
		};
		Matrix e {
			-0.04074f, -0.07778f,  0.14444f, -0.22222f,
			-0.07778f,  0.03333f,  0.36667f, -0.33333f,
			-0.02901f, -0.14630f, -0.10926f,  0.12963f,
			 0.17778f,  0.06667f, -0.26667f,  0.33333f
		};
		assert(inv(a) == e);
	}
#line 391
	{ // invert 2nd matrix
		Matrix a {
			 8.0f, -5.0f,  9.0f,  2.0f,
			 7.0f,  5.0f,  6.0f,  1.0f,
			-6.0f,  0.0f,  9.0f,  6.0f,
			-3.0f,  0.0f, -9.0f, -4.0f
		};
		Matrix e {
			-0.15385f, -0.15385f, -0.28205f, -0.53846f,
			-0.07692f,  0.12308f,  0.02564f,  0.03077f,
			 0.35897f,  0.35897f,  0.43590f,  0.92308f,
			-0.69231f, -0.69231f, -0.76923f, -1.92308f
		};
		assert(inv(a) == e);
	}
#line 325
	{ // invert matrix
		Matrix a {
			-5.0f,  2.0f,  6.0f, -8.0f,
			 1.0f, -5.0f,  1.0f,  8.0f,
			 7.0f,  7.0f, -6.0f, -7.0f,
			 1.0f, -3.0f,  7.0f,  4.0f
		};
		assert_eq(det4(a), 532.0f);
		assert_eq(cofactor4(a, 2, 3), -160.0f);
		assert_eq(cofactor4(a, 3, 2), 105.0f);
		auto b { inv(a) };
		assert_eq(b(3, 2), -160.0f/532.0f);
		assert_eq(b(2, 3), 105.0f/532.0f);
		Matrix e {
			 0.21805f,  0.45113f,  0.24060f, -0.04511f,
			-0.80827f, -1.45677f, -0.44361f,  0.52068f,
			-0.07895f, -0.22368f, -0.05263f,  0.19737f,
			-0.52256f, -0.81391f, -0.30075f,  0.30639f
		};
		assert(b == e);
	}
#line 307
	{ // singular matrix is not invertible
		Matrix a {
			-4.0f,  2.0f, -2.0f,  3.0f,
			 9.0f,  6.0f,  2.0f,  6.0f,
			 0.0f, -5.0f,  1.0f, -5.0f,
			 0.0f,  0.0f,  0.0f,  0.0f
		};
		assert_eq(det4(a), 0.0f);
		assert(! is_invertible(a));
	}
#line 277
	{ // negative determinant is invertible
		Matrix a {
			6.0f,  4.0f, 4.0f,  4.0f,
			5.0f,  5.0f, 7.0f,  6.0f,
			4.0f, -9.0f, 3.0f, -7.0f,
			9.0f,  1.0f, 7.0f, -6.0f
		};
		assert_eq(det4(a), -2120.0f);
		assert(is_invertible(a));
	}
#line 209
	{ // full determinant
		Matrix a {
			-2.0f, -8.0f,  3.0f,  5.0f,
			-3.0f,  1.0f,  7.0f,  3.0f,
			 1.0f,  2.0f, -9.0f,  6.0f,
			-6.0f,  7.0f,  7.0f, -9.0f
		};
		assert_eq(cofactor4(a, 0, 0), 690.0f);
		assert_eq(cofactor4(a, 0, 1), 447.0f);
		assert_eq(cofactor4(a, 0, 2), 210.0f);
		assert_eq(cofactor4(a, 0, 3), 51.0f);
		assert_eq(det4(a), -4071.0f);
	}
#line 173
	{ // 3x3 determinant
		Matrix a {
			 1.0f, 2.0f,  6.0f,
			-5.0f, 8.0f, -4.0f,
			 2.0f, 6.0f,  4.0f
		};
		assert_eq(cofactor3(a, 0, 0), 56.0f);
		assert_eq(cofactor3(a, 0, 1), 12.0f);
		assert_eq(cofactor3(a, 0, 2), -46.0f);
		assert_eq(det3(a), -196.0f);
	}
#line 140
	{ // cofactor
		Matrix a {
			3.0f,  5.0f,  0.0f,
			2.0f, -1.0f, -7.0f,
			6.0f, -1.0f,  5.0f
		};
		assert_eq(minor3(a, 0, 0), -12.0f);
		assert_eq(cofactor3(a, 0, 0), -12.0f);
		assert_eq(minor3(a, 1, 0), 25.0f);
		assert_eq(cofactor3(a, 1, 0), -25.0f);
	}
#line 110
	{ // minor3
		Matrix a {
			3.0f,  5.0f,  0.0f,
			2.0f, -1.0f, -7.0f,
			6.0f, -1.0f,  5.0f
		};
		assert_eq(det2(sub(a, 1, 0)), 25.0f);
		assert_eq(minor3(a, 1, 0), 25.0f);
	}
#line 88
	{ // test 3x3 submatrix
		Matrix a {
			-6.0f, 1.0f,  1.0f, 6.0f,
			-8.0f, 5.0f,  8.0f, 6.0f,
			-1.0f, 0.0f,  8.0f, 2.0f,
			-7.0f, 1.0f, -1.0f, 1.0f
		};
		Matrix e {
			-6.0f,  1.0f, 6.0f,
			-8.0f,  8.0f, 6.0f,
			-7.0f, -1.0f, 1.0f
		};
		assert(sub(a, 2, 1) == e);
	}
#line 37
	{ // test 2x2 submatrix
		Matrix a {
			 1.0f, 5.0f,  0.0f,
			-3.0f, 2.0f,  7.0f,
			 0.0f, 6.0f, -3.0f
		};
		Matrix e {
			-3.0f, 2.0f,
			 0.0f, 6.0f
		};
		assert(sub(a, 0, 2) == e);
	}
#line 9
	{ // 2x2 determinant
		Matrix a {
			 1.0f, 5.0f,
			-3.0f, 2.0f
		};
		assert_eq(17.0f, det2(a));
	}
#line 50 "3_transposing-matrices.md"
	{ // transpose identity matrix
		assert(trans(identity) == identity);
	}
#line 9
	{ // transpose test
		Matrix a {
			0.0f, 9.0f, 3.0f, 0.0f,
			9.0f, 8.0f, 0.0f, 8.0f,
			1.0f, 8.0f, 5.0f, 3.0f,
			0.0f, 0.0f, 5.0f, 8.0f
		};
		Matrix e {
			0.0f, 9.0f, 1.0f, 0.0f,
			9.0f, 8.0f, 8.0f, 0.0f,
			3.0f, 0.0f, 5.0f, 5.0f,
			0.0f, 8.0f, 3.0f, 8.0f
		};
		assert(trans(a) == e);
	}
#line 41 "3_identity-matrix.md"
	{ // tuple multiply with identity
		Tuple t {
			1.0f, 2.0f, 3.0f, 4.0f
		};
		assert(identity * t == t);
	}
#line 8
	{ // matrix multiply with identity
		Matrix a {
			0.0f, 1.0f,  2.0f,  4.0f,
			1.0f, 2.0f,  4.0f,  8.0f,
			2.0f, 4.0f,  8.0f, 16.0f,
			4.0f, 8.0f, 16.0f, 32.0f
		};
		assert(a * identity == a);
	}
#line 74 "3_multiplying-matrices.md"
	{ // matrix/tuple multiplication
		Matrix a {
			1.0f, 2.0f, 3.0f, 4.0f,
			2.0f, 4.0f, 4.0f, 2.0f,
			8.0f, 6.0f, 4.0f, 1.0f,
			0.0f, 0.0f, 0.0f, 1.0f
		};
		Tuple t { 1.0f, 2.0f, 3.0f, 1.0f };
		Tuple e { 18.0f, 24.0f, 33.0f, 1.0f };
		assert(a * t == e);
	}
#line 8
	{ // matrix multiply
		Matrix a {
			1.0f, 2.0f, 3.0f, 4.0f,
			5.0f, 6.0f, 7.0f, 8.0f,
			9.0f, 8.0f, 7.0f, 6.0f,
			5.0f, 4.0f, 3.0f, 2.0f
		};
		Matrix b {
			-2.0f, 1.0f, 2.0f,  3.0f,
			 3.0f, 2.0f, 1.0f, -1.0f,
			 4.0f, 3.0f, 6.0f,  5.0f,
			 1.0f, 2.0f, 7.0f,  8.0f
		};
		Matrix e {
			20.0f, 22.0f,  50.0f,  48.0f,
			44.0f, 54.0f, 114.0f, 108.0f,
			40.0f, 58.0f, 110.0f, 102.0f,
			16.0f, 26.0f,  46.0f,  42.0f
		};
		assert(a * b == e);
	}
#line 224 "3_creating-matrices.md"
	{ // check for inequality
		Matrix a {
			1.0f, 2.0f, 3.0f, 4.0f,
			5.0f, 6.0f, 7.0f, 8.0f,
			9.0f, 8.0f, 7.0f, 6.0f,
			5.0f, 4.0f, 3.0f, 2.0f
		};
		Matrix b {
			2.0f, 3.0f, 4.0f, 5.0f,
			6.0f, 7.0f, 8.0f, 9.0f,
			8.0f, 7.0f, 6.0f, 5.0f,
			4.0f, 3.0f, 2.0f, 1.0f
		};
		assert(a != b);
	}
#line 176
	{ // check for equality
		Matrix a {
			1.0f, 2.0f, 3.0f, 4.0f,
			5.0f, 6.0f, 7.0f, 8.0f,
			9.0f, 8.0f, 7.0f, 6.0f,
			5.0f, 4.0f, 3.0f, 2.0f
		};
		Matrix b {
			1.0f, 2.0f, 3.0f, 4.0f,
			5.0f, 6.0f, 7.0f, 8.0f,
			9.0f, 8.0f, 7.0f, 6.0f,
			5.0f, 4.0f, 3.0f, 2.0f
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
