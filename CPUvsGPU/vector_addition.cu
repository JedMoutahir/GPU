#include <stdio.h>
#include <stdlib.h>
#include <windows.h>
#include <omp.h>

#define N 100000000

void add_cpu(float *x, float *y, float *z) {
    #pragma omp parallel for
    for (int i = 0; i < N; i++) {
        z[i] = x[i] + y[i];
    }
}

__global__ void add_gpu(float *x, float *y, float *z) {
    int i = blockIdx.x * blockDim.x + threadIdx.x;
    if (i < N) {
        z[i] = x[i] + y[i];
    }
}

int main() {
    float *x, *y, *z_cpu, *z_gpu;
    size_t size = N * sizeof(float);

    // Allocate memory for arrays on host (CPU)
    x = (float *) malloc(size);
    y = (float *) malloc(size);
    z_cpu = (float *) malloc(size);
    z_gpu = (float *) malloc(size);

    // Initialize arrays
    for (int i = 0; i < N; i++) {
        x[i] = 1.0f;
        y[i] = 2.0f;
    }

    // Measure time taken by CPU with OpenMP
    LARGE_INTEGER start, end, frequency;
    QueryPerformanceFrequency(&frequency);
    QueryPerformanceCounter(&start);
    add_cpu(x, y, z_cpu);
    QueryPerformanceCounter(&end);
    double cpu_time_omp = (end.QuadPart - start.QuadPart) / (double) frequency.QuadPart;
    printf("Time taken by CPU with OpenMP: %.6f seconds\n", cpu_time_omp);

    // Allocate memory for arrays on device (GPU)
    float *d_x, *d_y, *d_z;
    cudaMalloc(&d_x, size);
    cudaMalloc(&d_y, size);
    cudaMalloc(&d_z, size);

    // Copy input data from host to device
    cudaMemcpy(d_x, x, size, cudaMemcpyHostToDevice);
    cudaMemcpy(d_y, y, size, cudaMemcpyHostToDevice);

    // Measure time taken by GPU
    QueryPerformanceCounter(&start);
    add_gpu<<<(N + 255) / 256, 256>>>(d_x, d_y, d_z);
    cudaDeviceSynchronize();
    QueryPerformanceCounter(&end);
    double gpu_time = (end.QuadPart - start.QuadPart) / (double) frequency.QuadPart;
    printf("Time taken by GPU: %.6f seconds\n", gpu_time);

    // Copy output data from device to host
    cudaMemcpy(z_gpu, d_z, size, cudaMemcpyDeviceToHost);

    // Verify correctness of GPU results
    for (int i = 0; i < N; i++) {
        if (z_cpu[i] != z_gpu[i]) {
            printf("Error: GPU and CPU results do not match\n");
            break;
        }
    }

    // Free memory on host and device
    free(x);
    free(y);
    free(z_cpu);
    free(z_gpu);
    cudaFree(d_x);
    cudaFree(d_y);
    cudaFree(d_z);

    return 0;
}
