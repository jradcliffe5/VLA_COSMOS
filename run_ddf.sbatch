#!/bin/bash
#SBATCH -N 1-1
#SBATCH --tasks-per-node 32
#SBATCH -J ddf_sc
#SBATCH -m cyclic
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=jack.f.radcliffe@gmail.com
#SBATCH -o logs/image_ddf_%a.sh.stdout.log
#SBATCH -e logs/image_ddf_%a.sh.stderr.log
#SBATCH --partition=Main,HighMem,GPU,Devel
#SBATCH --mem=230G
#SBATCH --time=1-00:00:00
#SBATCH --array=0

#Run the application:
a=$SLURM_ARRAY_TASK_ID
declare -a array

array=("20B-370_ddf")
ddf_exec="/idia/software/containers/DDFacet.simg"
sc="1"
field="0"


i=${array[$a]}
if [[ $sc == "0" ]]; then
    data="DATA"
else
    data="CORRECTED_DATA"
fi

singularity exec $ddf_exec DDF.py --Output-Name=self_cal/$i"_DI_sc"$sc --Cache-Reset=1 --Weight-ColName WEIGHT --Data-MS $i"_sc.ms//D*//F"$field --Deconv-PeakFactor 0.001000 --Data-ColName $data --Parallel-NCPU=32 --Deconv-CycleFactor=0 --Deconv-MaxMajorIter=3 --Deconv-Mode SSD --Weight-Mode Natural --Image-NPix=5000 --Predict-ColName=MODEL_DATA --CF-Nw 100 --Output-Also onNeds --Image-Cell 0.3 --Facets-NFacets=40 --SSDClean-NEnlargeData 0 --Freq-NDegridBand 1 --Beam-NBand 1 --Deconv-RMSFactor=3.000000 --Data-Sort 1 --Cache-Dir=. --Freq-NBand=1 --Mask-Auto=1 --Mask-SigTh=5.00

rm -r *".ddfcache"