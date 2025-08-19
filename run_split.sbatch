#!/bin/bash
#SBATCH -N 1-1
#SBATCH --tasks-per-node 1
#SBATCH -J split
#SBATCH -m cyclic
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=jack.f.radcliffe@gmail.com
#SBATCH -o logs/split_%a.sh.stdout.log
#SBATCH -e logs/split_%a.sh.stderr.log
#SBATCH --partition=Main,HighMem
#SBATCH --mem=50G
#SBATCH --time=12:00:00
#SBATCH --array=0-6

#Run the application:
a=$SLURM_ARRAY_TASK_ID
declare -a array
array=("20B-370.sb38958506.eb39325926.59266.30147228009" "20B-370.sb38958591.eb39305858.59260.21852908564" "20B-370.sb38958591.eb39315232.59263.141884247685" "20B-370.sb38958591.eb39324759.59266.125764247685" "20B-370.sb38958673.eb39306683.59261.30979680555" "20B-370.sb38958673.eb39330192.59268.317064849536" "20B-370.sb38958673.eb39344493.59269.31265532407")
#array=("20B-370.sb38958591.eb39315232.59263.141884247685")

casa_exec="casa-6.6.1-17-pipeline-2024.1.1.22/bin/casa --nologger --log2term -c "
mpicasa_exec="casa-6.6.1-17-pipeline-2024.1.1.22/bin/mpicasa"

i=${array[$a]}

$casa_exec split_ms.py $i False