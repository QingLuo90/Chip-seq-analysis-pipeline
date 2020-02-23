
# Bulk chip-seq data analyzing pipeline

Here is the codes for Chip-seq analyzing pipeline


## Step 1

Step 1 includes dowloanding a batch of sra files from NCBI; converting them into fastq files; running quality control; mapping, removing duplicates and mitochondial alignments.

### Prerequisites

(1) sratoolkit: download the SRA files in batch and convert them into fastq files;
    https://www.ncbi.nlm.nih.gov/books/NBK158900/
    
(2) Trimmomatic: trim adpator and low quality bases;
    http://www.usadellab.org/cms/?page=trimmomatic

(3) Fastqc: quality control of the trimmed fastq files;
    https://www.bioinformatics.babraham.ac.uk/projects/fastqc/
 
(4) Bowtie2: mapping the reads to the reference genome;
    http://bowtie-bio.sourceforge.net/bowtie2/index.shtml
    
(5) Samtools: manipulate sam and bam files, including sam2bam conversion, sort and index;
https://www.htslib.org

(6) Picard: remove duplicates; https://broadinstitute.github.io/picard/


### Run step 1

```
bash Chip_step1.sh
```

## output

(1) ./trim: trimmed and discarded fastq files adn the trim log;                                                              

(2) ./QC: fastqc output for quality check of the fastq files;

(3) ./bam: all the processed sam and bam files; the filename with "rm" means remove mitochondrial alingment which means they are the final files that would be used for peak calling.









 

