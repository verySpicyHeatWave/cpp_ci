# THIS IS FROM CHATGPT SO DON'T FUCKING TRUST IT UNTIL YOU'VE READ THE DOCUMENTATION

FROM ubuntu:24.04

# Install Dependencies
RUN apt update && apt install -y \
build-essential \
git \
cmake \
curl \
wget \
libgtest-dev \
g++ \
clang \
clang-tidy

# Build and install GTest
RUN cd /usr/src/gtest && \
cmake CMakeLists.txt && \
make && \
cp lib/*.a /usr/lib

WORKDIR /app
COPY . .

CMD ["make", "test"]