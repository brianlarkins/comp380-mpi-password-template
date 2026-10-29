#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/time.h>
#include <mpi.h>
#include <openssl/des.h>

/* DES_crypt is deprecated in OpenSSL 3 but still works; this keeps -Werror
   from stopping your build once you start calling it. */
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"


int main(int argc, char **argv) {
  double start, end;
  int rank, size;

  MPI_Init(&argc, &argv);
  MPI_Comm_rank(MPI_COMM_WORLD, &rank);
  MPI_Comm_size(MPI_COMM_WORLD, &size);

  if (rank==0)
    printf("starting run with %d processes\n", size);

  start = MPI_Wtime();
  usleep(10000);
  end = MPI_Wtime();

  if (rank==0) {
    printf("elapsed time: %7.4f s\n", end-start);
  }

  MPI_Finalize();
}
