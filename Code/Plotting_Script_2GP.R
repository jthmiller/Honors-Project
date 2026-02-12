### added 'row.names=1' to each time we read in file
me <- read.table("raw data/AncestryDNA_LI.txt", sep="\t", header=TRUE,row.names=1)
mom <- read.table("raw data/AncestryDNA_BM.txt", sep="\t", header=TRUE,row.names=1)
dad <- read.table("raw data/AncestryDNA_DI.txt", sep="\t", header=TRUE,row.names=1)

pgf <- read.table("raw data/AncestryDNA_FI.txt", sep="\t", header=TRUE,row.names=1)
mgm <- read.table("raw data/AncestryDNA_MH.txt", sep="\t", header=TRUE,row.names=1)
mgf <- read.table("raw data/AncestryDNA_RM.txt", sep="\t", header=TRUE,row.names=1)



###############################################
###############################################
###############################################
### Function used inside phase_alleles for hets
phase_hets <- function(marker, hets_to_phase, par1, par2){
  
  print(marker)
  pars <- c(par1[marker,c('allele1','allele2')],par2[marker,c('allele1','allele2')])
  gtmatches <- c(as.numeric(hets_to_phase[marker,'allele1'] == pars),hets_to_phase[marker,'allele2'] == pars)
  
  hets_to_phase[marker,'allele2'] == par1[marker,'allele2']
  hets_to_phase[marker,'allele1'] == par2[marker,'allele1']
  hets_to_phase[marker,'allele2'] == par2[marker,'allele2']
  
  p1p2a = list(gtm = c(1,0,0,0,0,1,1,1), out=c('par1','par2'))
  p1p2b = list(gtm = c(1,1,0,1,0,0,1,0), out=c('par1','par2'))
  p2p1a = list(gtm = c(1,0,1,1,0,1,0,0), out=c('par2','par1'))
  p2p1b = list(gtm = c(0,0,0,1,1,1,1,1), out=c('par2','par1'))
  
  all_comb <- list(p1p2a,p1p2b,p2p1a,p2p1b)
  names(all_comb) <- c('p1p2a','p1p2b','p2p1a','p2p1b')
  
  out_gt <- names(which.max(lapply(all_comb, function(x, tomatch = gtmatches){ sum(tomatch==x[['gtm']]) })))
  
  out_het <- unlist(all_comb[[out_gt]]['out'])
  names(out_het) <- c('allele1_lin','allele2_lin')
  
  out_het <- data.frame(cbind(hets_to_phase[marker,], allele1_lin = out_het['allele1_lin'], allele2_lin = out_het['allele2_lin']))
  out_het$par1_gt <- ifelse( out_het$allele1_lin == 'par1',  out_het$allele1,  out_het$allele2)
  out_het$par2_gt <- ifelse( out_het$allele2_lin == 'par1',  out_het$allele1,  out_het$allele2)
  
  return(out_het)
} 



###############################################
###############################################
###############################################
phase_alleles <- function(tophase, par1, par2){
  
  ## all myhets to phase
  myhets <- tophase[!tophase$allele1 == tophase$allele2,]
  par1_myhets <- par1[rownames(myhets),]
  par2_myhets <- par2[rownames(myhets),]
    
  # of the snps that are hets in tophase, get those that are homozygous in the parents (not enough markers alone tho)
  par1_homz <- par1_myhets[par1_myhets$allele1==par1_myhets$allele2,]
  par2_homz <- par2_myhets[par2_myhets$allele1==par2_myhets$allele2,]
  
  ## of the snps that are hets in tophase, of myhets are homzygous ref in one parent, alt in the other
  hom_hom <- intersect(rownames(par1_homz), rownames(par2_homz))
  par1_homz_out <- par1_homz[hom_hom,]  
  par2_homz_out <- par2_homz[hom_hom,]
  myhets_homs <- myhets[hom_hom,]
  
  # annotate my het genotypes as the parent they came from
  myhets_homs$allele1_lin <- ifelse(myhets_homs$allele1 == par1_homz_out$allele1, 'par1','par2')
  myhets_homs$allele2_lin <- ifelse(myhets_homs$allele2 == par1_homz_out$allele1, 'par1','par2')
  
  myhets_homs$par1_gt <- ifelse(myhets_homs$allele1_lin == 'par1', myhets_homs$allele1, myhets_homs$allele2)
  myhets_homs$par2_gt <- ifelse(myhets_homs$allele2_lin == 'par1', myhets_homs$allele1, myhets_homs$allele2)
  
  ### myhets_homs out
  
  par1_het_par2_homz <- par1[!par1$allele1 == par1$allele2,]
  par1_het_par2_homz <- par1_het_par2_homz[which(rownames(par1_het_par2_homz) %in% rownames(par2_homz)),]
  
  par2_het_par1_homz <- par2[!par2$allele1 == par2$allele2,]
  par2_het_par1_homz <- par2_het_par1_homz[which(rownames(par2_het_par1_homz) %in% rownames(par1_homz)),]
  
  ## of the snps that are hets in tophase, of myhets are het in one parent, homoz in the other
  het_hom <- intersect(rownames(myhets), c(rownames(par2_het_par1_homz),rownames(par1_het_par2_homz)))

  ## apply the phase het function. takes a long time

  hets_outs <- lapply(het_hom, phase_hets, hets_to_phase = myhets, par1 = par1_myhets, par2 = par2_myhets)
  
  myhets_hets <- do.call(rbind,hets_outs)

  
  out <- rbind(myhets_hets,myhets_homs)
  out <- out[rownames(tophase)[rownames(tophase) %in% rownames(out)],]
  
  return(out)
}
###############################################
###############################################
###############################################

## runniung the functions

plot_chromsome <- function(chrom){

  me_phased <- phase_alleles(tophase = me[me$chromosome == chrom,], par1 = mom, par2 = dad)
  par1_phased <- phase_alleles(tophase = mom[mom$chromosome == chrom,], par1 = mgm, par2 = mgf)

  par1_markers <- rownames(me_phased)[rownames(me_phased) %in% rownames(par1_phased)]

  me_p1_out <- data.frame(
    me_phased[par1_markers,c('chromosome','position','par1_gt')], 
    p1_allele_1 = par1_phased[par1_markers,'par1_gt'], 
    p1_allele_2 = par1_phased[par1_markers,'par2_gt']
    )


  me_p1_out$myphase <- ifelse(me_p1_out$par1_gt == me_p1_out$p1_allele_1,'par1','par2')
  me_p1_out$plotpoint <- ifelse(me_p1_out$par1_gt == me_p1_out$p1_allele_1,0.5,1.5)
  me_p1_out$cols <- ifelse(me_p1_out$par1_gt == me_p1_out$p1_allele_1,'red','blue')

  png(paste(chrom,'_chromosome.png'))
  plot(me_p1_out$plotpoint,me_p1_out$position, col = me_p1_out$cols, xlim = c(0,2), pch = 16, main = paste('chromosome', chrom))
  dev.off()
  
  write.csv(me_p1_out, paste(chrom,'_chromosome.csv'))
  
}
  
  
plot_chromsome(chrom = 23)
  
save.image('phasing_done.rsave')

