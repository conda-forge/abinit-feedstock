#!/bin/bash

./config/scripts/makemake
./configure --prefix=${PREFIX} \
            --enable-mpi="yes" --enable-mpi-io="yes" \
            --enable-netcdf="yes" \
            --with-netcdf-incs="-I${PREFIX}/include" --with-netcdf-libs="-L${PREFIX}/lib -lnetcdff -lnetcdf -lhdf5_hl -lhdf5" \
            IFLAGS="-I${SRC_DIR}/include -I${PREFIX}/finclude" \
            CC="mpicc" \
            FC="mpif90" \
            CPP="${CPP}" \
            CFLAGS="${CFLAGS} -L${PREFIX}/lib -llapack -lblas" \
            FFLAGS="${FFLAGS} -L${PREFIX}/lib -llapack -lblas" \
            CPPFLAGS="${CPPFLAGS} -L${PREFIX}/lib -llapack -lblas" 
make -j${CPU_COUNT}
make check
make install-exec
