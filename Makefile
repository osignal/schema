

.PHONY: cpp go java python rust

all: cpp go java python rust

clean:
	rm -rf build

cpp go java python rust:
	mkdir -p build/$@ && flatc --$@ -o build/$@ *.fbs
