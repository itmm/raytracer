#line 18 "./5_intersect-sphere.md"
#pragma once
#include "ray.h"
#line 49
#include "matrix.h"
#line 103
#include <vector>
#line 20

#line 105
struct Object;
struct Intersection {
	float t;
	Object *object;
};
#line 42 "./5_identifying-hits.md"
inline constexpr bool operator==(const Intersection &a, const Intersection &b) {
	return a.object == b.object && eq(a.t, b.t);
}
#line 110 "./5_intersect-sphere.md"

#line 155
inline bool operator<(const Intersection &a, const Intersection &b) {
	return a.t < b.t;
}
#line 111
class Intersections: public std::vector<Intersection> {
	public:
		Intersections(std::initializer_list<Intersection> l);
};
#line 26 "./5_identifying-hits.md"
inline auto hit(Intersections &xs) {
	for (auto i = xs.begin(); i != xs.end(); ++i) {
		if (i->t >= 0.0f) { return i; }
	}
	return xs.end();
}
#line 51 "./5_intersect-sphere.md"
struct Object {
#line 65
	virtual Intersections intersect(const Ray &r) = 0;
#line 52
	Matrix transform = identity;
	Matrix inv_transform = identity;
};
struct Sphere: Object {
#line 70
	Intersections intersect(const Ray &r) override;
#line 56
};
#line 21
inline void sphere_tests() {
	// sphere-tests
#line 85 "./5_identifying-hits.md"
	{ // lowest non-negative
		Sphere s;
		Intersection i1 { 5.0f, &s };
		Intersection i2 { 7.0f, &s };
		Intersection i3 { -3.0f, &s };
		Intersection i4 { 2.0f, &s };
		Intersections xs { i1, i2, i3, i4 };
		auto i { hit(xs) };
		assert(*i == i4);
	}
#line 69
	{ // only negative intersections
		Sphere s;
		Intersection i1 { -2.0f, &s };
		Intersection i2 { -1.0f, &s };
		Intersections xs { i2, i1 };
		auto i { hit(xs) };
		assert(i == xs.end());
	}
#line 53
	{ // one negative intersection
		Sphere s;
		Intersection i1 { -1.0f, &s };
		Intersection i2 { 1.0f, &s };
		Intersections xs { i2, i1 };
		auto i { hit(xs) };
		assert(*i == i2);
	}
#line 8
	{ // two positive intersections
		Sphere s;
		Intersection i1 { 1.0f, &s };
		Intersection i2 { 2.0f, &s };
		Intersections xs { i2, i1 };
		auto i { hit(xs) };
		assert(*i == i1);
	}
#line 25 "./5_tracking-intersections.md"
	{ // interaction objects
		auto o { mk_point(0.0f, 0.0f, -5.0f) };
		auto d { mk_vector(0.0f, 0.0f, 1.0f) };
		Ray r { o, d };
		Sphere s;
		auto xs { s.intersect(r) };
		assert(xs.size() == 2);
		assert(xs[0].object == &s);
		assert(xs[1].object == &s);
	}
#line 8
	{ // intersection values
		Sphere s;
		Intersection i1 { 1.0f, &s };
		Intersection i2 { 2.0f, &s };
		Intersections xs { i1, i2 };
		assert(xs.size() == 2);
		assert_eq(xs[0].t, 1.0f);
		assert_eq(xs[1].t, 2.0f);
	}
#line 218 "./5_intersect-sphere.md"
	{ // sphere is behind ray
		auto o { mk_point(0.0f, 0.0f, 5.0f) };
		auto d { mk_vector(0.0f, 0.0f, 1.0f) };
		Ray r { o, d };
		Sphere s;
		auto xs { s.intersect(r) };
		assert(xs.size() == 2);
		assert_eq(xs[0].t, -6.0f);
		assert_eq(xs[1].t, -4.0f);
	}
#line 200
	{ // start inside
		auto o { mk_point(0.0f, 0.0f, 0.0f) };
		auto d { mk_vector(0.0f, 0.0f, 1.0f) };
		Ray r { o, d };
		Sphere s;
		auto xs { s.intersect(r) };
		assert(xs.size() == 2);
		assert_eq(xs[0].t, -1.0f);
		assert_eq(xs[1].t, 1.0f);
	}
#line 184
	{ // no intersections
		auto o { mk_point(0.0f, 2.0f, -5.0f) };
		auto d { mk_vector(0.0f, 0.0f, 1.0f) };
		Ray r { o, d };
		Sphere s;
		auto xs { s.intersect(r) };
		assert(xs.size() == 0);
	}
#line 166
	{ // one intersection
		auto o { mk_point(0.0f, 1.0f, -5.0f) };
		auto d { mk_vector(0.0f, 0.0f, 1.0f) };
		Ray r { o, d };
		Sphere s;
		auto xs { s.intersect(r) };
		assert(xs.size() == 2);
		assert_eq(xs[0].t, 5.0f);
		assert_eq(xs[1].t, 5.0f);
	}
#line 31
	{ // two intersections
		auto o { mk_point(0.0f, 0.0f, -5.0f) };
		auto d { mk_vector(0.0f, 0.0f, 1.0f) };
		Ray r { o, d };
		Sphere s;
		auto xs { s.intersect(r) };
		assert(xs.size() == 2);
		assert_eq(xs[0].t, 4.0f);
		assert_eq(xs[1].t, 6.0f);
	}
#line 23
}
