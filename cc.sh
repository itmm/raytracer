#!/bin/bash

echo `date +%T` "compiling .."
c++ -x c++ -o raytracer -
if [ $? -eq 0 ]; then
	echo `date +%T` "running .."
	./raytracer
	echo `date +%T` "done"
fi

