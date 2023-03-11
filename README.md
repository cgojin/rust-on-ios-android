# rust-on-ios-android

Running Rust code on Android/iOS/macOS example, calling Rust code from C/Swift example.

## Building library

```sh
cargo build --lib

# Check exporting symbols of rlib
nm -gU target/debug/libmath.rlib
    0000000000000000 T _add

# Check exporting symbols of staticlib
nm -gU target/debug/libmath.a
    0000000000000000 T _add
```

## Calling Rust code from Rust

```sh
cargo run --example hello
```

## Calling Rust code from C

```sh
make c

# or manual building
cc -g -o target/hello.o -c examples/hello.c
cc -g -o target/hello-c target/hello.o target/debug/libmath.a
target/hello-c
```

## Calling Rust code from Swift

```sh
make swift

# or manual building
swiftc -g examples/hello.swift -o target/hello-swift -import-objc-header src/lib.h -Ltarget/debug -lmath
target/hello-swift
```

## Running Rust code on iOS/macOS

### Building library

```sh
# Add iOS/macOS rust toolchain first
rustup target add aarch64-apple-ios aarch64-apple-ios-sim x86_64-apple-ios aarch64-apple-darwin x86_64-apple-darwin

# building library
make apple

# or manual building library
cargo build --lib --target aarch64-apple-ios --target aarch64-apple-ios-sim --target x86_64-apple-ios --target aarch64-apple-darwin --target x86_64-apple-darwin
```

### iOS Porject Settings

Open `examples/apple/RustOnApple.xcodeproj`, and change/check the target `RustOnApple` settings:

1. Set Objective-C bridging header

    TARGETS -> RustOnApple -> Build Settings -> Objective-C Bridging Header,
    Set `RustOnApple/BridgingHeader.h`

2. Link the library

    TARGETS -> RustOnApple -> Build Phases -> Link Binary With Libraries,
    Add the `libmath.a`, 

3. Add library paths

    TARGETS -> RustOnApple -> Build Settings -> Library Search Paths,
    Add paths of libmath.a for each architecture, such as iOS device is  `../../target/aarch64-apple-ios/debug`

### Rust breakpoint in Xcode

Install [rust-xcode-plugin](https://github.com/cgojin/rust-xcode-plugin) for Rust breakpoint debugging in Xcode.
