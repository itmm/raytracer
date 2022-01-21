#line 17 "./7_building-a-world.md"
#pragma once
#include "sphere.h"
#include "light.h"
#line 44
#include <memory>
#line 20

#line 46
struct World {
	std::vector<std::unique_ptr<Object>> objects;
	std::vector<std::unique_ptr<Point_Light>> lights;
};
#line 84

#line 177
#include "ray.h"	
#include <algorithm>

Intersections intersect_world(const World &w, const Ray &r) {
	Intersections res {};
	for (auto &o : w.objects) {
		auto i { o->intersect(r) };
		res.insert(res.end(), i.begin(), i.end());
	}
	std::sort(res.begin(), res.end());
	return res;
}
#line 85
World default_world() {
	World w;
	w.lights.push_back(std::make_unique<Point_Light>(
		mk_point(-10, 10, -10),
		Color {1, 1, 1}
	));
	std::unique_ptr<Object> s1 { new Sphere() };
	s1->material.color = { 0.8, 1, 0.6 };
	s1->material.diffuse = 0.7;
	s1->material.specular = 0.2;
	w.objects.push_back(std::move(s1));
	std::unique_ptr<Object> s2 { new Sphere() };
	s2->transform = scaling(0.5, 0.5, 0.5);
	s2->inv_transform = inv(s2->transform);
	w.objects.push_back(std::move(s2));
	return w;
}
#line 21
inline void world_tests() {
	// world-tests
#line 154
	{ // ray intersection
		auto w { default_world() };
		auto p { mk_point(0, 0, -5) };
		auto v { mk_vector(0, 0, 1) };
		Ray r { p, v };
		auto xs { intersect_world(w, r) };
		assert(xs.size() == 4);
		assert_eq(xs[0].t, 4);
		assert_eq(xs[1].t, 4.5);
		assert_eq(xs[2].t, 5.5);
		assert_eq(xs[3].t, 6);
	}
#line 58
	{ // test default world
		auto w { default_world() };
		Point_Light le { mk_point(-10, 10, -10), { 1, 1, 1 } };
		assert(w.lights.size() >= 1);
		assert(*w.lights[0] == le);
		Sphere s1;
		s1.material.color = { 0.8, 1, 0.6 };
		s1.material.diffuse = 0.7;
		s1.material.specular = 0.2;
		assert(w.objects.size() >= 2);
		assert(*w.objects[0] == s1);
		Sphere s2;
		s2.transform = scaling(0.5, 0.5, 0.5);
		s2.inv_transform = inv(s2.transform);
		assert(*w.objects[1] == s2);
	}
#line 31
	{ // empty world
		World w;
		assert(w.objects.empty());
		assert(w.lights.empty());
	}
#line 23
}
