.PHONY: all

all: rust c

# for debug
CC += -g

# rust
rust: target/debug/examples/hello
	target/debug/examples/hello

target/debug/examples/hello: examples/hello.rs src/lib.rs Cargo.toml
	cargo build --example hello

# lib
lib: target/debug/libmath.a

target/debug/libmath.a: src/lib.rs Cargo.toml
	cargo build --lib

# c
c: target/hello-c
	target/hello-c

target/hello-c: target/hello.o target/debug/libmath.a
	$(CC) -o $@ $^

target/hello.o: examples/hello.c target
	$(CC) -o $@ -c $<


# make `target` directory
target:
	mkdir -p $@

# clean all
clean:
	rm -rf target
