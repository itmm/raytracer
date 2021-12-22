.PHONY = build-rt clean test test-rt

SOURCEs = index.md 1_tuples.md 1_operations.md

build-rt: md-run.txt
	$(MAKE) raytracer

md-run.txt: $(SOURCEs)
	cat $^ | md-patcher
	date >$@

raytracer: raytracer.cpp tuple.h

clean:
	rm -f raytracer md-run.txt 

test: md-run.txt
	$(MAKE) test-rt

test-rt: raytracer
	./raytracer
