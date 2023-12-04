CORE_FILES := src/csv.c src/point.c
HEADER_FILES := src/constants.h

all: serial shared_cpu distributed_cpu shared_gpu
serial: src/serial.c src/k_clustering.c $(CORE_FILES) $(HEADER_FILES)
	gcc -Wall src/serial.c src/k_clustering.c $(CORE_FILES) -o output/serial
shared_cpu: src/shared_cpu.c src/shared_cpu_k_clustering.c $(CORE_FILES) $(HEADER_FILES)
	gcc -Wall -fopenmp src/shared_cpu.c src/shared_cpu_k_clustering.c $(CORE_FILES) -o output/shared_cpu
distributed_cpu: src/distributed_cpu.c src/distributed_cpu_k_clustering.c $(CORE_FILES) $(HEADER_FILES)
	mpicc -g -Wall -std=c99 -o output/distributed_cpu src/distributed_cpu.c src/distributed_cpu_k_clustering.c $(CORE_FILES)
shared_gpu: src/shared_gpu.c src/shared_gpu_k_clustering.c src/kernel.cu $(CORE_FILES) $(HEADER_FILES)
	nvcc src/shared_gpu.c src/shared_gpu_k_clustering.c $(CORE_FILES) src/kernel.cu -o output/shared_gpu
clean:
	rm -f output/*
