#!/bin/bash

# cat
c++ -x c++ -o raytracer -
if [ $? -eq 0 ]; then
	./raytracer
fi

