#!/usr/bin/env python
import subprocess


pspgth = """Goedecker-Teter-Hutter  Wed May  8 14:27:44 EDT 1996
1   1   960508                     zatom,zion,pspdat
2   1   0    0    2001    0.       pspcod,pspxc,lmax,lloc,mmax,r2well
0.2000000 -4.0663326  0.6778322 0 0     rloc, c1, c2, c3, c4
0 0 0                              rs, h1s, h2s
0 0                                rp, h1p
  1.36 .2   0.0                    rcutoff, rloc
"""

tbase1 = """# H2 molecule in a big box
#
# In this input file, the location of the information on this or that line
# is not important : a keyword is located by the parser, and the related
# information should follow. 
# The "#" symbol indicates the beginning of a comment : the remaining
# of the line will be skipped.

#Definition of the unit cell
acell 10 10 10    # The keyword "acell" refers to the
                  # lengths of the primitive vectors (in Bohr)
#rprim 1 0 0  0 1 0  0 0 1 # This line, defining orthogonal primitive vectors,
                           # is commented, because it is precisely the default value of rprim

#Definition of the atom types
ntypat 1          # There is only one type of atom
znucl 1           # The keyword "znucl" refers to the atomic number of the 
                  # possible type(s) of atom. The pseudopotential(s) 
                  # mentioned in the "files" file must correspond
                  # to the type(s) of atom. Here, the only type is Hydrogen.
                         

#Definition of the atoms
natom 2           # There are two atoms
typat 1 1         # They both are of type 1, that is, Hydrogen
xcart             # This keyword indicates that the location of the atoms
                  # will follow, one triplet of number for each atom
  -0.7 0.0 0.0    # Triplet giving the cartesian coordinates of atom 1, in Bohr
   0.7 0.0 0.0    # Triplet giving the cartesian coordinates of atom 2, in Bohr

#Definition of the planewave basis set
ecut 10.0         # Maximal plane-wave kinetic energy cut-off, in Hartree

#Definition of the k-point grid
kptopt 0          # Enter the k points manually 
nkpt 1            # Only one k point is needed for isolated system,
                  # taken by default to be 0.0 0.0 0.0

#Definition of the SCF procedure
nstep 10          # Maximal number of SCF cycles
toldfe 1.0d-6     # Will stop when, twice in a row, the difference 
                  # between two consecutive evaluations of total energy 
                  # differ by less than toldfe (in Hartree) 
                  # This value is way too large for most realistic studies of materials
diemac 2.0        # Although this is not mandatory, it is worth to
                  # precondition the SCF cycle. The model dielectric
                  # function used as the standard preconditioner
                  # is described in the "dielng" input variable section.
                  # Here, we follow the prescriptions for molecules 
                  # in a big box


#%%<BEGIN TEST_INFO>
#%% [setup]
#%% executable = abinit
#%% [files]
#%% files_to_test = 
#%%   tbase1_1.out, tolnlines=  0, tolabs=  0.000e+00, tolrel=  0.000e+00
#%% psp_files =  01h.pspgth
#%% [paral_info]
#%% max_nprocs = 1
#%% [extra_info]
#%% authors = Unknown
#%% keywords = 
#%% description = H2 molecule in a big box
#%%<END TEST_INFO>
"""

files = """tbase1_1.in
tbase1_1.out
tbase1_1i
tbase1_1o
tbase1_1
01h.pspgth
"""


if __name__ == "__main__":
    with open('tbase1_1.files', 'w') as f:
        f.writelines(files)
    with open('tbase1_1.in', 'w') as f:
        f.writelines(tbase1)
    with open('01h.pspgth', 'w') as f:
        f.writelines(pspgth)
    subprocess.check_output("abinit < tbase1_1.files > tbase1_1.log", shell=True)
