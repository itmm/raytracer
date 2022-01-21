#line 18 "./5_intersect-sphere.md"
#pragma once
#include "ray.h"
#line 49
#include "matrix.h"
#line 8 "./5_transforming-rays-and-spheres.md"
#include "transform.h"
Ray transform(const Ray &r, const Matrix &m);
#line 103 "./5_intersect-sphere.md"
#include <vector>
#line 128 "./6_phong-reflection-model.md"
#include "material.h"
#line 20 "./5_intersect-sphere.md"

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
#line 131 "./6_phong-reflection-model.md"
	Material material;
#line 45 "./6_surface-normals.md"
	virtual Tuple normal_at(const Tuple &w) = 0;
#line 65 "./5_intersect-sphere.md"
	virtual Intersections intersect(const Ray &r) = 0;
#line 52
	Matrix transform = identity;
	Matrix inv_transform = identity;
};
#line 127 "./7_building-a-world.md"

inline bool operator==(const Object &a, const Object &b) {
	return typeid(a) == typeid(b) &&
		a.material == b.material &&
		a.transform == b.transform;
}
#line 55 "./5_intersect-sphere.md"
struct Sphere: Object {
#line 56 "./6_surface-normals.md"
	Tuple normal_at(const Tuple &w) override;
#line 70 "./5_intersect-sphere.md"
	Intersections intersect(const Ray &r) override;
#line 56
};
#line 21
inline void sphere_tests() {
	// sphere-tests
#line 159 "./6_phong-reflection-model.md"
	{ // assign material to sphere
		Sphere s;
		Material m;
		m.ambient = 1;
		s.material = m;
		assert(s.material == m);
	}
#line 115
	{ // sphere has default material
		Sphere s;
		Material m;
		assert(s.material == m);
	}
#line 96 "./5_transforming-rays-and-spheres.md"
	{ // translated sphere
		auto o { mk_point(0.0f, 0.0f, -5.0f) };
		auto d { mk_vector(0.0f, 0.0f, 1.0f) };
		Ray r { o, d };
		Sphere s;
		s.transform = translation(5.0f, 0.0f, 0.0f);
		s.inv_transform = inv(s.transform);
		auto xs { s.intersect(r) };
		assert(xs.size() == 0);
	}
#line 76
	{ // scaled sphere
		auto o { mk_point(0.0f, 0.0f, -5.0f) };
		auto d { mk_vector(0.0f, 0.0f, 1.0f) };
		Ray r { o, d };
		Sphere s;
		s.transform = scaling(2.0f, 2.0f, 2.0f);
		s.inv_transform = inv(s.transform);
		auto xs { s.intersect(r) };
		assert(xs.size() == 2);
		assert_eq(xs[0].t, 3.0f);
		assert_eq(xs[1].t, 7.0f);
	}
#line 61
	{ // spheres translation
		Sphere s;
		auto m { translation(2.0f, 3.0f, 4.0f) };
		s.transform = m;
		s.inv_transform = inv(m);
		assert(s.transform == m);
	}
#line 49
	{ // spheres default transform
		Sphere s;
		assert(s.transform == identity);
	}
#line 30
	{ // scale ray
		auto o { mk_point(1.0f, 2.0f, 3.0f) };
		auto d { mk_vector(0.0f, 1.0f, 0.0f) };
		Ray r { o, d };
		auto m { scaling(2.0f, 3.0f, 4.0f) };
		auto r2 { transform(r, m) };
		auto eo { mk_point(2.0f, 6.0f, 12.0f) };
		auto ed { mk_vector(0.0f, 3.0f, 0.0f) };
		assert(r2.origin == eo);
		assert(r2.direction == ed);
	}
#line 12
	{ // translate ray
		auto o { mk_point(1.0f, 2.0f, 3.0f) };
		auto d { mk_vector(0.0f, 1.0f, 0.0f) };
		Ray r { o, d };
		auto m { translation(3.0f, 4.0f, 5.0f) };
		auto r2 { transform(r, m) };
		auto eo { mk_point(4.0f, 6.0f, 8.0f) };
		assert(r2.origin == eo);
		assert(r2.direction == d);
	}
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
