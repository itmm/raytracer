#line 43 "./5_creating-rays.md"
#include "tuple.h"

struct Ray {
#line 77
	constexpr auto pos(float t) const {
		return origin + t * direction;
	}
#line 46
	Tuple origin;
	Tuple direction;
};
#line 17
#pragma once
#include "tuple.h"

inline void ray_tests() {
	// ray-tests
#line 57
	{ // position on a ray
		auto o { mk_point(2.0f, 3.0f, 4.0f) };
		auto d { mk_vector(1.0f, 0.0f, 0.0f) };
		Ray r { o, d };
		assert(r.pos(0.0f) == o);
		auto e1 { mk_point(3.0f, 3.0f, 4.0f) };
		assert(r.pos(1.0f) == e1);
		auto e2 { mk_point(1.0f, 3.0f, 4.0f) };
		assert(r.pos(-1.0f) == e2);
		auto e3 { mk_point(4.5f, 3.0f, 4.0f) };
		assert(r.pos(2.5f) == e3);
	}
#line 30
	{ // check attributes
		auto o { mk_point(1.0f, 2.0f, 3.0f) };
		auto d { mk_vector(4.0f, 5.0f, 6.0f) };
		Ray r { o, d };
		assert(r.origin == o);
		assert(r.direction == d);
	}
#line 22
}
