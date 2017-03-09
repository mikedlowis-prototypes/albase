# ALBase

This is an experimental Linux distro with a focus on simplicity and efficiency.
The goals of the project are as follows:

* No dynamically linked executables in the base
* Link against musl instead of glibc
* No systemd or any related components
* No DBus or any related components
* As little GNU code as possible

## Building

    ./bootstrap.sh
    make all
    ./buildiso.sh