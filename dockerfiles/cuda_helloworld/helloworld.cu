#include <stdio.h>

// Kernel-execution with __global__: empty function at this point

__global__ void kernel(void) {
// printf("Hello, Cuda!\n");
}

int main(void) {
// Kernel execution with <<<1,1>>>
kernel<<<1,1>>>();
printf("Hello, World!\n");
return 0;
}
