#!/bin/bash
#SBATCH -N 1-1
#SBATCH --tasks-per-node 32
#SBATCH -J wsclean_final
#SBATCH -m cyclic
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=jack.f.radcliffe@gmail.com
#SBATCH -o logs/wsclean_final_%a.sh.stdout.log
#SBATCH -e logs/wsclean_final_%a.sh.stderr.log
#SBATCH --partition=GPU
#SBATCH --mem=230G
#SBATCH --time=1-00:00:00
#SBATCH --array=0

#Run the application:
a=$SLURM_ARRAY_TASK_ID
wsclean_exec="/idia/software/containers/wsclean-v3.5-idg-everybeam.sif "
field="0"


singularity exec --nv $wsclean_exec wsclean -data-column DATA -name COSMOS_XS_L -size 6000 6000 -scale 0.3arcsec -mgain 0.6 -niter 1000000 -auto-mask 5 -auto-threshold 0.5 -weight natural -join-channels -channels-out 8 -fit-spectral-pol 3 -gridder idg -idg-mode hybrid -grid-with-beam COSMOS_XS_L-band.ms