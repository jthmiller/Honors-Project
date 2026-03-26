
plot_Y_chromosome_simple <- function(output_dir = 'Plots/') {
  chrom <- 24
  
  # 1. Get Y data for you, Dad, and PGF
  me_y <- me[me$chromosome == chrom, ]
  
  # 2. Logic: It's a straight line from PGF -> Dad -> Me.
  # We compare your Y alleles directly to your Paternal Grandfather (PGF).
  common_snps <- intersect(rownames(me_y), rownames(pgf))
  
  final_df <- data.frame(
    position = me_y[common_snps, "position"],
    my_allele = me_y[common_snps, "allele1"],
    pgf_allele = pgf[common_snps, "allele1"]
  )
  
  # If it matches PGF, it's PGF. If it doesn't, it's likely a mutation or 
  # a genotyping error (since you can't get Y-DNA from your Paternal Grandma).
  final_df$source <- ifelse(final_df$my_allele == final_df$pgf_allele, "PGF", "Mismatch/Noise")
  final_df$plot_y <- ifelse(final_df$source == "PGF", 1.5, 0.5)
  final_df$color  <- ifelse(final_df$source == "PGF", "blue", "red")

  # --- Output ---
 png(file.path(output_dir, "Y_paternal_chromosome.png"), width = 500, height = 500)

  plot(y = final_df$position, 
       x = final_df$plot_y, 
       col = final_df$color, 
       pch = 16, 
       xlim = c(0, 2),
       xaxt = 'n', 
       ylab = "Genomic Position",
       xlab = "Grandparent of Origin",
       main = "Paternal Recombination: Chromosome Y")

  axis(1, at = c(0.5, 1.5), labels = c("Mismatch/Noise", "Grandfather"))

  dev.off()
  
  write.csv(final_df, file.path(output_dir, "Y_chromosome_data.csv"))
}