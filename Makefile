.PHONY = build-rt clean test test-rt

SOURCEs = $(wildcard *.md)

CXXFLAGS += -Wall -pedantic --std=c++17
CXXSOURCEs = raytracer.cpp tuple.h color.h ppm.h matrix.h transform.h ray.h \
	sphere.cpp sphere.h normal.h light.h material.h world.h

test: md-run.txt
	$(MAKE) test-rt

build-rt: md-run.txt
	$(MAKE) raytracer

md-run.txt: $(SOURCEs)
	mdp README.md
	date >$@

raytracer: $(CXXSOURCEs)
	$(CXX) $(CXXFLAGS) raytracer.cpp sphere.cpp -o $@

clean:
	rm -f raytracer $(CXXSOURCEs) md-run.txt 

test-rt: raytracer
	./raytracer
