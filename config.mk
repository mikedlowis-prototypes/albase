export PATH := $(PWD)/musl-cross-make/stage2/bin:$(PATH)
CC = x86_64-linux-musl-gcc
LD = $(CC)
AR = x86_64-linux-musl-ar
