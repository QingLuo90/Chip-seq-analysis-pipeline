#!/user/bin/bash

#calculate pileup files of treatment and control, use -FE for fold enrichment
sort srrList | parallel --jobs 14 "macs2 bdgcmp -t ./macs/{}_treat_pileup.bdg -c ./macs/{}_control_lambda.bdg --outdir ./BigWig -o {}.bdg -m FE";

#turn bdg file into bedgraph
sort srrList | parallel --jobs 14 "slopBed -i ./BigWig/{}.bdg -g mm10.chrom.sizes -b 0 | bedClip stdin mm10.chrom.sizes stdout| \
bedtools sort -chrThenSizeA -i stdin \
| bedtools sort -i stdin > ./BigWig/{}.bedgraph"


#turn bedgraph file in to biwgiw
sort srrList3 | parallel --jobs 14 "bedGraphToBigWig ./BigWig/{}.bedgraph mm10.chrom.sizes ./BigWig/{}.bigwig"
