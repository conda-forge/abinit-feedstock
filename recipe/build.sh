#!/bin/bash
export OMPI_MCA_plm=isolated
export OMPI_MCA_btl_vader_single_copy_mechanism=none
export OMPI_MCA_rmaps_base_oversubscribe=yes

./config/scripts/makemake
./configure --prefix=${PREFIX} \
            --enable-mpi="yes" --with-mpi-level=2 --enable-mpi-io="yes" \
            --with-trio-flavor=netcdf \
            --with-netcdf-incs="-I${PREFIX}/include" --with-netcdf-libs="-L${PREFIX}/lib -lnetcdff -lnetcdf -lhdf5_hl -lhdf5" \
            IFLAGS="-I${SRC_DIR}/include -I${PREFIX}/finclude" \
            CC="mpicc" \
            FC="mpif90" \
            CPP="${CPP}" \
            CFLAGS="${CFLAGS} -L${PREFIX}/lib -llapack -lblas -lnetcdff -lnetcdf -lhdf5_hl -lhdf5" \
            FFLAGS="${FFLAGS} -L${PREFIX}/lib -llapack -lblas -lnetcdff -lnetcdf -lhdf5_hl -lhdf5" \
            CPPFLAGS="${CPPFLAGS} -L${PREFIX}/lib -llapack -lblas -lnetcdff -lnetcdf -lhdf5_hl -lhdf5" 
make -j${CPU_COUNT}
make check
make install-exec
