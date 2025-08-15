#!/bin/bash
#SBATCH -N 1-1
#SBATCH --tasks-per-node 32
#SBATCH -J ddcal
#SBATCH -m cyclic
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=jack.f.radcliffe@gmail.com
#SBATCH -o logs/ddcal_%a.sh.stdout.log
#SBATCH -e logs/ddcal_%a.sh.stderr.log
#SBATCH --partition=Main,HighMem
#SBATCH --mem=230G
#SBATCH --time=1-00:00:00
#SBATCH --array=0

#Run the application:
a=$SLURM_ARRAY_TASK_ID
declare -a array
array=("19A-370.sb36900697.eb37390049.58776.706580949074" "20B-370.sb38958506.eb39325926.59266.30147228009" "20B-370.sb38958591.eb39305858.59260.21852908564" "20B-370.sb38958591.eb39315232.59263.141884247685" "20B-370.sb38958591.eb39324759.59266.125764247685" "20B-370.sb38958673.eb39306683.59261.30979680555" "20B-370.sb38958673.eb39330192.59268.317064849536" "20B-370.sb38958673.eb39344493.59269.31265532407")
array=("19A-370.sb36900697.eb37390049.58776.706580949074")
kms_exec="/idia/software/containers/killMS_v.3.2.2-2025-07-15.sif"
sc="0"
field="0"
i=${array[$a]}

singularity exec $kms_exec kMS.py --MSName $i"_calibration/"$i"_sc.ms" --WeightInCol=WEIGHT  --BeamModel=None --SolverType CohJones --PolMode Scalar --BaseImageName epoch_images/$i"_DI"  --NCPU 32 --OutSolsName 19A_CohJ --NChanSols 1 --InCol DATA --OutCol CORRECTED_DATA --Weighting Natural --NodesFile "epoch_images/"$i"_DI.npy.ClusterCat.npy" --MaxFacetSize 1.5