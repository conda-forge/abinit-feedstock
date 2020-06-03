#!/bin/bash

# MPI settings 
if [[ "$mpi" == "openmpi" ]]; then
    export OMPI_MCA_plm=isolated
    export OMPI_MCA_rmaps_base_oversubscribe=yes
    export OMPI_MCA_btl_vader_single_copy_mechanism=none
    export CFLAGS="${CFLAGS} -fopenmp"
    export CPPFLAGS="${CPPFLAGS} -fopenmp"
    export FFLAGS="${FFLAGS} -fopenmp"
    export LDFLAGS="${LDFLAGS} -fopenmp"
    export CC="mpicc"
    export FC="mpif90"
    enable_mpi="yes"
elif [[ "$mpi" == "mpich" ]]; then
    export CC="mpicc"
    export FC="mpif90"
    enable_mpi="yes"
else
    enable_mpi="no"
fi

./config/scripts/makemake
./configure --prefix=${PREFIX} \
            --with-mpi=${enable_mpi} --enable-mpi-io=${enable_mpi} \
            --with-libxc="yes" \
            --with-hdf5="yes" \
            --with-netcdf="yes" \
            --with-netcdf_fortran="yes" \
            CC=${CC} \
            FC=${FC} \
            CPP="${CPP}" \
            CFLAGS="${CFLAGS} -L${PREFIX}/lib -llapack -lblas -lnetcdff -lnetcdf -lhdf5_hl -lhdf5 -lxcf90 -lxc" \
            FFLAGS="${FFLAGS} -L${PREFIX}/lib -llapack -lblas -lnetcdff -lnetcdf -lhdf5_hl -lhdf5 -lxcf90 -lxc" \
            CPPFLAGS="${CPPFLAGS} -L${PREFIX}/lib -llapack -lblas -lnetcdff -lnetcdf -lhdf5_hl -lhdf5 -lxcf90 -lxc" 
make -j${CPU_COUNT}
make check
make install-exec
