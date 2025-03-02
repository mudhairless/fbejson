COMPILER = fbc
COMPILE_OPTS = -i inc -g -w all -exx
LINK_OPTS = -lib
TEST_COMPILE_OPTS = -i inc -p lib
EXE_EXT = .exe

all: lib/libfbbase64.a lib/libfbjson.a examples tests

%.o: %.bas
	$(COMPILER) $(COMPILE_OPTS) -c $< -o $@

tests: tests/base64${EXE_EXT} tests/json${EXE_EXT}
	@echo ""
	@echo "Running Tests..."
	@tests/base64
	@tests/json

tests/base64.exe: lib/libfbbase64.a tests/base64.bas src/base64.o
	$(COMPILER) $(COMPILE_OPTS) $(TEST_COMPILE_OPTS) tests/base64.bas

tests/json.exe: lib/libfbjson.a libfbbase64.a tests/json.bas src/array.o src/object.o src/pair.o src/value.o
	$(COMPILER) $(COMPILE_OPTS) $(TEST_COMPILE_OPTS) -p lib tests/json.bas

#examples: examples/simple.exe

#examples/simple.exe: lib/fbjson.a examples/simple.bas
#	$(COMPILER) $(COMPILE_OPTS) -p lib examples/simple.bas

lib/libfbbase64.a: src/base64.o
	$(COMPILER) $(LINK_OPTS) -x lib/libfbbase64.a src/base64.o

lib/libfbjson.a: src/array.o src/object.o src/pair.o src/value.o
	$(COMPILER) $(LINK_OPTS) -x lib/libfbjson.a src/array.o src/object.o src/pair.o src/value.o

clean:
	rm src/*.o lib/*.a examples/*.exe tests/*.exe

.PHONY: clean
