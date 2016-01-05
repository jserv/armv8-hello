Hello World for bare metal ARMv8 using QEMU

Prerequisites
-------------
- Install [Linaro toolchain](http://www.linaro.org/downloads/) for Aarch64 little-endian
```
sudo apt-get install gcc-aarch64-linux-gnu
```
- Install recent QEMU with Aarch64 target
```
sudo apt-get install qemu-system-arm
```

Building and Verification
-------------------------
* Changes the current working directory to the specified one and then
```
make
make qemu
```

Licensing
---------
`armv8-hello` is freely redistributable under the two-clause BSD License.
Use of this source code is governed by a BSD-style license that can be found
in the `LICENSE` file.
