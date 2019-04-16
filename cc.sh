#!/bin/bash

c++ -x c++ -o raytracer -
if [ $? -eq 0 ]; then
	./raytracer
fi

