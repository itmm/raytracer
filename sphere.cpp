#line 78 "5_intersect-sphere.md"
#include "sphere.h"
#line 137
#include <algorithm>
#line 79

#line 139
Intersections::Intersections(std::initializer_list<Intersection> l):
	std::vector<Intersection>(l)
{
	std::sort(begin(), end());
}
#line 123
Ray transform(const Ray &r, const Matrix &m) {
	return {
		m * r.origin,
		m * r.direction
	};
}
#line 80
Intersections Sphere::intersect(const Ray &r) {
	auto r2 { ::transform(r, inv_transform) };
	auto s2r { r2.origin - mk_point(0.0f, 0.0f, 0.0f) };
	auto a { dot(r2.direction, r2.direction) };
	auto b { 2 * dot(r2.direction, s2r) };
	auto c { dot(s2r, s2r) - 1 };
	auto discr { b * b - 4.0f * a * c };
	if (discr < 0) { 
		return {};
	}
	auto sd { sqrtf(discr) };
	return {
		{(-b - sd)/(2.0f * a), this},
		{(-b + sd)/(2.0f * a), this}
	};
}
#line 66 "6_surface-normals.md"
Tuple Sphere::normal_at(const Tuple &w) {
	auto i { inv_transform };
	auto o { i * w };
	auto on { o - mk_point(0, 0, 0) };
	auto wn { trans(i) * on };
	wn.w = 0;
	return norm(wn);
}
