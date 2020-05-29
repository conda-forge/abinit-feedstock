#!/bin/bash

./config/scripts/makemake
./configure --prefix=${PREFIX} \
            --enable-mpi="yes" --enable-mpi-io="yes" \
            --with-trio-flavor=netcdf \
            --with-dft-flavor="libxc" \
            --with-libxc-incs="-I${PREFIX}/include" --with-libxc-libs="-L${PREFIX}/lib -lxcf90 -lxc" \
            --with-netcdf-incs="-I${PREFIX}/include" --with-netcdf-libs="-L${PREFIX}/lib -lnetcdff -lnetcdf -lhdf5_hl -lhdf5" \
            IFLAGS="-I${SRC_DIR}/include -I${PREFIX}/finclude" \
            CC="mpicc" \
            FC="mpif90" \
            CPP="${CPP}" \
            CFLAGS="${CFLAGS} -L${PREFIX}/lib -llapack -lblas -lxcf90 -lxc" \
            FFLAGS="${FFLAGS} -L${PREFIX}/lib -llapack -lblas -lxcf90 -lxc" \
            CPPFLAGS="${CPPFLAGS} -L${PREFIX}/lib -llapack -lblas -lxcf90 -lxc" 
make -j${CPU_COUNT}
make check
make install-exec
