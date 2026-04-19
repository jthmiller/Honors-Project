# ==============================================================================
# INTEGRATED PATERNAL PHASING AND GWAS MAPPING SCRIPT - TOTAL CLARITY VERSION
# ==============================================================================

# 1. Load Raw Data
# ------------------------------------------------------------------------------
me  <- read.table("Raw_Data/AncestryDNA_LI.txt", sep="\t", header=TRUE, row.names=1)
mom <- read.table("Raw_Data/AncestryDNA_BM.txt", sep="\t", header=TRUE, row.names=1)
dad <- read.table("Raw_Data/AncestryDNA_DI.txt", sep="\t", header=TRUE, row.names=1)
pgf <- read.table("Raw_Data/AncestryDNA_FI.txt", sep="\t", header=TRUE, row.names=1) 

gwas_results <- read.csv("Raw_Data/Table-Phased_GWAS_Results_FINAL.csv", stringsAsFactors = FALSE)

# 2. Advanced Spacing Logic: Cascading Vertical Push
# ------------------------------------------------------------------------------
spread_labels_perfect <- function(y, buffer) {
  if(length(y) < 2) return(y)
  
  # Sort to ensure we process from top to bottom
  ord <- order(y)
  y_sorted <- y[ord]
  new_y <- y_sorted
  
  for(i in 2:length(new_y)) {
    # If this label overlaps the one above it...
    if(new_y[i] < (new_y[i-1] + buffer)) {
      # Push it down to exactly one buffer distance away
      new_y[i] <- new_y[i-1] + buffer
    }
  }
  
  # Return to original order
  final_y <- numeric(length(y))
  final_y[ord] <- new_y
  return(final_y)
}

# 3. Phasing Logic Functions
# ------------------------------------------------------------------------------
phase_alleles_simple <- function(tophase, par1, par2) {
  is_het <- tophase$allele1 != tophase$allele2
  child_hets <- tophase[is_het, ]
  p1_data <- par1[rownames(child_hets), ]
  p2_data <- par2[rownames(child_hets), ]
  
  # Identify p1-inherited allele
  p1_hom <- p1_data$allele1 == p1_data$allele2
  child_hets$p1_val <- NA
  child_hets$p1_val[p1_hom] <- p1_data$allele1[p1_hom]
  
  p2_hom <- p2_data$allele1 == p2_data$allele2
  child_hets$p1_val[p2_hom] <- ifelse(child_hets$allele1[p2_hom] == p2_data$allele1[p2_hom], 
                                      child_hets$allele2[p2_hom], 
                                      child_hets$allele1[p2_hom])
  
  return(child_hets[!is.na(child_hets$p1_val), ])
}

# 4. Final Paternal Plotting Function
# ------------------------------------------------------------------------------
plot_paternal_total_clarity <- function(chrom, output_dir = 'Paternal_GWAS_Plots') {
  
  # A. Data Prep & Paternal Phasing
  me_subset <- me[me$chromosome == chrom, ]
  me_phased <- phase_alleles_simple(me_subset, mom, dad)
  
  # Infer p2_allele (inherited from Dad)
  me_phased$p2_allele <- ifelse(me_phased$allele1 == me_phased$p1_val, 
                                me_phased$allele2, 
                                me_phased$allele1)
  
  dad_subset <- dad[dad$chromosome == chrom, ]
  pgf_subset <- pgf[rownames(dad_subset), ]
  
  dad_is_het <- dad_subset$allele1 != dad_subset$allele2
  pgf_is_hom <- pgf_subset$allele1 == pgf_subset$allele2
  valid_idx <- dad_is_het & pgf_is_hom
  
  dad_phased <- dad_subset[valid_idx, ]
  dad_phased$pgf_allele <- pgf_subset$allele1[valid_idx]
  
  # Infer PGM (Grandmother) from PGF
  dad_phased$pgm_allele <- ifelse(dad_phased$allele1 == dad_phased$pgf_allele, 
                                 dad_phased$allele2, dad_phased$allele1)
  
  common_snps <- intersect(rownames(me_phased), rownames(dad_phased))
  
  final_df <- data.frame(
    SNP = common_snps,
    position = me_phased[common_snps, "position"],
    p2_allele = me_phased[common_snps, "p2_allele"],
    pgm_allele = dad_phased[common_snps, "pgm_allele"],
    stringsAsFactors = FALSE
  )
  
  final_df$source <- ifelse(final_df$p2_allele == final_df$pgm_allele, "PGM", "PGF")
  write.csv(final_df, file.path(output_dir, paste0(chrom, "_paternal_chromosome_phased.csv")), row.names = FALSE)
  
  # B. Set Plotting Params
  final_df$plot_x <- ifelse(final_df$source == "PGM", 0.5, 1.5)
  final_df$plot_x_jittered <- final_df$plot_x + runif(nrow(final_df), -0.04, 0.04)
  final_df$color <- ifelse(final_df$source == "PGM", "firebrick2", "dodgerblue3")

  # Filter GWAS for Paternal (p2)
  gwas_p2 <- gwas_results[gwas_results$par_risk == "p2", ]
  gwas_agg <- aggregate(DISEASE.TRAIT ~ SNPS, data = gwas_p2, 
                        FUN = function(x) paste(unique(x), collapse = ", "))
  final_df_gwas <- merge(final_df, gwas_agg, by.x = "SNP", by.y = "SNPS")

  # C. Canvas Setup
  chrom_max_pos <- max(final_df$position)
  dynamic_height <- 1500 + (chrom_max_pos / 40000) # Slightly taller for more room
  
  png(file.path(output_dir, paste0(chrom, "_Paternal_Map_Total_Clarity.png")), 
      width = 4200, height = dynamic_height, res = 250)

  par(mar=c(6, 8, 5, 2)) 

  plot(y = final_df$position, x = final_df$plot_x_jittered, col = final_df$color, 
       pch = 16, cex = 0.5, xlim = c(0, 18), xaxt = 'n', yaxt = 'n',
       ylab = "", xlab = "Paternal Grandparent Origin (PGM: Grandmother | PGF: Grandfather)",
       main = paste("Phased Paternal Chromosome", chrom),
       cex.main = 2, frame.plot = FALSE)

  at_ticks <- seq(0, chrom_max_pos, by = 10000000)
  axis(2, at = at_ticks, labels = paste0(at_ticks/1e6, " Mb"), las = 1, cex.axis = 1.1)
  mtext("Genomic Position", side = 2, line = 5, cex = 1.3)
  axis(1, at = 0.5, labels = "PGM", col.axis = "firebrick2", font.axis = 2, cex.axis = 1.5)
  axis(1, at = 1.5, labels = "PGF", col.axis = "dodgerblue3", font.axis = 2, cex.axis = 1.5)
  abline(h = at_ticks, col = "gray92", lty = 3)

  # D. CASCADING LABEL LOGIC
  if(nrow(final_df_gwas) > 0) {
    final_df_gwas <- final_df_gwas[order(final_df_gwas$position), ]
    final_df_gwas$text_x <- rep(c(3.0, 10.5), length.out = nrow(final_df_gwas))
    
    # Set a strict pixel-based buffer (roughly 1.8% of chromosome length)
    spacing_buffer <- chrom_max_pos * 0.018
    
    final_df_gwas$text_y <- NA
    for (tx in unique(final_df_gwas$text_x)) {
      idx <- which(final_df_gwas$text_x == tx)
      final_df_gwas$text_y[idx] <- spread_labels_perfect(final_df_gwas$position[idx], spacing_buffer)
    }
    
    # Points at true position
    points(y = final_df_gwas$position, x = final_df_gwas$plot_x, 
           pch = 21, bg = "yellow", col = "black", cex = 2.2, lwd = 1.8)
    
    # "Elbow" Connectors: Line goes horizontal, then diagonal to the new Y
    segments(x0 = final_df_gwas$plot_x, y0 = final_df_gwas$position, 
             x1 = final_df_gwas$text_x - 0.5, y1 = final_df_gwas$position, 
             col = "gray80", lwd = 1)
    segments(x0 = final_df_gwas$text_x - 0.5, y0 = final_df_gwas$position, 
             x1 = final_df_gwas$text_x, y1 = final_df_gwas$text_y, 
             col = "gray80", lwd = 1)
    
    # Zero-Overlap Text
    text(y = final_df_gwas$text_y, x = final_df_gwas$text_x, 
         labels = final_df_gwas$DISEASE.TRAIT, 
         pos = 4, cex = 0.9, col = "darkred", font = 2)
    
    write.csv(final_df_gwas, file.path(output_dir, paste0(chrom, "_paternal_gwas_hits.csv")), row.names = FALSE)
  }

  dev.off()
}

# 5. Run Execution
# ------------------------------------------------------------------------------
output_name <- "Paternal_GWAS_Plots"
if(!dir.exists(output_name)) dir.create(output_name)
for (i in 1:22) {
  message(paste("Processing Paternal Chromosome", i, "..."))
  try(plot_paternal_total_clarity(chrom = i, output_dir = output_name))
}