.PHONY: all clean

FLAGS:=-std=c++11 -Wall -Wextra -pedantic -march=native -O3 $(CXXFLAGS)
FLAGS:=$(FLAGS) -Iinclude

ALL=validate

OBJ=obj/input_generator.o \
    obj/sse-convert.o

DEPS=include/scalar-parser.h

all: $(ALL)

validate: src/validate.cpp $(DEPS) $(OBJ)
	$(CXX) $(FLAGS) $< $(OBJ) -o $@

verify: src/verify.cpp $(DEPS) $(OBJ)
	$(CXX) $(FLAGS) $< $(OBJ) -o $@

obj/input_generator.o: src/input_generator.cpp include/input_generator.h
	$(CXX) $(FLAGS) $< -c -o $@

obj/sse-convert.o: src/sse-convert.cpp include/sse-convert.h
	$(CXX) $(FLAGS) $< -c -o $@

src/blocks.inl: scripts/generator.py scripts/writer.py
	python $< $@

clean:
	$(RM) $(ALL)
