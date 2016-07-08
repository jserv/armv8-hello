Hello World for bare metal ARMv8 using QEMU

Prerequisites
-------------
- Ubuntu 15.04
- Install [Linaro toolchain](http://www.linaro.org/downloads/) for Aarch64 little-endian
```
sudo apt-get install gcc-aarch64-linux-gnu
```
- Install QEMU stable-2.5 with Aarch64 target

```
$ cd armv8-hello
$ git clone https://github.com/qemu/qemu.git
$ cd qemu
$ git checkout -b origin/stable-2.5 
$ patch< ../patch/qemu.patch ./hw/arm/virt.c
$ ./configure --prefix=/usr/local --target-list=aarch64-softmmu
$ make -j2
$ sudo make install
```
Note that: Qemu develops design secondary CPUs in PSCI power-down state depending on PSCI firmare API. Howerver, ARM develops do not support any instructions in GICv2 for secondary CPUs from the power-down state to the power-on state. Therefore, we patch code as above.

Building and Verification
-------------------------
* Changes the current working directory to the specified one and then
```
$ export PATH=./qemu/aarch64-softmmu/:$PATH
$ make
$ make qemu
```
and you sould see this

```
Press Ctrl-A and then X to exit QEMU

qemu-system-aarch64 -machine virt,gic-version=2 -cpu cortex-a57 \
                    -smp 4 -m 4096 \
		    -nographic -serial mon:stdio \
                    -kernel kernel.elf
boot cpu: Hello
secondary cpus: Hello
secondary cpus: Hello
secondary cpus: Hello
```

Licensing
---------
`armv8-hello` is freely redistributable under the two-clause BSD License.
Use of this source code is governed by a BSD-style license that can be found
in the `LICENSE` file.
