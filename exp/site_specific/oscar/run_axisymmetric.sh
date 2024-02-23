#!/bin/bash
#**********************
# Example batch script for running isca's held_suarez test
# case on Oscar
#**********************
# SLURM JOB INFORMATION
#**********************
# Walltime requested for job (24 hrs)
#SBATCH -t 24:00:00

# Request use of 8 cores and 8GB of memory per core on 1 node
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=8G

# Define Oscar partition to use
#SBATCH -p batch

# Job Name
#SBATCH -J isca_axisymmetric

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
module load hpcx-mpi/4.1.5rc2s-yflad4v
module load netcdf-fortran-mpi/4.6.0-ciymq6f

# set environment variables (change to suit your needs)
export GFDL_BASE=/oscar/home/$USER/data/$USER/isca.venv/Isca
export GFDL_ENV=oscar
export GFDL_WORK=/oscar/scratch/$USER/isca/work
export GFDL_DATA=/oscar/scratch/$USER/isca/data
# activate environment
source $GFDL_BASE/../bin/activate
# run the case
cd $GFDL_BASE/exp/test_cases/axisymmetric
python axisymmetric_test_case.py 
