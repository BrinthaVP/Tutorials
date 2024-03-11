# command for alignment
do_one()
{
bwa mem -Y -R '@RG\tID:'${1}'\tLB:'${1}'\tPL:ILLUMINA\tPM:HISEQ\tSM:'${1} /data/users/CS18D017/LVM_Multistrain/Preprocessing/Prefetch_Data_SRA/refseq/NC_000962.3.fasta ${1}_1.fastq.gz ${1}_2.fastq.gz > ${1}.sam
}
export -f do_one

cat "file_name" | parallel -P 1 do_one {}


do_one() { echo ${1}; java -jar ~/LVM_Multistrain/Preprocessing/gatk-4.1.8.0/gatk-package-4.1.8.0-local.jar MarkDuplicatesSpark -I ${1}.sam -M dedup_metrics.txt -O ${1}.bam --create-output-bam-index true --spark-master local[10];  }
