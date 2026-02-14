# Honors-Project
Identifying which alleles came from each grandparent, and looking for the origins of genotypes &amp; phenotypes of interest.

# Markdown cheat-sheet
Markdown [this repo](https://github.com/adam-p/markdown-here/wiki/markdown-cheatsheet)

# SNP Identification Logic Diagrams


![logicDiagram1](./Logic_Diagrams/Figure_1_GEN_Honors_Project.png?raw=true)

Figure 1. Homozygosity Logic Diagram. Representative of Every SNP where I am Heterozygous, and Both of My Parents are Homozygous.




![logicDiagram2](./Logic_Diagrams/Figure_2_GEN_Honors_Project.png?raw=true)

Figure 2. Heterozygosity Logic Diagram. Representative of Every SNP where I am Heterozygous, One of My Parents is Homozygous, and the Other Parent is Heterozygous.




![logicDiagram3](./Logic_Diagrams/Figure_3_GEN_Honors_Project.png?raw=true)

Figure 3. Multigenerational Logic Diagram. Representative of Every SNP where I am Heterozygous, One of My Parents are Heterozygous, and One or Both Corresponding Grandparents are Homozygous.




To find genetic markers in my genome, I would have to first complete what is called “phasing”, where I have the “R Studio” coding software look for locations in my genome known as SNPs where my genotype is heterozygous, and at least one of my parents is homozygous.

Figure 1 visually demonstrates how if we know the homozygous genotypes of both parents at the same biallelic SNP where I am heterozygous, then there is a 100% chance that each of their progeny would the same genotype at that SNP, and we would know exactly which parent contributed each allele.

Figure 2 visually demonstrates how if we know the heterozygous genotype of one parent, and the homozygous genotype of the other parent at the same biallelic SNP where I am heterozygous, then we can conclude that the less frequent allele for the SNP came from the parent also carried the heterozygous genotype. This means that id we can confirm which parent contributed one of the alleles, then that would mean that the other parent by default contributed the second allele, since we know from Mendelian Inheritance Patterns that each parent would have had to contribute one allele for every SNP of the genome.

Figure 3 visually demonstrates how if we take the same logic from figures 1 and 2, and apply to it determine allele contribution at the grandparent level, we could conclude at a single biallelic SNP which grandparent contributed which allele to the corresponding parent, only if genetic data for both grandparents on corresponding parent’s side are available, and both of the grandparents are homozygous were the corresponding parent is heterozygous at the same SNP. Now, if at that same SNP the second parent is homozygous where I am also heterozygous, then not only will I be able to know which parent the other less frequent alle came from, but also which grandparent on that corresponding side the allele came from, allowing us to find genetic markers in my genome to further identify which genes came from which grandparent.

With just a few genetic markers (~5% of then genome according to R Studio), we can then make some safe estimate with a range of ~70% to ~80% confidence that all the SNPs in between the two markers can be identified based on the grandparent that contributed that allele. The two ways to identify which grandparent contributed each gene would be first, if two consecutive markers were confirmed to have come from the same grandparent, which means that according to linkage theory, all the SNP in between them were most likely also from that grandparent, or second, if two consecutive markers were confirmed to have come from two different corresponding grandparents, and that would mean that some where in between those two same markers, a recombination event took place in that approximate genetic location, during the meiotic process of the egg or sperm cell that would have eventually contributed to fertilization process responsible for the birth of my genome.




# Genome Plots Color Coded By Grandparent of Origin


![chr1](./Plots/1_chromosome.png?raw=true)

Figure 4. Maternal Copy of Chromosome 1




![chr2](./Plots/2_chromosome.png?raw=true)

Figure 5. Maternal Copy of Chromosome 2




![chr3](./Plots/3_chromosome.png?raw=true)

Figure 6. Maternal Copy of Chromosome 3




![chr4](./Plots/4_chromosome.png?raw=true)

Figure 7. Maternal Copy of Chromosome 4




![chr5](./Plots/5_chromosome.png?raw=true)

Figure 8. Maternal Copy of Chromosome 5




![chr6](./Plots/6_chromosome.png?raw=true)

Figure 9. Maternal Copy of Chromosome 6




![chr7](./Plots/7_chromosome.png?raw=true)

Figure 10. Maternal Copy of Chromosome 7




![chr8](./Plots/8_chromosome.png?raw=true)

Figure 11. Maternal Copy of Chromosome 8




![chr9](./Plots/9_chromosome.png?raw=true)

Figure 12. Maternal Copy of Chromosome 9




![chr10](./Plots/10_chromosome.png?raw=true)

Figure 13. Maternal Copy of Chromosome 10




![chr11](./Plots/11_chromosome.png?raw=true)

Figure 14. Maternal Copy of Chromosome 11




![chr12](./Plots/12_chromosome.png?raw=true)

Figure 15. Maternal Copy of Chromosome 12




![chr13](./Plots/13_chromosome.png?raw=true)

Figure 16. Maternal Copy of Chromosome 13




![chr14](./Plots/14_chromosome.png?raw=true)

Figure 17. Maternal Copy of Chromosome 14




![chr15](./Plots/15_chromosome.png?raw=true)

Figure 18. Maternal Copy of Chromosome 15




![chr16](./Plots/16_chromosome.png?raw=true)

Figure 19. Maternal Copy of Chromosome 16




![chr17](./Plots/17_chromosome.png?raw=true)

Figure 20. Maternal Copy of Chromosome 17




![chr18](./Plots/18_chromosome.png?raw=true)

Figure 21. Maternal Copy of Chromosome 18




![chr19](./Plots/19_chromosome.png?raw=true)

Figure 22. Maternal Copy of Chromosome 19




![chr20](./Plots/20_chromosome.png?raw=true)

Figure 23. Maternal Copy of Chromosome 20




![chr21](./Plots/21_chromosome.png?raw=true)

Figure 24. Maternal Copy of Chromosome 21




![chr22](./Plots/22_chromosome.png?raw=true)

Figure 25. Maternal Copy of Chromosome 22




To interpret each of these figures, one must know that the x-axis is the maternal or paternal label, where par1 is the maternal DNA, and par2 is the paternal DNA. The 0.5 position on the x-axis displays the grandmother DNA of the corresponding parent shaded in red, and the 1.5 position on the x-axis displays the grandfather DNA of the corresponding parent shaded in blue.

Anywhere there is an overlap in genetic data in one of these figures between the corresponding grandparents is representative of the potential range of SNP’s that a recombination event could have occurred on when my mother’s egg cell or my father’s sperm cell were going through homologous recombination during meiosis. The reason for this overlap is because we simply do not have enough genetic markers in the dataset to know the exact location of the recombination event. As the number of known of genetic markers increases, the resolution of the known origin of grandparent level DNA would also increase, so if we were to have more markers in this range of overlap, the length of the genetic overlap between grandparents would decrease, and our confidence interval for the exact genetic location of the recombination event would increase. Any holes, gaps or noise in these data are to due missing parts of the raw DNA code that was a result of human error while the saliva samples were being collected for genetic testing.