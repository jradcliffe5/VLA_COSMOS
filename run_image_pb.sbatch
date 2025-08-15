#!/bin/bash
#SBATCH -N 1-1
#SBATCH --tasks-per-node 32
#SBATCH -J image_epoch
#SBATCH -m cyclic
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=jack.f.radcliffe@gmail.com
#SBATCH -o logs/image_sc_%a.sh.stdout.log
#SBATCH -e logs/image_sc_%a.sh.stderr.log
#SBATCH --partition=HighMem
#SBATCH --mem=400G
#SBATCH --time=1-00:00:00
#SBATCH --array=0

#Run the application:
a=$SLURM_ARRAY_TASK_ID
declare -a array
array=("19A-370.sb36900697.eb37390049.58776.706580949074" "20B-370.sb38958506.eb39325926.59266.30147228009" "20B-370.sb38958591.eb39305858.59260.21852908564" "20B-370.sb38958591.eb39315232.59263.141884247685" "20B-370.sb38958591.eb39324759.59266.125764247685" "20B-370.sb38958673.eb39306683.59261.30979680555" "20B-370.sb38958673.eb39330192.59268.317064849536" "20B-370.sb38958673.eb39344493.59269.31265532407")
array=("19A-370.sb36900697.eb37390049.58776.706580949074")
wsclean_exec="/idia/software/containers/wsclean-v3.6-master-no-cuda-2025-06-18.sif"
sc="0"
field="0"
i=${array[$a]}
singularity exec $wsclean_exec  wsclean -field $field -local-rms -name "epoch_images/"$i"_IM2_sc"$sc -size 5000 5000 -apply-primary-beam -scale 0.3arcsec -mgain 0.8 -niter 100000 -auto-mask 5 -auto-threshold 0.5 -multiscale -weight natural -join-channels -channels-out 8 -no-negative -fit-spectral-pol 2 -dd-psf-grid 3 3 -parallel-deconvolution 1500 -no-update-model-required $i"_calibration/"$i"_target_sc.ms"