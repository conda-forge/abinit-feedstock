#!/bin/bash

./config/scripts/makemake
./configure --prefix=${PREFIX} \
            --with-mpi="yes" --enable-mpi-io="yes" \
            --with-libxc="yes" \
            --with-hdf5="yes" \
            --with-fftw3="yes" \
            --with-netcdf="yes" \
            --with-netcdf_fortran="yes" \
            --with-fft-flavor="fftw3" \
            CC="mpicc" \
            FC="mpif90" \
            CPP="${CPP}" \
            IFLAGS="-I${SRC_DIR}/include -I${PREFIX}/finclude" \
            FFT_CPPFLAGS="${CPPFLAGS} -L${PREFIX}/lib -lfftw3 -lfftw3f -lfftw3f_mpi -lfftw3_mpi -lfftw3_threads -lfftw3_omp -lfftw3f_threads -lfftw3f_omp" \
            FFT_FCFLAGS="${FFLAGS} -L${PREFIX}/lib -lfftw3 -lfftw3f -lfftw3f_mpi -lfftw3_mpi -lfftw3_threads -lfftw3_omp -lfftw3f_threads -lfftw3f_omp" \
            FFT_LIBS="-L${PREFIX}/lib -lfftw3 -lfftw3f -lfftw3f_mpi -lfftw3_mpi -lfftw3_threads -lfftw3_omp -lfftw3f_threads -lfftw3f_omp" \
            CFLAGS="${CFLAGS} -L${PREFIX}/lib -llapack -lblas -lnetcdff -lnetcdf -lhdf5_hl -lhdf5 -lxcf90 -lxc -lfftw3 -lfftw3f -lfftw3f_mpi -lfftw3_mpi -lfftw3_threads -lfftw3_omp -lfftw3f_threads -lfftw3f_omp" \
            FFLAGS="${FFLAGS} -L${PREFIX}/lib -llapack -lblas -lnetcdff -lnetcdf -lhdf5_hl -lhdf5 -lxcf90 -lxc -lfftw3 -lfftw3f -lfftw3f_mpi -lfftw3_mpi -lfftw3_threads -lfftw3_omp -lfftw3f_threads -lfftw3f_omp" \
            CPPFLAGS="${CPPFLAGS} -L${PREFIX}/lib -llapack -lblas -lnetcdff -lnetcdf -lhdf5_hl -lhdf5 -lxcf90 -lxc -lfftw3 -lfftw3f -lfftw3f_mpi -lfftw3_mpi -lfftw3_threads -lfftw3_omp -lfftw3f_threads -lfftw3f_omp" 
make -j${CPU_COUNT}
make check
make install-exec
