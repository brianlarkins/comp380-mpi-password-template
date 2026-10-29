# COMP 380 Lab 4 skeleton.
#
# On lotus, load the toolchain first:
#     module unload openshmem ucx
#     module load openmpi5 OpenSSL/3
# OpenSSL/3 puts openssl/des.h on CPATH and libcrypto on LIBRARY_PATH, so the
# plain -lcrypto below resolves with no explicit -I/-L.

CC=gcc
MPICC=mpicc
CFLAGS=-Wno-stringop-overflow -Wno-unused-parameter -Wno-format-overflow -Wall -Wextra -Werror -g -O3 -msse4.2

all: lab4 crypter

# your parallel solution
lab4: lab4.c
	$(MPICC) $(CFLAGS) -rdynamic -o $@ lab4.c -lcrypto -lm

# tool for generating password hashes and encrypted messages
crypter: crypter.c
	$(CC) $(CFLAGS) -o $@ crypter.c -lcrypto

clean:
	rm -f *.o lab4 crypter
