#line 17 "./6_phong-reflection-model.md"
#pragma once
#include "color.h"
#line 174
#include "light.h"
#line 19

#line 46
struct Point_Light {
	Tuple position;
	Color intensity;
};
#line 198

Color lighting(
	const Material &m, const Point_Light &l,
	const Tuple &p, const Tuple &e, const Tuple &n,
	bool in_shadow = false
) {
	Color res { 0, 0, 0 };
	// lighting
#line 216
	auto ec { m.color * l.intensity };
	res = ec * m.ambient;
	auto lv { norm(l.position - p) };
	auto ldn { dot(lv, n) };
	if (ldn >= 0 && ! in_shadow) {
		res = res + ec * m.diffuse * ldn;
		auto r { reflect(-lv, n) };
		auto rde { dot(r, e) };
		if (rde >= 0) {
			auto f { powf(rde, m.shininess) };
			res = res + l.intensity * m.specular * f;
		}
	}
#line 206
	return res;
}
#line 20
inline void light_tests() {
	// light-tests
#line 298
	{ // eye behind the surface
		Material m;
		auto pos { mk_point(0, 0, 0) };
		auto eye { mk_vector(0, 0, -1) };
		auto n { mk_vector(0, 0, -1) };
		auto lp { mk_point(0, 0, 10) };
		Color lc { 1, 1, 1 };
		Point_Light l { lp, lc };
		Color e { 0.1, 0.1, 0.1 };
		assert(lighting(m, l, pos, eye, n) == e);
	}
#line 277
	{ // offset eye and light source
		Material m;
		auto pos { mk_point(0, 0, 0) };
		float f { sqrtf(2)/2 };
		auto eye { mk_vector(0, -f, -f) };
		auto n { mk_vector(0, 0, -1) };
		auto lp { mk_point(0, 10, -10) };
		Color lc { 1, 1, 1 };
		Point_Light l { lp, lc };
		float g { 1.6364 };
		Color e { g, g, g };
		assert(lighting(m, l, pos, eye, n) == e);
	}
#line 257
	{ // offset light source
		Material m;
		auto pos { mk_point(0, 0, 0) };
		auto eye { mk_vector(0, 0, -1) };
		auto n { mk_vector(0, 0, -1) };
		auto lp { mk_point(0, 10, -10) };
		Color lc { 1, 1, 1 };
		Point_Light l { lp, lc };
		float f { 0.7364 };
		Color e { f, f, f };
		assert(lighting(m, l, pos, eye, n) == e);
	}
#line 237
	{ // offset eye
		Material m;
		auto pos { mk_point(0, 0, 0) };
		float f { sqrtf(2)/2 };
		auto eye { mk_vector(0, f, -f) };
		auto n { mk_vector(0, 0, -1) };
		auto lp { mk_point(0, 0, -10) };
		Color lc { 1, 1, 1 };
		Point_Light l { lp, lc };
		Color e { 1, 1, 1 };
		assert(lighting(m, l, pos, eye, n) == e);
	}
#line 177
	{ // eye between light and object
		Material m;
		auto pos { mk_point(0, 0, 0) };
		auto eye { mk_vector(0, 0, -1) };
		auto n { mk_vector(0, 0, -1) };
		auto lp { mk_point(0, 0, -10) };
		Color lc { 1, 1, 1 };
		Point_Light l { lp, lc };
		Color e { 1.9, 1.9, 1.9 };
		assert(lighting(m, l, pos, eye, n) == e);
	}
#line 30
	{ // point light attributes
		Color i { 1, 1, 1 };
		auto p { mk_point(0, 0, 0) };
		Point_Light l { p, i };
		assert(l.position == p);
		assert(l.intensity == i);
	}
#line 22
}
