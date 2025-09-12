#!/bin/bash
#SBATCH -N 1-1
#SBATCH --tasks-per-node 1
#SBATCH -J concat
#SBATCH -m cyclic
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=jack.f.radcliffe@gmail.com
#SBATCH -o logs/concat.sh.stdout.log
#SBATCH -e logs/concat.sh.stderr.log
#SBATCH --partition=Main,HighMem
#SBATCH --mem=150G
#SBATCH --time=12:00:00

#Run the application:
a=$SLURM_ARRAY_TASK_ID

casa_exec="casa-6.6.1-17-pipeline-2024.1.1.22/bin/casa --nologger --log2term -c "
mpicasa_exec="casa-6.6.1-17-pipeline-2024.1.1.22/bin/mpicasa"

$casa_exec concatenate_ms.py 20B True
