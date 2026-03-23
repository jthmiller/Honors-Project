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

phase_alleles_single_parent <- function(tophase, par1) {
  # 1. Filter for SNPs where the child is heterozygous
  # (If child is AA, we already know both parents gave an A)
  is_het <- tophase$allele1 != tophase$allele2
  child_hets <- tophase[is_het, ]
  
  # Ensure the parent data matches the child's SNPs
  p1 <- par1[rownames(child_hets), ]

  # 2. Identify where Parent 1 is homozygous
  # This is the only time we can be 100% sure which allele came from them
  p1_hom <- p1$allele1 == p1$allele2
  
  # Initialize the column for the allele inherited from Parent 1
  child_hets$p1_val <- NA
  
  # 3. Logic: If Parent 1 is AA and Child is AB, Parent 1 must have given the A
  # We only assign p1_val if Parent 1 is homozygous.
  child_hets$p1_val[p1_hom] <- p1$allele1[p1_hom]
  
  # 4. Optional: Infer Mother's allele (p2_val)
  # If we know Dad gave 'A', and we are 'AB', Mom must have given 'B'
  child_hets$p2_val <- NA
  phased_idx <- !is.na(child_hets$p1_val)
  
  child_hets$p2_val[phased_idx] <- ifelse(
    child_hets$allele1[phased_idx] == child_hets$p1_val[phased_idx], 
    child_hets$allele2[phased_idx], 
    child_hets$allele1[phased_idx]
  )

  # Return only the rows where phasing was successful
  return(child_hets[phased_idx, ])
}

plot_chromosome_one_grandparent <- function(chrom, output_dir = 'Plots/') {
  
  # 1. Phase ME relative to MOM/DAD to find which allele is Maternal
  me_phased <- phase_alleles_simple(me[me$chromosome == chrom,], mom, dad)
  
# 2. Phase MOM relative to MGF ONLY (Single-parent phasing for Mom)
  # We use the new single-parent function logic here
  mom_subset <- mom[mom$chromosome == chrom, ]
  mgf_subset <- mgf[rownames(mom_subset), ]
  
  # Only focus on Mom's hets where MGF is homozygous
  mom_is_het <- mom_subset$allele1 != mom_subset$allele2
  mgf_is_hom <- mgf_subset$allele1 == mgf_subset$allele2
  
  # Valid markers are where Mom is het AND MGF is hom
  valid_idx <- mom_is_het & mgf_is_hom
  
  # Create a dataframe for Mom's phasing
  mom_phased <- mom_subset[valid_idx, ]
  
  # The allele Mom got from her father (MGF)
  mom_phased$mgf_allele <- mgf_subset$allele1[valid_idx]
  
  # INFER the allele Mom got from her mother (MGM)
  mom_phased$mgm_allele <- ifelse(mom_phased$allele1 == mom_phased$mgf_allele, 
                                  mom_phased$allele2, 
                                  mom_phased$allele1)
  
  # 3. Join the data
  common_snps <- intersect(rownames(me_phased), rownames(mom_phased))
  
  # 'maternal_allele' is what YOU got from Mom
  # 'mgm_allele' is what Mom got from Grandma (inferred)
  final_df <- data.frame(
    position = me_phased[common_snps, "position"],
    maternal_allele = me_phased[common_snps, "p1_val"],
    mgm_allele = mom_phased[common_snps, "mgm_allele"] # Use the inferred column
  )
  
  # --- Remainder of your plotting code stays the same ---
  final_df$source <- ifelse(final_df$maternal_allele == final_df$mgm_allele, "MGM", "MGF")
  final_df$plot_y <- ifelse(final_df$source == "MGM", 0.5, 1.5)
  final_df$color  <- ifelse(final_df$source == "MGM", "red", "blue")

  # --- Output ---
  png(file.path(output_dir, paste0(chrom, "_maternal_chromosome.png")), width = 500, height = 500)

  plot(y = final_df$position,
       x = final_df$plot_y,
       col = final_df$color,
       pch = 16,
       xlim = c(0, 2),
       xaxt = 'n', 
       ylab = "Genomic Position",
       xlab = "Grandparent of Origin",
       main = paste("Maternal Recombination: Chromosome", chrom))

  axis(1, at = c(0.5, 1.5), labels = c("Grandmother", "Grandfather"))

  dev.off()
  
  write.csv(final_df, file.path(output_dir, paste0(chrom, "_chromosome.csv")))
}