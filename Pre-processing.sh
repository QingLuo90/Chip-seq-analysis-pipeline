

#!/bin/bash/

#comebine command find and parallel to apply parallel compuation;
#change --jobs or -j of parallel to adjust the maximum number of running jobs.

#1 download SRA files and convert into fastq files
##If the library is paired-end, need to add --split-files to fastq-dump
sort -u SRRList | parallel --jobs 6 "fastq-dump --origfmt --gzip {}"

#2 trim adapters, run fastqc for quality control; the code is previously written with perl script in pre-process.pl
perl pre-process.pl;


#3 mapping the filtered reads to reference genonme, use -1 *.fq.gz -2 *.fq.gz if the library is paired-end
cd trim;

find -name "*fq.gz" \
| parallel -j 7 bowtie2 -p 12 -x ~/mm10/mm10 -X 2000 \
--no-unal -U {} -S ../bam/{}.sam;

cd ..;

#4 Convert sam files to bam
find ./bam/ -name "*.sam" | parallel -j 8 samtools view -Shb -q 20 -T ~/mm10/mm10.fa {} ">" {}.bam;

#5 sort the bam files
find ./bam/ -name "*.sam.bam" | parallel -j 8 samtools sort -m 16G -@ 8 {} {}_sorted;

#6 remove duplicates
find ./bam/ -name "*sort*" | parallel -j 8 java -jar ~/software/picard.jar MarkDuplicates M=dupstats REMOVE_DUPLICATES=TRUE I={} o={}_rd.bam;

#7 remove mitochondrial mapping reads
find ./bam/ -name "*rd.bam" | parallel -j 8 samtools index {};
find ./bam/ -name "*rd.bam" | parallel -j 8 samtools view -hb {} chr1 chr2 chr3 chr4 chr5 chr6 chr7 chr8 chr9 chr10 chr11 chr12 chr13 chr14 chr15 chr16 chr17 chr18 chr19 chrX chrY ">" {}_rm.bam

#8 build index in case downstream analysis need them
find ./bam/ -name "rm.bam" | \
parallel -j 8 samtools index {}
~

