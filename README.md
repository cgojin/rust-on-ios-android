# rust-on-ios-android

Run rust code on iOS/Android example.

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
