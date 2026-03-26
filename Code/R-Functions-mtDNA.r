
plot_mitochondria_simple <- function(output_dir = 'Plots/') {
  chrom <- 26

  # 1. Get mtDNA data for You and MGM
  me_mt <- me[me$chromosome == chrom, ]
  mgm_mt <- mgm[mgm$chromosome == chrom, ]
  
  # 2. Find common SNPs
  common_snps <- intersect(rownames(me_mt), rownames(mgm_mt))
  
  final_df <- data.frame(
    position = me_mt[common_snps, "position"],
    my_allele = me_mt[common_snps, "allele1"],
    mgm_allele = mgm_mt[common_snps, "allele1"]
  )
  
  # 3. Logic: Does it match Grandma?
  # Since you only have one source, we expect 100% MGM.
  final_df$source <- ifelse(final_df$my_allele == final_df$mgm_allele, "MGM", "Mismatch/Noise")
  final_df$plot_y <- ifelse(final_df$source == "MGM", 0.5, 1.5)
  final_df$color  <- ifelse(final_df$source == "MGM", "red", "blue")

  # --- Output ---
  png(file.path(output_dir, "Mitochondrial_DNA.png"), width = 500, height = 500)
  
  plot(y = final_df$position, 
       x = final_df$plot_y, 
       col = final_df$color, 
       pch = 16, 
       xlim = c(0, 2), 
       xaxt = 'n', 
       ylab = "Genomic Position",
       xlab = "Grandparent of Origin", 
       main = "Mitochondrial DNA")
  
  axis(1, at = c(0.5, 1.5), labels = c("Grandmother", "Mismatch/Noise"))
  
  dev.off()
  
  write.csv(final_df, file.path(output_dir, "Mitochondrial_DNA_data.csv"))
}