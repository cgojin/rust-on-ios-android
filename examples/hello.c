#include <stdint.h>
#include <stdio.h>

#include "../src/lib.h"

int main() {
    printf("Calling Rust code from C %d\n", add(2, 3));
}
