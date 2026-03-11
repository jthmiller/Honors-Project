phase_alleles_one_parent <- function(me_chrom, mom_chrom, dad_chrom, mgf_chrom) {
  
  # 1. Find common SNPs across all four individuals
  common_snps <- intersect(rownames(me_chrom), 
                           intersect(rownames(mom_chrom), 
                                     intersect(rownames(dad_chrom), rownames(mgf_chrom))))
  
  # Subset all dataframes to these common SNPs
  me_sub  <- me_chrom[common_snps, ]
  mom_sub <- mom_chrom[common_snps, ]
  dad_sub <- dad_chrom[common_snps, ]
  mgf_sub <- mgf_chrom[common_snps, ]
  
  # 2. Basic Phasing: Identify which of your alleles is Maternal (P1)
  # We look for sites where Mom and Dad have different genotypes to be certain
  # For simplicity, this logic assumes 'me' has columns allele1 and allele2
  
  results <- data.frame(
    position = me_sub$position,
    me_genotype = paste0(me_sub$allele1, me_sub$allele2),
    mom_genotype = paste0(mom_sub$allele1, mom_sub$allele2),
    dad_genotype = paste0(dad_sub$allele1, dad_sub$allele2),
    mgf_genotype = paste0(mgf_sub$allele1, mgf_sub$allele2),
    stringsAsFactors = FALSE
  )
  
# 3. Assign Maternal Allele (P1)
# Use vectorized logic: if Mom is homozygous, the maternal allele is just her allele1
is_mom_homoz <- mom_sub$allele1 == mom_sub$allele2

# Initialize the column with NA
results$maternal_allele <- NA

# At sites where Mom is homozygous, the allele she gave you MUST be her allele1
results$maternal_allele[is_mom_homoz] <- mom_sub$allele1[is_mom_homoz]

# Optional: Add simple heterozygous phasing where Dad is homozygous and different
# (This increases the number of usable SNPs)
is_dad_homoz <- dad_sub$allele1 == dad_sub$allele2
is_me_het    <- me_sub$allele1 != me_sub$allele2

# If Dad is AA and I am AG, Maternal must be G
results$maternal_allele[!is_mom_homoz & is_dad_homoz & is_me_het] <- 
  ifelse(me_sub$allele1[!is_mom_homoz & is_dad_homoz & is_me_het] == dad_sub$allele1[!is_mom_homoz & is_dad_homoz & is_me_het], 
         me_sub$allele2[!is_mom_homoz & is_dad_homoz & is_me_het], 
         me_sub$allele1[!is_mom_homoz & is_dad_homoz & is_me_het])
  
  # 4. Phase Mother against her Father (MGF)
  # We only use sites where MGF is Homozygous for high confidence
  results$origin <- "Unknown"
  
  mgf_homoz <- mgf_sub$allele1 == mgf_sub$allele2
  match_mgf <- results$maternal_allele == mgf_sub$allele1
  
  results$origin[mgf_homoz & match_mgf] <- "MGF"
  results$origin[mgf_homoz & !match_mgf & !is.na(results$maternal_allele)] <- "MGM"
  
  # Remove unknowns for the final plotting data
  return(results[results$origin != "Unknown", ])
}

plot_chromosome_single_parent <- function(chrom, output_dir = 'Plots/') {

  # 1. Subset the data for the specific chromosome
  me_c  <- me[me$chromosome == chrom, ]
  mom_c <- mom[mom$chromosome == chrom, ]
  dad_c <- dad[dad$chromosome == chrom, ]
  mgf_c <- mgf[mgf$chromosome == chrom, ]

  # 2. Call the phasing function with ALL 4 required arguments
  # This was where your error was occurring!
  me_phased <- phase_alleles_one_parent(me_c, mom_c, dad_c, mgf_c)
  
  # 3. Use the plotpoint logic for visualization
  me_phased$plotpoint <- ifelse(me_phased$origin == 'MGM', 0.5, 1.5)
  me_phased$cols      <- ifelse(me_phased$origin == 'MGM', 'red', 'blue')

  # 4. Output the plot
  png(file.path(output_dir, paste0(chrom, "_maternal_chromosome.png")), width = 500, height = 500)
  
# --- Add this inside your function before plot() ---
# 1. Prepare the raw numeric source from me_phased
# 0 = Grandmother (Red), 1 = Grandfather (Blue)
me_phased$num <- ifelse(me_phased$origin == "MGF", 1, 0)

# 2. Sort by position to ensure interpolation works vertically
me_phased <- me_phased[order(me_phased$position), ]

# 3. Use approx with a high density to fill the "Line"
# method="constant" creates the sharp "blocks" we see in real DNA inheritance
dense_pos <- seq(min(me_phased$position), max(me_phased$position), length.out = 10000)
interp <- approx(x = me_phased$position, 
                 y = me_phased$num, 
                 xout = dense_pos, 
                 method = "constant", 
                 rule = 2)$y

# 4. Create the final clean dataframe
dense_df <- data.frame(
  position = dense_pos,
  plotpoint = ifelse(interp > 0.5, 1.5, 0.5),
  cols = ifelse(interp > 0.5, "blue", "red")
)

# 5. Plot ONLY the dense_df
# Use a very small 'pch' or even type='p' with small cex to make it look like a solid bar
plot(y = dense_df$position, 
     x = dense_df$plotpoint, 
     col = dense_df$cols, 
     pch = 16,        # Square points fill space better than circles
     xlim = c(0, 2),
     xaxt = 'n', 
     ylab = "Genomic Position",
     xlab = "Grandparent of Origin",
     main = paste("Maternal Recombination: Chromosome", chrom))

axis(1, at = c(0.5, 1.5), labels = c("Grandmother", "Grandfather"))
  
  dev.off()
  
  return(me_phased)
}