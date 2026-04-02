# --- Modified Phasing Function (Now with p2 support) ---
phase_alleles_simple <- function(tophase, par1, par2) {
  # Focus only on SNPs where the child is heterozygous
  is_het <- tophase$allele1 != tophase$allele2
  child_hets <- tophase[is_het, ]
  
  # Ensure we only compare SNPs present in all three files
  common_snps <- intersect(rownames(child_hets), intersect(rownames(par1), rownames(par2)))
  child_hets <- child_hets[common_snps, ]
  p1 <- par1[common_snps, ]
  p2 <- par2[common_snps, ]

  child_hets$p1_val <- NA
  
  # Case 1: Parent 1 is homozygous (e.g., AA)
  # The child MUST have gotten an 'A' from Parent 1.
  p1_hom <- p1$allele1 == p1$allele2
  child_hets$p1_val[p1_hom] <- p1$allele1[p1_hom]
  
  # Case 2: Parent 2 is homozygous (e.g., GG)
  # The child MUST have gotten a 'G' from Parent 2.
  # Therefore, the allele in the child that is NOT 'G' is from Parent 1.
  p2_hom <- p2$allele1 == p2$allele2
  child_hets$p1_val[p2_hom] <- ifelse(child_hets$allele1[p2_hom] == p2$allele1[p2_hom], 
                                      child_hets$allele2[p2_hom], 
                                      child_hets$allele1[p2_hom])

  # --- NEW LOGIC: Deduce Parent 2 ---
  # If p1_val is allele1, then p2_val is allele2. Otherwise, p2_val is allele1.
  # We only do this for rows where p1_val was successfully found.
  child_hets$p2_val <- ifelse(child_hets$allele1 == child_hets$p1_val, 
                              child_hets$allele2, 
                              child_hets$allele1)

  # Filter to only markers we could successfully phase
  return(child_hets[!is.na(child_hets$p1_val), ])
}