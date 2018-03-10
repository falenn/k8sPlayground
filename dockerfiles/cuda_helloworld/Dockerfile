FROM nvidia/cuda

COPY ./helloworld.cu:/helloWorld.cu

RUN nvcc helloWorld.cu -o helloWorld
