#!/bin/bash
#SBATCH -N 1-1
#SBATCH --tasks-per-node 32
#SBATCH -J image_epoch
#SBATCH -m cyclic
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=jack.f.radcliffe@gmail.com
#SBATCH -o logs/image_epoch_%a.sh.stdout.log
#SBATCH -e logs/image_epoch_%a.sh.stderr.log
#SBATCH --partition=Main,HighMem
#SBATCH --mem=230G
#SBATCH --time=1-00:00:00
#SBATCH --array=0

#Run the application:
a=$SLURM_ARRAY_TASK_ID
declare -a array
array=("20B-370.sb38958506.eb39325926.59266.30147228009" "20B-370.sb38958591.eb39305858.59260.21852908564" "20B-370.sb38958591.eb39315232.59263.141884247685" "20B-370.sb38958591.eb39324759.59266.125764247685" "20B-370.sb38958673.eb39306683.59261.30979680555" "20B-370.sb38958673.eb39330192.59268.317064849536" "20B-370.sb38958673.eb39344493.59269.31265532407")
array=("20B-370.sb38958591.eb39315232.59263.141884247685")

wsclean_exec="/idia/software/containers/wsclean-v3.6-master-no-cuda-2025-06-18.sif"
sc="0"
field="0"
i=${array[$a]}
singularity exec $wsclean_exec  wsclean -field $field -name "epoch_images/"$i"_IM_sc"$sc -size 5000 5000 -scale 0.3arcsec -mgain 0.8 -niter 10000 -auto-mask 5 -auto-threshold 1 -weight natural -join-channels -channels-out 8 -no-negative -fit-spectral-pol 2 -no-update-model-required $i"_sc.ms"