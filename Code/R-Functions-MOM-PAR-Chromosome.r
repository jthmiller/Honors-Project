
# --- Simplified Phasing Function ---
phase_alleles_simple <- function(tophase, par1, par2) {
  # Focus only on SNPs where the child is heterozygous
  is_het <- tophase$allele1 != tophase$allele2
  child_hets <- tophase[is_het, ]
  p1 <- par1[rownames(child_hets), ]
  p2 <- par2[rownames(child_hets), ]

  # Logic: If child is (A,B) and Parent 1 is (A,A), the 'A' must come from Parent 1.
  # We identify which child allele matches Parent 1's homozygous genotype.
  
  # Case 1: Parent 1 is homozygous, Parent 2 is anything
  p1_hom <- p1$allele1 == p1$allele2
  child_hets$p1_val <- NA
  
  # If P1 is homozygous, the allele in the child matching P1 is the P1-inherited allele
  child_hets$p1_val[p1_hom] <- p1$allele1[p1_hom]
  
  # Case 2: Parent 2 is homozygous, Parent 1 is anything
  p2_hom <- p2$allele1 == p2$allele2
  # If P2 is homozygous, the allele in the child NOT matching P2 must be from P1
  child_hets$p1_val[p2_hom] <- ifelse(child_hets$allele1[p2_hom] == p2$allele1[p2_hom], 
                                      child_hets$allele2[p2_hom], 
                                      child_hets$allele1[p2_hom])

  # Filter to only markers we could successfully phase
  return(child_hets[!is.na(child_hets$p1_val), ])
}

# --- Simplified Plotting Function ---
plot_chromosome_one_grandparent <- function(output_dir = 'Plots/') {
  chrom <- 25

  # 1. Phase ME relative to MOM/DAD to find which allele is Maternal
  me_phased <- phase_alleles_simple(me[me$chromosome == chrom,], mom, dad)
  
  # 2. Phase MOM relative to MGM/MGF to see which of HER alleles are from MGM
  mom_phased <- phase_alleles_simple(mom[mom$chromosome == chrom,], mgm, mgf)
  
  # 3. Join the data
  common_snps <- intersect(rownames(me_phased), rownames(mom_phased))
  
  # 'maternal_allele' is what I got from Mom
  # 'mgm_allele' is what Mom got from Grandma
  final_df <- data.frame(
    position = me_phased[common_snps, "position"],
    maternal_allele = me_phased[common_snps, "p1_val"],
    mgm_allele = mom_phased[common_snps, "p1_val"]
  )
  
  # If the allele I got from Mom matches what she got from Grandma, it's MGM (Red)
  final_df$source <- ifelse(final_df$maternal_allele == final_df$mgm_allele, "MGM", "MGF")
  final_df$plot_y <- ifelse(final_df$source == "MGM", 0.5, 1.5)
  final_df$color  <- ifelse(final_df$source == "MGM", "red", "blue")

 # --- Output ---
png(file.path(output_dir, paste0("PAR_maternal_chromosome.png")), width = 500, height = 500)

# Use final_df instead of me_phased!
plot(y = final_df$position, 
     x = final_df$plot_y,       # Use the y-coordinates (0.5 or 1.5) we made in final_df
     col = final_df$color,      # Use the colors we assigned in final_df
     pch = 16, 
     xlim = c(0, 2),
     xaxt = 'n', 
     ylab = "Genomic Position",
     xlab = "Grandparent of Origin",
     main = "Maternal Recombination: Chromosome PAR")

# Add the labels we fixed earlier
axis(1, at = c(0.5, 1.5), labels = c("Grandmother", "Grandfather"))

dev.off()
  
  write.csv(final_df, file.path(output_dir, "PAR_chromosome_data.csv"))
}