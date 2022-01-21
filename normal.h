#line 17 "./6_surface-normals.md"
#pragma once
#include "sphere.h"

inline void normal_tests() {
	// normal-tests
#line 158
	{ // normal of transformed sphere
		Sphere s;
		s.transform = scaling(1, 0.5, 1) * rotate_z(M_PI/5);
		s.inv_transform = inv(s.transform);
		float f { sqrtf(2)/2 };
		auto n { s.normal_at(mk_point(0, f, -f)) };
		auto e { mk_vector(0, 0.97014, -0.24254) };
		assert(e == n);
	}
#line 142
	{ // normal of translated sphere
		Sphere s;
		s.transform = translation(0, 1, 0);
		s.inv_transform = inv(s.transform);
		auto n { s.normal_at(mk_point(0, 1.70711, -0.70711)) };
		auto e { mk_vector(0, 0.70711, -0.70711) };
		assert(e == n);
	}
#line 127
	{ // normal of a normal
		Sphere s;
		float f { sqrtf(3)/3 };
		auto p { mk_point(f, f, f) } ;
		auto n { s.normal_at(p) };
		assert(n == norm(n));
	}
#line 111
	{ // on sphere, non-axial
		Sphere s;
		float f { sqrtf(3)/3 };
		auto p { mk_point(f, f, f) } ;
		auto n { s.normal_at(p) };
		auto e { mk_vector(f, f, f) };
		assert(n == e);
	}
#line 96
	{ // on sphere, z-axis
		Sphere s;
		auto p { mk_point(0, 0, 1) } ;
		auto n { s.normal_at(p) };
		auto e { mk_vector(0, 0, 1) };
		assert(n == e);
	}
#line 81
	{ // on sphere, y-axis
		Sphere s;
		auto p { mk_point(0, 1, 0) } ;
		auto n { s.normal_at(p) };
		auto e { mk_vector(0, 1, 0) };
		assert(n == e);
	}
#line 30
	{ // on sphere, x-axis
		Sphere s;
		auto p { mk_point(1, 0, 0) } ;
		auto n { s.normal_at(p) };
		auto e { mk_vector(1, 0, 0) };
		assert(n == e);
	}
#line 22
}
