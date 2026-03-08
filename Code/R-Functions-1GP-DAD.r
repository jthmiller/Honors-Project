plot_chromsome_single_parent <- function(chrom, output_dir = 'Plots/'){

  # 1. Phase YOU against your Mom and Dad (this stays the same)
  me_phased <- phase_alleles(tophase = me[me$chromosome == chrom,], par1 = mom, par2 = dad)
  
  # 2. Identify DAD's markers for this chromosome
  dad_chrom <- dad[dad$chromosome == chrom,]
  pgf_chrom <- pgf[pgf$chromosome == chrom,]
  
  # 3. Find sites where Grandpa is Homozygous (the only sites we can phase with 1 parent)
  pgf_homz <- pgf_chrom[pgf_chrom$allele1 == pgf_chrom$allele2,]
  
  # 4. Intersect with your maternal alleles
  # We only care about markers where we know your 'par2_gt' (Paternal allele)
  common_markers <- intersect(rownames(me_phased), rownames(pgf_homz))
  
  me_pgf_out <- data.frame(
    me_phased[common_markers, c('chromosome', 'position', 'par2_gt')],
    pgf_allele = pgf_homz[common_markers, 'allele1']
  )

  # 5. Logical Assignment:
  # If your paternal allele matches Grandpa's homozygous allele, it's Grandpa.
  # Otherwise, it MUST be Grandma.
  me_pgf_out$origin <- ifelse(me_pgf_out$par2_gt == me_pgf_out$pgf_allele, 'Grandfather', 'Grandmother')
  me_pgf_out$plotpoint <- ifelse(me_pgf_out$origin == 'Grandfather', 0.5, 1.5)
  me_pgf_out$cols <- ifelse(me_pgf_out$origin == 'Grandfather', 'blue', 'red') # Blue for Grandpa

  # 6. Plotting
  png(paste0(output_dir, chrom, '_vs_Grandpa.png'), width = 1000, height = 2000)
  plot(me_pgf_out$plotpoint, me_pgf_out$position, 
       col = me_pgf_out$cols, xlim = c(0, 2), pch = 16, 
       main = paste('Chromosome', chrom, '- Phased via Grandfather only'))
  dev.off()

  return(me_pgf_out)
}