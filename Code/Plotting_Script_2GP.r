
### added 'row.names=1' to each time we read in file
me <- read.table("Raw_Data/AncestryDNA_LI.txt", sep="\t", header=TRUE,row.names=1)
mom <- read.table("Raw_Data/AncestryDNA_BM.txt", sep="\t", header=TRUE,row.names=1)
dad <- read.table("Raw_Data/AncestryDNA_DI.txt", sep="\t", header=TRUE,row.names=1)

pgf <- read.table("Raw_Data/AncestryDNA_FI.txt", sep="\t", header=TRUE,row.names=1)
mgm <- read.table("Raw_Data/AncestryDNA_MH.txt", sep="\t", header=TRUE,row.names=1)
mgf <- read.table("Raw_Data/AncestryDNA_RM.txt", sep="\t", header=TRUE,row.names=1)

source('code/R-Functions-2GP.r')

plot_chromosome_simple(chrom = 18, output_dir = 'TESTING_2GP_Plots/')
  
