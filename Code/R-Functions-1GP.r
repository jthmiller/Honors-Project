phase_alleles_one_parent <- function(me_chrom, mom_chrom, dad_chrom, mgf_chrom) {
  
  # 1. Identify your Maternal Allele (using Me, Mom, and Dad)
  # Find common SNPs for the nuclear family
  nuc_snps <- intersect(rownames(me_chrom), intersect(rownames(mom_chrom), rownames(dad_chrom)))
  
  me_s  <- me_chrom[nuc_snps, ]
  mom_s <- mom_chrom[nuc_snps, ]
  dad_s <- dad_chrom[nuc_snps, ]
  
  # Vectorized phasing: If Mom is homoz (AA), you got 'A'. 
  # If Mom is het (AG) and Dad is homoz (TT), and you are (AT), you got 'A'.
  maternal_alleles <- rep(NA, nrow(me_s))
  
  # Case A: Mom is Homozygous
  mom_homoz <- mom_s$allele1 == mom_s$allele2
  maternal_alleles[mom_homoz] <- mom_s$allele1[mom_homoz]
  
  # Case B: Mom is Het, Dad is Homozygous, Child is Het
  dad_homoz <- dad_s$allele1 == dad_s$allele2
  me_het    <- me_s$allele1 != me_s$allele2
  
  logic_b <- !mom_homoz & dad_homoz & me_het
  maternal_alleles[logic_b] <- ifelse(me_s$allele1[logic_b] == dad_s$allele1[logic_b], 
                                      me_s$allele2[logic_b], 
                                      me_s$allele1[logic_b])
  
  # Create a temporary dataframe of phased maternal alleles
  phased_me <- data.frame(position = me_s$position, 
                          maternal_allele = maternal_alleles, 
                          stringsAsFactors = FALSE)
  phased_me <- phased_me[!is.na(phased_me$maternal_allele), ]
  
  # 2. Match that Maternal Allele to Grandfather (MGF)
  # Match these results against MGF data
  common_mgf <- intersect(rownames(mgf_chrom), rownames(me_s))
  mgf_s <- mgf_chrom[common_mgf, ]
  
  # Merge the phased results with MGF data
  final <- merge(phased_me, mgf_s[, c("position", "allele1", "allele2")], by = "position")
  
  # If your maternal allele matches MGF's homozygous allele, it's MGF. Otherwise MGM.
  mgf_homoz <- final$allele1 == final$allele2
  final$origin <- "Unknown"
  
  final$origin[mgf_homoz & final$maternal_allele == final$allele1] <- "MGF"
  final$origin[mgf_homoz & final$maternal_allele != final$allele1] <- "MGM"
  
  return(final[final$origin != "Unknown", ])
}

plot_chromosome_single_parent <- function(chrom, output_dir = 'Plots/') {

  # 1. Subset the data
  me_c  <- me[me$chromosome == chrom, ]
  mom_c <- mom[mom$chromosome == chrom, ]
  dad_c <- dad[dad$chromosome == chrom, ]
  mgf_c <- mgf[mgf$chromosome == chrom, ]

  # 2. Call the NEW phasing function (Version 2)
  me_phased <- phase_alleles_one_parent(me_c, mom_c, dad_c, mgf_c)
  
  if(nrow(me_phased) < 2) {
    message(paste("Not enough data for Chromosome", chrom))
    return(NULL)
  }

  # 3. Create explicit X-axis positions for the two columns
  # This prevents the blue and red from ever overlapping
  me_phased$plot_x <- ifelse(me_phased$origin == "MGF", 1.5, 0.5)
  me_phased$plot_col <- ifelse(me_phased$origin == "MGF", "blue", "red")

  # 4. Output the plot
  png(file.path(output_dir, paste0(chrom, "_maternal_chromosome.png")), width = 500, height = 500)
  
  plot(y = me_phased$position,
     x = me_phased$plot_x,
     col = me_phased$plot_col,
     pch = 16,
     xlim = c(0, 2),
     xaxt = 'n',
     ylab = "Genomic Position",
     xlab = "Grandparent of Origin",
     main = paste("Maternal Recombination: Chromosome", chrom))

axis(1, at = c(0.5, 1.5), labels = c("Grandmother", "Grandfather"))

  dev.off()

  return(me_phased)
}