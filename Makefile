ifndef CC
	CC = gcc
endif

ifdef DEBUG
	OPT = -DDEBUG=1 --debug -g
else
	OPT = -O3
endif

CFLAGS = -Wall -Wextra -Wc++-compat -I.

all: libbitarr.a dev examples

libbitarr.a: lookup3.o bit_array.o
	ar -csru libbitarr.a bit_array.o lookup3.o

%.o: %.c
	$(CC) $(OPT) $(CFLAGS) -c $< -o $@

dev: libbitarr.a
	cd dev; make

examples: libbitarr.a
	cd examples; make

clean:
	rm -rf libbitarr.a *.o *.dSYM *.greg
	cd dev; make clean
	cd examples; make clean

# Comment this line out to keep .o files
.INTERMEDIATE: $(OBJS)
.PHONY: all clean dev examples
