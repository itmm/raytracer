.PHONY = build-rt clean test test-rt

SOURCEs = README.md \
	1_tuples.md 1_operations.md \
	2_representing-colors.md 2_color-operations.md 2_ppm.md \
	3_creating-matrices.md

CXXFLAGS += -Wall -pedantic --std=c++17
CXXSOURCEs = raytracer.cpp tuple.h color.h ppm.h matrix.h

build-rt: md-run.txt
	$(MAKE) raytracer

md-run.txt: $(SOURCEs)
	c-cat $^ | md-patcher
	date >$@

raytracer: $(CXXSOURCEs)
	$(CXX) $(CXXFLAGS) raytracer.cpp -o $@

clean:
	rm -f raytracer $(CXXSOURCEs) md-run.txt 

test: md-run.txt
	$(MAKE) test-rt

test-rt: raytracer
	./raytracer
