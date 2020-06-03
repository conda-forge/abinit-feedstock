#!/bin/bash

./config/scripts/makemake
./configure --prefix=${PREFIX} \
            --with-mpi="yes" --enable-mpi-io="yes" \
            --with-libxc="yes" \
            --with-hdf5="yes" \
            --with-netcdf="yes" \
            --with-netcdf_fortran="yes" \
            CC="mpicc" \
            FC="mpif90" \
            CPP="${CPP}" \
            FFT_LIBS="-L${PREFIX}/lib -lfftw3 -lfftw3f -lfftw3_mpi" \
            CFLAGS="${CFLAGS} -L${PREFIX}/lib -llapack -lblas -lnetcdff -lnetcdf -lhdf5_hl -lhdf5 -lxcf90 -lxc -lfftw3 -lfftw3f -lfftw3_mpi" \
            FFLAGS="${FFLAGS} -L${PREFIX}/lib -llapack -lblas -lnetcdff -lnetcdf -lhdf5_hl -lhdf5 -lxcf90 -lxc -lfftw3 -lfftw3f -lfftw3_mpi" \
            CPPFLAGS="${CPPFLAGS} -L${PREFIX}/lib -llapack -lblas -lnetcdff -lnetcdf -lhdf5_hl -lhdf5 -lxcf90 -lxc -lfftw3 -lfftw3f -lfftw3_mpi" 
make -j${CPU_COUNT}
make check
make install-exec
