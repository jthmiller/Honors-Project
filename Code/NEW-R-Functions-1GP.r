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

plot_chromosome_simple_no_mgm <- function(chrom, output_dir = 'Plots/') {
  
  # 1. Phase ME relative to MOM/DAD to find which allele is Maternal
  me_phased <- phase_alleles_simple(me[me$chromosome == chrom,], mom, dad)
  
  # 2. Phase MOM relative to MGF only. 
  # Since MGM is missing, we treat MGF as 'Parent 1' and use an empty/dummy 
  # set for 'Parent 2' so the function only relies on MGF's homozygous SNPs.
  mom_phased_mgf <- phase_alleles_simple(mom[mom$chromosome == chrom,], mgf, mgf)
  
  # 3. Join the data
  common_snps <- intersect(rownames(me_phased), rownames(mom_phased_mgf))
  
  final_df <- data.frame(
    position = me_phased[common_snps, "position"],
    maternal_allele = me_phased[common_snps, "p1_val"], # What I got from Mom
    mgf_allele = mom_phased_mgf[common_snps, "p1_val"] # What Mom got from MGF
  )
  
  # --- THE NEW LOGIC ---
  # If the allele I got from Mom matches the allele she got from MGF, the source is MGF.
  # If they DON'T match, it MUST have come from the missing MGM.
  final_df$source <- ifelse(final_df$maternal_allele == final_df$mgf_allele, "MGF", "MGM")
  
  # Maintain consistent colors: MGM = Red, MGF = Blue
  final_df$plot_y <- ifelse(final_df$source == "MGM", 0.5, 1.5)
  final_df$color  <- ifelse(final_df$source == "MGM", "red", "blue")

  # --- Output ---
  png(file.path(output_dir, paste0(chrom, "_maternal_no_mgm.png")), width = 500, height = 500)

  plot(y = final_df$position, 
       x = final_df$plot_y, 
       col = final_df$color, 
       pch = 16, 
       xlim = c(0, 2),
       xaxt = 'n', 
       ylab = "Genomic Position",
       xlab = "Grandparent of Origin (Inferred)",
       main = paste("Maternal Recombination (MGM Inferred): Chromosome", chrom))

  axis(1, at = c(0.5, 1.5), labels = c("Grandmother (Inferred)", "Grandfather"))

  dev.off()
  
  write.csv(final_df, file.path(output_dir, paste0(chrom, "_chromosome_inferred.csv")))
}