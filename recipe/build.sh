#!/bin/bash

./config/scripts/makemake
./configure --prefix=${PREFIX} \
            --enable-mpi="yes" --enable-mpi-io="yes" \
            --with-trio-flavor=netcdf \
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
