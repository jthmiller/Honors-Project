plot_chromosome_single_parent <- function(chrom, output_dir = 'Plots/') {

  # 1. Phase YOU against Mom/Dad (Same as 2-GP version)
  # Ensure we use 'phase_alleles_simple' so the column names match
  me_phased <- phase_alleles_simple(me[me$chromosome == chrom,], mom, dad)
  
  # 2. Identify Mom's markers for this chromosome
  mom_chrom <- mom[mom$chromosome == chrom,]
  mgf_chrom <- mgf[mgf$chromosome == chrom,]
  
  # 3. Find sites where Grandpa is Homozygous
  # This is the "Restriction" that makes this plot different/lower resolution
  mgf_homz <- mgf_chrom[mgf_chrom$allele1 == mgf_chrom$allele2,]
  
  # 4. Intersect
  # This list will be SMALLER than the 2-GP version because we skip 
  # any SNP where Grandpa is Heterozygous (A/B).
  common_markers <- intersect(rownames(me_phased), rownames(mgf_homz))
  
  # Create the dataframe using the p1_val (Maternal Allele)
  me_mgf_out <- data.frame(
    position = me_phased[common_markers, "position"],
    maternal_allele = me_phased[common_markers, "p1_val"],
    mgf_allele = mgf_homz[common_markers, "allele1"]
  )

  # 5. Logical Assignment
  me_mgf_out$origin <- ifelse(me_mgf_out$maternal_allele == me_mgf_out$mgf_allele, 'MGF', 'MGM')
  me_mgf_out$plotpoint <- ifelse(me_mgf_out$origin == 'MGM', 0.5, 1.5)
  me_mgf_out$cols <- ifelse(me_mgf_out$origin == 'MGM', 'red', 'blue') 

  # 6. Output - Change filename to avoid overwriting!
  png(file.path(output_dir, paste0(chrom, '_vs_Grandpa_ONLY.png')), width = 800, height = 1200)
  plot(me_mgf_out$plotpoint, me_mgf_out$position, 
       col = me_mgf_out$cols, xlim = c(0, 2), pch = 16, 
       main = paste('Chromosome', chrom, '- Phased via MGF only'))
  dev.off()
  
  return(me_mgf_out)
}