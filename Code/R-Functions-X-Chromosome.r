phase_X_alleles <- function(tophase, par1, par2) {
  # Focus only on SNPs where the child (Mom) is heterozygous
  is_het <- tophase$allele1 != tophase$allele2
  child_hets <- tophase[is_het, ]
  p1 <- par1[rownames(child_hets), ] # MGM
  p2 <- par2[rownames(child_hets), ] # MGF (Male)

  child_hets$p1_val <- NA
  
  # --- Case 1: Identify alleles from MGF (Parent 2) ---
  # Since MGF is male, he only has ONE X allele to give. 
  # We find which of the child's alleles matches his single allele.
  # The allele that DOES NOT match him must be from P1 (MGM).
  
  matches_p2 <- child_hets$allele1 == p2$allele1
  
  # If allele1 matches my Grandfather, then allele2 came from Grandmother (p1_val)
  child_hets$p1_val[matches_p2] <- child_hets$allele2[matches_p2]
  
  # If allele1 does NOT match Grandfather, then allele1 came from Grandmother (p1_val)
  child_hets$p1_val[!matches_p2] <- child_hets$allele1[!matches_p2]
  
  # --- Case 2: Verification via MGM (Parent 1) ---
  # If Grandmother is homozygous, we can double-check the result.
  p1_hom <- p1$allele1 == p1$allele2
  child_hets$p1_val[p1_hom] <- p1$allele1[p1_hom]
  
  return(child_hets[!is.na(child_hets$p1_val), ])
}

plot_X_chromosome_simple <- function(output_dir = 'Plots/') {
  chrom <- 23
  
  # 1. You are male; your entire X is from Mom. No phasing needed for 'me'.
  me_x <- me[me$chromosome == chrom, ]
  
  # 2. Phase MOM relative to MGM (p1) and MGF (p2)
  mom_phased <- phase_X_alleles(mom[mom$chromosome == chrom, ], mgm, mgf)
  
  # 3. Join the data
  common_snps <- intersect(rownames(me_x), rownames(mom_phased))
  
  # 'my_allele' is what I have (from Mom)
  # 'mgm_allele' is what Mom got from Grandma (P1)
  final_df <- data.frame(
    position = me_x[common_snps, "position"],
    my_allele = me_x[common_snps, "allele1"], 
    mgm_allele = mom_phased[common_snps, "p1_val"]
  )
  
  # Logic: If my allele matches the one Mom got from Grandma, it's MGM.
  final_df$source <- ifelse(final_df$my_allele == final_df$mgm_allele, "MGM", "MGF")
  final_df$plot_y <- ifelse(final_df$source == "MGM", 0.5, 1.5)
  final_df$color  <- ifelse(final_df$source == "MGM", "red", "blue")

  # --- Output ---
  png(file.path(output_dir, "X_maternal_chromosome.png"), width = 500, height = 500)

  plot(y = final_df$position, 
       x = final_df$plot_y, 
       col = final_df$color, 
       pch = 16, 
       xlim = c(0, 2),
       xaxt = 'n', 
       ylab = "Genomic Position",
       xlab = "Grandparent of Origin",
       main = "Maternal Recombination: Chromosome X")

  axis(1, at = c(0.5, 1.5), labels = c("Grandmother", "Grandfather"))

  dev.off()
  
  write.csv(final_df, file.path(output_dir, "X_chromosome_data.csv"))
}