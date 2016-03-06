Hello World for bare metal ARMv8 using QEMU

Prerequisites
-------------
- Ubuntu 15.04
- Install [Linaro toolchain](http://www.linaro.org/downloads/) for Aarch64 little-endian
```
sudo apt-get install gcc-aarch64-linux-gnu
```
- Install recent QEMU with Aarch64 target

Step 1:
```
$ cd armv8-hello
$ git clone https://github.com/qemu/qemu.git
```
modify code in a file(qemu/hw/arm/virt.c). The result using diff is as the following:
```
*** a/virt.c	2016-03-06 11:02:49.987615129 -0800
--- b/virt.c	2016-03-06 11:03:03.509277000 -0800
***************
*** 1210,1216 ****
  
              /* Secondary CPUs start in PSCI powered-down state */
              if (n > 0) {
!                 object_property_set_bool(cpuobj, true,
                                           "start-powered-off", NULL);
              }
          }
--- 1210,1216 ----
  
              /* Secondary CPUs start in PSCI powered-down state */
              if (n > 0) {
!                 object_property_set_bool(cpuobj, false,
                                           "start-powered-off", NULL);
              }
          }


```

Note that:
Qemu develops design secondary CPUs in PSCI power-down state depending on PSCI firmare API. Howerver, ARM develops do not support any instructions for secondary CPUs from the power-down state to the power-on state. Therefore, we modify code as above.

Step 2:
```
$ sudo apt-get build-dep qemu
$ ./configure --target-list=aarch64-softmmu
$ make
```

Building and Verification
-------------------------
* Changes the current working directory to the specified one and then
```
$ export PATH=./qemu/aarch64-softmmu/:$PATH
$ make
$ make qemu
```

Licensing
---------
`armv8-hello` is freely redistributable under the two-clause BSD License.
Use of this source code is governed by a BSD-style license that can be found
in the `LICENSE` file.
