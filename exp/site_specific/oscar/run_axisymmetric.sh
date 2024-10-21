#!/bin/bash
#**********************
# Example batch script for running isca's axisymmetric test
# case on Oscar
#**********************
# SLURM JOB INFORMATION
#**********************
# Walltime requested for job (24 hrs)
#SBATCH -t 24:00:00

# Request use of 8 cores and 4GB of memory per core on 1 node
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4G

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
module load netcdf-mpi/4.9.2-og6h2km

# set environment variables (change to suit your needs)
export GFDL_BASE=/oscar/home/$USER/data/$USER/isca.venv/Isca
export GFDL_ENV=oscar
export GFDL_WORK=/sss/jobtmp/$USER/isca/work
export GFDL_DATA=/sss/jobtmp/$USER/isca/data
# activate environment
source $GFDL_BASE/../bin/activate
# run the case
cd $GFDL_BASE/exp/test_cases/axisymmetric
python axisymmetric_test_case.py 
