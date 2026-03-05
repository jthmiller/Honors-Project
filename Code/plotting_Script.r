

### added 'row.names=1' to each time we read in file
me <- read.table("raw data/AncestryDNA_LI.txt", sep="\t", header=TRUE,row.names=1)
mom <- read.table("raw data/AncestryDNA_BM.txt", sep="\t", header=TRUE,row.names=1)
dad <- read.table("raw data/AncestryDNA_DI.txt", sep="\t", header=TRUE,row.names=1)

pgf <- read.table("raw data/AncestryDNA_FI.txt", sep="\t", header=TRUE,row.names=1)
mgm <- read.table("raw data/AncestryDNA_MH.txt", sep="\t", header=TRUE,row.names=1)
mgf <- read.table("raw data/AncestryDNA_RM.txt", sep="\t", header=TRUE,row.names=1)

source('phase_functions.r')
source('plot_functions.r')
  
plot_chromsome(chrom = 23)
  
save.image('phasing_done.rsave')