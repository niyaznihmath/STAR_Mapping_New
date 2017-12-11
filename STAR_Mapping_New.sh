#!/bin/bash
#SBATCH -A b2014097
#SBATCH -p devcore
#SBATCH -n 2
#SBATCH -t 00:10:00
#SBATCH -J Star-Mappiing
#SBATCH -o /proj/b2014097/nobackup/Niyaz/logs/bash_Star.out
#SBATCH -e /proj/b2014097/nobackup/Niyaz/logs/bash_Star.err

for i1 in *R1_001_val_1.fq.gz; do i2=$(echo $i1| sed 's/R1_001_val_1.fq.gz/R2_001_val_2.fq.gz/');

touch $i1"star.sh"
 
echo '#!/bin/bash -l' >>$i1"star.sh"
echo "#SBATCH -A b2014097" >>$i1"star.sh"
echo "#SBATCH -p core" >>$i1"star.sh"
echo "#SBATCH -n 8" >>$i1"star.sh"
echo "#SBATCH -t 05:00:00" >>$i1"star.sh"
echo "#SBATCH -J star_$i1" >>$i1"star.sh"
echo "#SBATCH --mail-type=FAIL" >>$i1"star.sh"
echo "#SBATCH --mail-user=niyaz.yoosuf@ki.se" >>$i1"star.sh"

echo "cd /proj/b2014097/nobackup/Niyaz/FastQ_files/STAR_Output/" >>$i1"star.sh"
echo "module load bioinfo-tools" >>$i1"star.sh"
echo "module load star/2.5.3a" >>$i1"star.sh"

echo "star --runThreadN 32 --runMode alignReads --readFilesCommand zcat --outFilterMultimapNmax 30 \
--outFilterScoreMinOverLread 0.3 --outFilterMatchNminOverLread 0.3 --outSAMtype BAM SortedByCoordinate \
--twopassMode Basic --outWigType bedGraph --outFileNamePrefix /proj/b2014097/nobackup/Niyaz/FastQ_files/STAR_Output/Mapped_$i1 --outWigStrand Unstranded \
--outSAMstrandField intronMotif --genomeLoad NoSharedMemory --genomeDir /proj/b2014097/nobackup/Niyaz/STAR/New_Genome/STAR-Index/ --quantMode GeneCounts --sjdbGTFfile /proj/b2014097/nobackup/Niyaz/STAR/New_Annotation/gencode.v27.annotation.gtf --readFilesIn /proj/b2014097/nobackup/Niyaz/FastQ_files/All-Samples/First_run/STAR_Trimmed_Reads_To_Process/$i1 /proj/b2014097/nobackup/Niyaz/FastQ_files/All-Samples/First_run/STAR_Trimmed_Reads_To_Process/$i2" >>$i1"star.sh"

done;


##Example

#!/bin/bash -l
#SBATCH -A b2014097
#SBATCH -p core
#SBATCH -n 8
#SBATCH -t 05:00:00
#SBATCH -J star_P3_HC50b_CGATGT_L007_R1_001_val_1.fq.gz
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=niyaz.yoosuf@ki.se
cd /proj/b2014097/nobackup/Niyaz/FastQ_files/STAR_Output/
module load bioinfo-tools
module load star/2.5.3a

star --runThreadN 32 --runMode alignReads --readFilesCommand zcat --outFilterMultimapNmax 30 --outFilterScoreMinOverLread 0.3 --outFilterMatchNminOverLread 0.3 --outSAMtype BAM SortedByCoordinate --twopassMode Basic --outWigType bedGraph --outFileNamePrefix /proj/b2014097/nobackup/Niyaz/FastQ_files/STAR_Output/Mapped_P3_HC50b_CGATGT_L007_R1_001_val_1.fq.gz --outWigStrand Unstranded --outSAMstrandField intronMotif --genomeLoad NoSharedMemory --genomeDir /proj/b2014097/nobackup/Niyaz/STAR/New_Genome/STAR-Index/ --quantMode GeneCounts --sjdbGTFfile /proj/b2014097/nobackup/Niyaz/STAR/New_Annotation/gencode.v27.annotation.gtf --readFilesIn /proj/b2014097/nobackup/Niyaz/FastQ_files/All-Samples/First_run/STAR_Trimmed_Reads_To_Process/P3_HC50b_CGATGT_L007_R1_001_val_1.fq.gz /proj/b2014097/nobackup/Niyaz/FastQ_files/All-Samples/First_run/STAR_Trimmed_Reads_To_Process/P3_HC50b_CGATGT_L007_R2_001_val_2.fq.gz