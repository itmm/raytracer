#line 17 "3_creating-matrices.md"
#pragma once
#line 52

class Matrix {
	public:
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
#line 18
#include "tuple.h"

inline void matrix_tests() {
	// matrix-tests
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
