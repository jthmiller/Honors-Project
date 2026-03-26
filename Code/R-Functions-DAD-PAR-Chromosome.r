
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

plot_chromosome_one_grandparent <- function(output_dir = 'Plots/') {
  chrom <- 25
  
  # 1. Isolate your Paternal Allele
  # We put DAD first so p1_val is what you got from him
  me_phased <- phase_alleles_simple(me[me$chromosome == chrom,], dad, mom)
  
  # 2. Get Dad and PGF data for this chromosome
  dad_subset <- dad[dad$chromosome == chrom, ]
  pgf_subset <- pgf[rownames(dad_subset), ]
  
  # 3. Find SNPs where we can actually compare them
  # We need: 1. You are phased (p1_val exists)
  #          2. PGF is Homozygous (so we know HIS only X/Y allele)
  common_snps <- intersect(rownames(me_phased), rownames(pgf_subset))
  pgf_hom_snps <- rownames(pgf_subset)[pgf_subset$allele1 == pgf_subset$allele2]
  
  # Final list of markers we can use
  valid_snps <- intersect(common_snps, pgf_hom_snps)
  
  if (length(valid_snps) == 0) {
    stop("No overlapping SNPs found where PGF is homozygous on Chrom 25.")
  }
  
  # 4. Build the comparison table
  final_df <- data.frame(
    position = me_phased[valid_snps, "position"],
    my_paternal_allele = me_phased[valid_snps, "p1_val"],
    pgf_allele = pgf_subset[valid_snps, "allele1"]
  )
  
  # 5. THE LOGIC SWITCH:
  # If my paternal allele matches PGF -> Source is PGF
  # If it DOES NOT match PGF -> Source is INFERRED PGM
  final_df$source <- ifelse(final_df$my_paternal_allele == final_df$pgf_allele, "PGF", "PGM")
  
  # Mapping for the plot
  final_df$plot_y <- ifelse(final_df$source == "PGM", 0.5, 1.5)
  final_df$color  <- ifelse(final_df$source == "PGM", "red", "blue")

  # --- Output ---
  if (!dir.exists(output_dir)) dir.create(output_dir, recursive = TRUE)

  # --- Output ---
  png(file.path(output_dir, paste0("PAR_paternal_chromosome.png")), width = 500, height = 500)

  plot(y = final_df$position,
       x = final_df$plot_y,
       col = final_df$color,
       pch = 16,
       xlim = c(0, 2),
       xaxt = 'n',
       ylab = "Genomic Position",
       xlab = "Grandparent of Origin",
       main = "Paternal Recombination: Chromosome PAR")

  axis(1, at = c(0.5, 1.5), labels = c("Grandmother", "Grandfather"))

  dev.off()
  
  write.csv(final_df, file.path(output_dir, "PAR_chromosome_data.csv"))
}