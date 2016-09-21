# ALBase

This is an experimental Linux distro with a focus on simplicity and efficiency.
The goals of the project are as follows:

* No dynamically linked executables in the base
* Link against musl instead of glibc
* No systemd or any of it's components
* No DBus or any of it's components
* As little GNU code as possible

## Building

    # Optional: build the musl-based cross compiler and use that for the build
    ./bootstrap.sh
    make stage1
