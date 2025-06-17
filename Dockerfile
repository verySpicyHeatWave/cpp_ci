# BCOBB: Switch to alpine and see if I can optimize the build by removing unnecessary apt installs.
# Like, maybe I could run the gtest cmake steps in the same layer as the installs and then uninstall cmake since I use a make system.
# See if any of my other apt installs are necessary to have in the final image, as well.

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