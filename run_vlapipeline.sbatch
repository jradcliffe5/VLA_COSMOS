#!/bin/bash
#SBATCH -N 1-1
#SBATCH -n 24
#SBATCH -J VLApipe6
#SBATCH -m cyclic
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=jack.f.radcliffe@gmail.com
#SBATCH -o logs/vlapipeline_19A.sh.stdout.log
#SBATCH -e logs/vlapipeline_19A.sh.stderr.log
#SBATCH --partition=HighMem,Main
#SBATCH --mem=150G
#SBATCH --time=3-00
#Run the application:
a=$SLURM_ARRAY_TASK_ID

declare -a array
array=("20B-370.sb38958506.eb39325926.59266.30147228009" "20B-370.sb38958591.eb39315232.59263.141884247685" "20B-370.sb38958591.eb39305858.59260.21852908564" "20B-370.sb38958591.eb39324759.59266.125764247685" "20B-370.sb38958673.eb39306683.59261.30979680555" "20B-370.sb38958673.eb39330192.59268.317064849536" "20B-370.sb38958673.eb39344493.59269.31265532407")
#array=("19A-370.sb36900697.eb37390049.58776.706580949074")
array=("20B-370.sb38958591.eb39315232.59263.141884247685")
path="/idia/projects/vlbi/wide-field_VLBI/ER047/VLA/"
casa="casa-6.6.1-17-pipeline-2024.1.1.22"

for i in ${array[@]}; do
rm -r $i"_calibration"
mkdir $i"_calibration"
cd $i"_calibration"
tar -xvf $path$i"-rawuv.tar.gz" -C .
../$casa"/bin/mpicasa" ../$casa/bin/casa --pipeline --nologger --log2term -c ../casa_pipescript.py $i
rm -r "iono"* "igsg"* "oussid"* *"tbl" *"last" *".g" "finalcalibrators.ms" "flux.csv" *"flagcmds"* *"txt" *"png" "calibrators.ms"* "TempLattice"* "byant"* "byspw"* *".gridwt" *".psf" *".image" *".residual" *".workdirectory"
cd ..
done

#split
#for i in ${array[@]}; do
#cd $i"_calibration"
#rm -r $i"_target.ms"
#../$casa/bin/casa --nologger --log2term -c "split(vis='"$i".ms',outputvis='"$i"_target.ms',field='COSMOS',keepmms=False,keepflags=False)"
#cd ..
#done
