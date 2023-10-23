#!/bin/bash
#**********************
# Example batch script for running isca's held_suarez test
# case on Oscar
#**********************
# SLURM JOB INFORMATION
#**********************
# Walltime requested for job (2 hrs)
#SBATCH -t 2:00:00

# Request use of 16 cores and 8GB of memory per core on 1 node
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=16
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=8G

# Define Oscar partition to use
#SBATCH -p batch

# Job Name
#SBATCH -J isca_held_saurez 

# SLURM output (*.out) file name
# Use '%x' for Job Name,'%A' for array-job ID, '%j' for job ID and '%a' for task ID`
#SBATCH -o %x-%j.out

# Notify user if job fails or ends (uncomment and add your email address to use)
##SBATCH --mail-user=your_name@brown.edu
##SBATCH --mail-type=FAIL,END

#********************
# COMMANDS TO EXECUTE
#********************
# set stack size to unlimited
ulimit -s unlimited
# load the required modules
module load netcdf/4.9.0_gcc_10.2_hdf5_1.12.2_slurm22
module load hdf5/1.12.2_openmpi_4.0.7_gcc_10.2_slurm22
module load mpi/openmpi_4.0.7_gcc_10.2_slurm22
module load git/2.29.2
module load python/3.9.0
module load gcc/10.2
# set environment variables (change to suit your needs)
export GFDL_BASE=/oscar/home/$USER/data/$USER/isca.venv/Isca
export GFDL_ENV=oscar
export GFDL_WORK=/oscar/scratch/$USER/isca/work
export GFDL_DATA=/oscar/scratch/$USER/isca/data
# activate environment
source $GFDL_BASE/../bin/activate
# run the case
cd $GFDL_BASE/exp/test_cases/held_suarez
python held_suarez_test_case.py
