.PHONY: all

all: rust c swift

# for debug
CC += -g
SWIFTC = swiftc -g

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


# swift
swift: target/hello-swift
	target/hello-swift

target/hello-swift: examples/hello.swift src/lib.h target/debug/libmath.a
	$(SWIFTC) examples/hello.swift -o target/hello-swift -import-objc-header src/lib.h -Ltarget/debug -lmath


# ios/mac
ios: apple
mac: apple
apple: src/lib.rs Cargo.toml
	cargo build --lib --target aarch64-apple-ios --target aarch64-apple-ios-sim --target x86_64-apple-ios --target aarch64-apple-darwin --target x86_64-apple-darwin


# android
android: src/lib.rs Cargo.toml
	cargo build --target aarch64-linux-android --target armv7-linux-androideabi 


# make `target` directory
target:
	mkdir -p $@

# clean all
clean:
	rm -rf target
