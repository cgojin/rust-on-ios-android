#include <jni.h>
#include <string>

extern "C" {
#include "../../../../../../src/lib.h"
}

extern "C" JNIEXPORT jstring JNICALL
Java_com_gongjin_rustonandroid_MainActivity_stringFromJNI(
        JNIEnv* env,
        jobject /* this */) {
    std::string hello = "Hello from C++";
    return env->NewStringUTF(hello.c_str());
}

extern "C" JNIEXPORT jint JNICALL
Java_com_gongjin_rustonandroid_MainActivity_add(
        JNIEnv* env,
        jobject /* this */,
        jint left,
        jint right) {
    return add(left, right);
}
