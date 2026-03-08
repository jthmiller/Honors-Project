plot_chromosome_single_parent <- function(chrom, output_dir = 'Plots/') {

  # 1. Phase YOU against Mom/Dad (Same as 2-GP version)
  # Ensure we use 'phase_alleles_simple' so the column names match
  me_phased <- phase_alleles_simple(me[me$chromosome == chrom,], mom, dad)
  
  # 2. Identify Dad's markers for this chromosome
  dad_chrom <- dad[dad$chromosome == chrom,]
  pgf_chrom <- pgf[pgf$chromosome == chrom,]
  
  # 3. Find sites where Grandpa is Homozygous
  # This is the "Restriction" that makes this plot different/lower resolution
  pgf_homz <- pgf_chrom[pgf_chrom$allele1 == pgf_chrom$allele2,]
  
  # 4. Intersect
  # This list will be SMALLER than the 2-GP version because we skip 
  # any SNP where Grandpa is Heterozygous (A/B).
  common_markers <- intersect(rownames(me_phased), rownames(pgf_homz))
  
  # Create the dataframe using the p1_val (Paternal Allele)
  me_pgf_out <- data.frame(
    position = me_phased[common_markers, "position"],
    paternal_allele = me_phased[common_markers, "p1_val"],
    pgf_allele = pgf_homz[common_markers, "allele1"]
  )

  # 5. Logical Assignment
  me_pgf_out$origin <- ifelse(me_pgf_out$paternal_allele == me_pgf_out$pgf_allele, 'PGF', 'PGM')
  me_pgf_out$plotpoint <- ifelse(me_pgf_out$origin == 'PGM', 0.5, 1.5)
  me_pgf_out$cols <- ifelse(me_pgf_out$origin == 'PGM', 'red', 'blue') 

  # 6. Output - Change filename to avoid overwriting!
  png(file.path(output_dir, paste0(chrom, "_paternal_chromosome.png")), width = 500, height = 500)
  plot(me_pgf_out$plotpoint, me_pgf_out$position, 
       col = me_pgf_out$cols, xlim = c(0, 2), pch = 16, 
       main = paste("Paternal Recombination: Chromosome", chrom))
  dev.off()
  
  return(me_pgf_out)
}