
#!/usr/bin/perl

my $strSampleList = "SRRList";
open(LIST, "<".$strSampleList) or die "Can not open $strSampleList.\r\n";



###############trim adapter################
$mkdir = "mkdir trim";
system($mkdir);


###############fastqc QC################
$mkdirQC = "mkdir QC";
system($mkdirQC);

while(<LIST>){
        my $strLine = $_;
        $strLine =~ s/^\s+//;
        $strLine =~ s/\s+$//;

                 
        #in and out for adapter trimming
        my $R1 = "./".$strLine.".fastq.gz";
        
        my $trim ="./trim/".$strLine.".fq.gz";

        my $trim_log = "./trim/".$strLine."trimLog";

        
        my $strCmd="java -jar /mnt/hel/home/qinluo/software/NGS/trimmomatic-0.39/trimmomatic-0.39.jar SE -threads 10 -phred33 -trimlog $trim_log $R1 $trim ILLUMINACLIP:/mnt/hel/home/qinluo/software/NGS/trimmomatic-0.39/adapters/TruSeq3-PE.fa:2:30:10 LEADING:10 SLIDINGWINDOW:4:15 MINLEN:36";

        system($strCmd);

        my $strCmd2= "fastqc -o ./QC --extract -f fastq $trim -t 4";
        system($strCmd2);
}

close
