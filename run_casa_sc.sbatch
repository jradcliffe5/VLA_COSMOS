#!/bin/bash
#SBATCH -N 1-1
#SBATCH --tasks-per-node 4
#SBATCH -J ddcal
#SBATCH -m cyclic
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=jack.f.radcliffe@gmail.com
#SBATCH -o logs/ddcal_%a.sh.stdout.log
#SBATCH -e logs/ddcal_%a.sh.stderr.log
#SBATCH --partition=Main,HighMem
#SBATCH --mem=50G
#SBATCH --time=04:00:00
#SBATCH --array=0

#Run the application:
a=$SLURM_ARRAY_TASK_ID
declare -a array

dc="ws"
array=("20B-370_"$dc)
casa_exec="casa-6.6.1-17-pipeline-2024.1.1.22/bin/casa --nologger --log2term -c "
mpicasa_exec="casa-6.6.1-17-pipeline-2024.1.1.22/bin/mpicasa"

sc="6"
field="0"
type="p"
i=${array[$a]}

$mpicasa_exec $casa_exec casa_selfcal.py $i"_sc.ms" "20B_all_"$dc"_sc"$sc"."$type $type inf "" "20B_all_"$dc"_sc0.p" "20B_all_"$dc"_sc1.p" "20B_all_"$dc"_sc2.ap" "20B_all_"$dc"_sc3.ap" "20B_all_"$dc"_sc4.ap" "20B_all_"$dc"_sc5.ap"