# rust-on-ios-android

在 Android/iOS/macOS 中运行 Rust 代码示例；C/Swift 调用 Rust 代码示例。

## 编译主机静态库

```sh
make rust

# 或手工编译
cargo build --lib

# 查看 Rust 库(rlib) .rlib 导出的符号与函数
nm -gU target/debug/libmath.rlib
    0000000000000000 T _add

# 查看标准静态库(staticlib) .a 导出的符号与函数（Windows 扩展名为 .lib）
nm -gU target/debug/libmath.a
    0000000000000000 T _add
```

## Rust 调用 Rust

```sh
cargo run --example hello
```

## C 调用 Rust

```sh
make c

# 或手工编译
cc -g -o target/hello.o -c examples/hello.c
cc -g -o target/hello-c target/hello.o target/debug/libmath.a
target/hello-c
```

## Swift 调用 Rust

```sh
make swift

# 或手工编译
swiftc -g examples/hello.swift -o target/hello-swift -import-objc-header src/lib.h -Ltarget/debug -lmath
target/hello-swift
```

## 在 iOS/macOS 中运行 Rust 代码

### 编译 iOS/macOS 静态库

```sh
# 首次，添加构建 iOS/macOS 目标的 Rust 工具链
rustup target add aarch64-apple-ios aarch64-apple-ios-sim x86_64-apple-ios aarch64-apple-darwin x86_64-apple-darwin

# 编译 iOS/macOS 静态库
make apple

# 或者手工编译
cargo build --lib --target aarch64-apple-ios --target aarch64-apple-ios-sim --target x86_64-apple-ios --target aarch64-apple-darwin --target x86_64-apple-darwin
```

### Xcode 项目配置

在 Xcode 中打开 [examples/apple/RustOnApple.xcodeproj](examples/apple/RustOnApple.xcodeproj), 然后检查或修改 `RustOnApple` 目标的配置:

1. 设置 Objective-C 桥接头文件

    TARGETS -> RustOnApple -> Build Settings -> Objective-C Bridging Header,
    设置 `RustOnApple/BridgingHeader.h`

2. 链接库

    TARGETS -> RustOnApple -> Build Phases -> Link Binary With Libraries,
    添加 `libmath.a`

3. 添加库路径

    TARGETS -> RustOnApple -> Build Settings -> Library Search Paths,
    为各个指令架构添加 libmath.a，例如 iOS 真机添加  `../../target/aarch64-apple-ios/debug`

### 在 Xcode 中 断点调试 Rust 代码

安装 [rust-xcode-plugin](https://github.com/cgojin/rust-xcode-plugin) 插件，用于在 Xcode 中断点调试 Rust 代码。 

## 在 Android 中运行 Rust 代码

### 编译 Android 静态库

```sh
# 首次，添加构建 Adnroid 目的 Rust 工具链
rustup target add aarch64-linux-android armv7-linux-androideabi 

# 编译 Android 静态库
make android

# 或者手工编译
cargo build --target aarch64-linux-android --target armv7-linux-androideabi 

cd examples/android

# 编译 apk
./gradlew build

# 安装 apk 到 Android 设备
./gradlew installDebug
```

### 在 Android Studio 中断点调试 Rust 代码

1. 在 [Android Studio](https://developer.android.com/studio) 中打开 [examples/android](examples/android) 项目。
2. 在 [native-lib.cpp](examples/android/app/src/main/cpp/native-lib.cpp#L22) 中设置一个断点。
3. 以调试模式运行 App。
4. 当运行至 [native-lib.cpp](examples/android/app/src/main/cpp/native-lib.cpp#L22) 中的断点时，将会显示 `LLDB` 视图，然后在 `lldb` 命令行中设置断点：

```sh
# 设置一个断点在 `add` 函数处（同名函数可能多个）
lldb > breakpoint set --name add

# 或者设置一个断点在 `lib.rs` 第 3 行
lldb > breakpoint set --file lib.rs --line 3
```
