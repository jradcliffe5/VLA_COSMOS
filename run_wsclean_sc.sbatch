#!/bin/bash
#SBATCH -N 1-1
#SBATCH --tasks-per-node 32
#SBATCH -J wsclean_sc
#SBATCH -m cyclic
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=jack.f.radcliffe@gmail.com
#SBATCH -o logs/wsclean_sc_%a.sh.stdout.log
#SBATCH -e logs/wsclean_sc_%a.sh.stderr.log
#SBATCH --partition=Main,HighMem,Devel
#SBATCH --mem=230G
#SBATCH --time=1-00:00:00
#SBATCH --array=0

#Run the application:
a=$SLURM_ARRAY_TASK_ID
declare -a array
array=("20B-370_wsclean")
wsclean_exec="/idia/software/containers/wsclean-v3.6-master-no-cuda-2025-06-18.sif"
sc="2"
field="0"
i=${array[$a]}

if [[ $sc == "0" ]]; then
    data="DATA"
else
    data="CORRECTED_DATA"
fi

singularity exec $wsclean_exec wsclean -field $field -data-column $data -local-rms -name self_cal/$i"_DI_ws_sc"$sc -size 5000 5000 -apply-primary-beam -scale 0.3arcsec -mgain 0.8 -niter 100000 -auto-mask 5 -auto-threshold 1 -multiscale -weight natural -join-channels -channels-out 8 -no-negative -fit-spectral-pol 2 $i"_sc.ms"