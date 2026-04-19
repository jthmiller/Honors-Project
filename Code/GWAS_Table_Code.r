# 1. Load Functions and Data
source('code/GWAS_Phasing.r')

# Helper to check if file exists before reading
read_safe <- function(path, type = "table", ...) {
  if (!file.exists(path)) stop(paste("File not found:", path))
  if (type == "table") return(read.table(path, ...))
  if (type == "csv") return(read.csv(path, ...))
}

# Load DNA Data
me  <- read_safe("Raw_Data/AncestryDNA_LI.txt", sep="\t", header=TRUE, row.names=1)
mom <- read_safe("Raw_Data/AncestryDNA_BM.txt", sep="\t", header=TRUE, row.names=1)
dad <- read_safe("Raw_Data/AncestryDNA_DI.txt", sep="\t", header=TRUE, row.names=1)

# 2. Load and Combine GWAS data (Updated Filenames)
# Note: I used 'gaws2_fixed.csv' as per your message
gwas1 <- read_safe('Raw_Data/gwas1_fixed.csv', type = "csv", header = TRUE)
gwas2 <- read_safe('Raw_Data/gwas2_fixed.csv', type = "csv", header = TRUE)
gwas  <- rbind(gwas1, gwas2)
rm(gwas1, gwas2)

# 3. Phasing
phsd <- phase_alleles_simple(me, par1 = mom, par2 = dad)

# 4. Filtering & Cleaning (Fast Version)
risk_col <- grep("STRONGEST.*RISK.*ALLELE", names(gwas), value = TRUE, ignore.case = TRUE)[1]
if(is.na(risk_col)) stop("Could not find the Risk Allele column!")

# Clean whitespace and filter for SNPs in phased data
gwas[[risk_col]] <- gsub(" ", "", gwas[[risk_col]])
gwas <- gwas[gwas$SNPS %in% rownames(phsd), ]

# Fast extraction of risk allele (Vectorized)
# This replaces the slow 'rmid' apply function
gwas$risk_snp <- gsub(".*-", "", gwas[[risk_col]]) # Gets everything after the "-"
gwas <- gwas[!is.na(gwas$risk_snp) & gwas$risk_snp != '?', ]

# 5. Locate and Map Parents 1 & 2 (Dynamic Search)
# This finds any column in 'phsd' that starts with "p1/p2" or "par1/par2"
p1_col_name <- grep("p1|par1|mom", names(phsd), value = TRUE, ignore.case = TRUE)[1]
p2_col_name <- grep("p2|par2|dad", names(phsd), value = TRUE, ignore.case = TRUE)[1]

cat("Mapping Parent 1 from column:", p1_col_name, "\n")
cat("Mapping Parent 2 from column:", p2_col_name, "\n")

# Map the data using the names we just found
gwas$my_allele_p1 <- phsd[match(gwas$SNPS, rownames(phsd)), p1_col_name]
gwas$my_allele_p2 <- phsd[as.character(gwas$SNPS), p2_col_name] # Direct mapping attempt

# 6. Parent of Origin Logic
# This creates the 'par_risk' column based on the now-working p1 and p2 alleles
gwas$par_risk <- "Neither"
gwas$par_risk[gwas$risk_snp == gwas$my_allele_p1] <- "p1"
gwas$par_risk[gwas$risk_snp == gwas$my_allele_p2] <- "p2"
gwas$par_risk[gwas$risk_snp == gwas$my_allele_p1 & gwas$risk_snp == gwas$my_allele_p2] <- "Both"

# 7. Final Table Export & Review
# Define the exact order for the CSV
cols_to_save <- c('SNPS', 'DISEASE.TRAIT', 'risk_snp', 'my_allele_p1', 'my_allele_p2', 'par_risk')

# Save to CSV
write.csv(gwas[, cols_to_save], file = "Raw_Data/Phased_GWAS_Results_FINAL.csv", row.names = FALSE)

cat("\nDone! Phased_GWAS_Results_FINAL.csv now contains ALL columns.\n")

# Display first 20 rows of the final organized table
print(head(gwas[, cols_to_save], 20))