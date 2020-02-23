# Bulk chip-seq data analyzing pipeline

Here is the codes for Chip-seq analyzing pipeline


bash chip_step1.sh


## Step 1 involvels the following softwares:

(1) sratoolkit: download the SRA files in batch and convert them into fastq files;
    https://www.ncbi.nlm.nih.gov/books/NBK158900/
    
(2) Trimmomatic: trim adpator and low quality bases;
    http://www.usadellab.org/cms/?page=trimmomatic

(3) Fastqc: quality control of the trimmed fastq files;
    https://www.bioinformatics.babraham.ac.uk/projects/fastqc/
 
(4) Bowtie2: mapping the reads to the reference genome;
    http://bowtie-bio.sourceforge.net/bowtie2/index.shtml
    
(5) Samtools: manipulate sam and bam files, including sam2bam conversion, sort and index;

(6) Picard: remove duplicates

 

