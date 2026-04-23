# Honors-Project
Identifying which alleles came from each grandparent, and looking for the origins of genotypes &amp; phenotypes of interest.

# Markdown cheat-sheet
Markdown [this repo](https://github.com/adam-p/markdown-here/wiki/markdown-cheatsheet)

# SNP Identification Logic Diagrams

To find genetic ancestral markers in my genome, I would have to first complete a logical procedure with my raw genetic data known as “phasing”, where I have the “R Studio” coding software look for locations in my genome known as SNPs where both my genotype is heterozygous, and at least one of my parents is homozygous.




![logicDiagram1](./Logic_Diagrams/Figure_1_GEN_Honors_Project.png?raw=true)

Figure 1. Homozygosity Logic Diagram. Representative of Every SNP where I am Heterozygous, and Both of My Parents are Homozygous.



Figure 1 visually demonstrates how if we know the homozygous genotypes of both parents at the same biallelic SNP where I am heterozygous, then there is a 100% chance that each of their progeny would the same genotype at that SNP, and we would know exactly which parent contributed each allele.




![logicDiagram2](./Logic_Diagrams/Figure_2_GEN_Honors_Project.png?raw=true)

Figure 2. Heterozygosity Logic Diagram. Representative of Every SNP where I am Heterozygous, One of My Parents is Homozygous, and the Other Parent is Heterozygous.



Figure 2 visually demonstrates how if we know the heterozygous genotype of one parent, and the homozygous genotype of the other parent at the same biallelic SNP where I am heterozygous, then we can conclude that the less frequent allele for the SNP came from the parent also carried the heterozygous genotype. This means that I'd we can confirm which parent contributed one of the alleles, then that would mean that the other parent by default contributed the second allele, since we know from Mendelian Inheritance Patterns that each parent would have had to contribute one allele for every SNP of the genome.




![logicDiagram3](./Logic_Diagrams/Figure_3_GEN_Honors_Project.png?raw=true)

Figure 3. Multigenerational Logic Diagram. Representative of Every SNP where I am Heterozygous, One of My Parents are Heterozygous, and One or Both Corresponding Grandparents are Homozygous.



Figure 3 visually demonstrates how if we take the same logic from figures 1 and 2, and apply it to determine allele contribution at the grandparent level, we could identify at a single biallelic SNP the grandparent of origin for each allele to the corresponding parent. For this to work, the SNP of interest must follow the following parameters:

My gentoype is heterozygous.

Parent corresponding to grandparents is heterozygous.

Parant not corresponding to grandparents is homozygous.

If the raw genetic data for both grandparents on the corresponding parent’s side are available, you could find potential ancestral markers at the same SNP if the genotypes were the following:

Both of the grandparents are homozygous.

One corresponding grandparent is heterozygous.



# Identifying SNPs to their Grandparent of Origin

If the genome for only one of the corresponding grandparents is available, the only way to locate ancestral genetic markers for this scenario is to find any SNP where I am heterozygous, my parent is heterozygous, and the one tested grandparent is homozygous. These parameters allow me to identify which SNP came from either the tested grandparent directly, or the not tested grandparent by using process of elimination. With this information, I could visually demonstrate that if I inherited a base from my parent, but not from the corresponding grandparent with the tested genome, that would confirm that the base came from the other corresponding grandparent that never got their genome sequenced and added to the data. You will notice looking at the Raw Data Files that one o fmy grandparents' genomes is missing, so this logic comes in handy to accomodate the missing genetic data.

These extremely specific parameters allow us to know two different things. One, exactly which parent the less frequent allele of the biallelic SNP came from, and two, exactly which grandparent is the origin of that same SNP as well as entire allele that was directly inherited to me through my parents. This allows me to trace the genetic markers in my genome back two more generations, ultimately identifying which genes came from which of my four grandparents.

With just a few genetic markers (~5% of then genome according to R Studio), we can then make safe estimates with a range of ~70% to ~80% confidence that all the SNPs in between the two markers can be identified based on the grandparent that contributed that allele. Knowing this, there are two methods to identifying which grandparent contributed each of my genes. First, if two consecutive markers were confirmed to have originate from the same grandparent, all the SNPs in between them were most likely also coming from the same grandparent, according to a linkage theory that suggests the homologous recombination does not occur on each chromosome very often. Second, if two consecutive markers were confirmed to have come from two different corresponding grandparents, that suggests that somewhere in between those markers, a recombination event took place in that approximate genetic location during the meiotic process of the egg and sperm cells that eventually contributed to the zygotic fertilization process responsible for the creation of my individualized genome.




# Genome Plots Color Coded By Grandparent of Origin

| Maternal Side | Paternal Side |
| :---: | :---: |
| ![Maternal Side](./Maternal_Plots/1_maternal_chromosome.png?raw=true) | ![Paternal Side](./Paternal_Plots/1_paternal_chromosome.png?raw=true) |
| Figure 4. Maternal Copy of Chromosome 1 | Figure 5. Paternal Copy of Chromosome 1 |


| Maternal Side | Paternal Side |
| :---: | :---: |
| ![Maternal Side](./Maternal_Plots/2_maternal_chromosome.png?raw=true) | ![Paternal Side](./Paternal_Plots/2_paternal_chromosome.png?raw=true) |
| Figure 6. Maternal Copy of Chromosome 2 | Figure 7. Paternal Copy of Chromosome 2 |


| Maternal Side | Paternal Side |
| :---: | :---: |
| ![Maternal Side](./Maternal_Plots/3_maternal_chromosome.png?raw=true) | ![Paternal Side](./Paternal_Plots/3_paternal_chromosome.png?raw=true) |
| Figure 8. Maternal Copy of Chromosome 3 | Figure 9. Paternal Copy of Chromosome 3 |


| Maternal Side | Paternal Side |
| :---: | :---: |
| ![Maternal Side](./Maternal_Plots/4_maternal_chromosome.png?raw=true) | ![Paternal Side](./Paternal_Plots/4_paternal_chromosome.png?raw=true) |
| Figure 10. Maternal Copy of Chromosome 4 | Figure 11. Paternal Copy of Chromosome 4 |


| Maternal Side | Paternal Side |
| :---: | :---: |
| ![Maternal Side](./Maternal_Plots/5_maternal_chromosome.png?raw=true) | ![Paternal Side](./Paternal_Plots/5_paternal_chromosome.png?raw=true) |
| Figure 12. Maternal Copy of Chromosome 5 | Figure 13. Paternal Copy of Chromosome 5 |


| Maternal Side | Paternal Side |
| :---: | :---: |
| ![Maternal Side](./Maternal_Plots/6_maternal_chromosome.png?raw=true) | ![Paternal Side](./Paternal_Plots/6_paternal_chromosome.png?raw=true) |
| Figure 14. Maternal Copy of Chromosome 6 | Figure 15. Paternal Copy of Chromosome 6 |


| Maternal Side | Paternal Side |
| :---: | :---: |
| ![Maternal Side](./Maternal_Plots/7_maternal_chromosome.png?raw=true) | ![Paternal Side](./Paternal_Plots/7_paternal_chromosome.png?raw=true) |
| Figure 16. Maternal Copy of Chromosome 7 | Figure 17. Paternal Copy of Chromosome 7 |


| Maternal Side | Paternal Side |
| :---: | :---: |
| ![Maternal Side](./Maternal_Plots/8_maternal_chromosome.png?raw=true) | ![Paternal Side](./Paternal_Plots/8_paternal_chromosome.png?raw=true) |
| Figure 18. Maternal Copy of Chromosome 8 | Figure 19. Paternal Copy of Chromosome 8 |


| Maternal Side | Paternal Side |
| :---: | :---: |
| ![Maternal Side](./Maternal_Plots/9_maternal_chromosome.png?raw=true) | ![Paternal Side](./Paternal_Plots/9_paternal_chromosome.png?raw=true) |
| Figure 20. Maternal Copy of Chromosome 9 | Figure 21. Paternal Copy of Chromosome 9 |


| Maternal Side | Paternal Side |
| :---: | :---: |
| ![Maternal Side](./Maternal_Plots/10_maternal_chromosome.png?raw=true) | ![Paternal Side](./Paternal_Plots/10_paternal_chromosome.png?raw=true) |
| Figure 22. Maternal Copy of Chromosome 10 | Figure 23. Paternal Copy of Chromosome 10 |


| Maternal Side | Paternal Side |
| :---: | :---: |
| ![Maternal Side](./Maternal_Plots/11_maternal_chromosome.png?raw=true) | ![Paternal Side](./Paternal_Plots/11_paternal_chromosome.png?raw=true) |
| Figure 24. Maternal Copy of Chromosome 11 | Figure 25. Paternal Copy of Chromosome 11 |


| Maternal Side | Paternal Side |
| :---: | :---: |
| ![Maternal Side](./Maternal_Plots/12_maternal_chromosome.png?raw=true) | ![Paternal Side](./Paternal_Plots/12_paternal_chromosome.png?raw=true) |
| Figure 26. Maternal Copy of Chromosome 12 | Figure 27. Paternal Copy of Chromosome 12 |


| Maternal Side | Paternal Side |
| :---: | :---: |
| ![Maternal Side](./Maternal_Plots/13_maternal_chromosome.png?raw=true) | ![Paternal Side](./Paternal_Plots/13_paternal_chromosome.png?raw=true) |
| Figure 28. Maternal Copy of Chromosome 13 | Figure 29. Paternal Copy of Chromosome 13 |


| Maternal Side | Paternal Side |
| :---: | :---: |
| ![Maternal Side](./Maternal_Plots/14_maternal_chromosome.png?raw=true) | ![Paternal Side](./Paternal_Plots/14_paternal_chromosome.png?raw=true) |
| Figure 30. Maternal Copy of Chromosome 14 | Figure 31. Paternal Copy of Chromosome 14 |


| Maternal Side | Paternal Side |
| :---: | :---: |
| ![Maternal Side](./Maternal_Plots/15_maternal_chromosome.png?raw=true) | ![Paternal Side](./Paternal_Plots/15_paternal_chromosome.png?raw=true) |
| Figure 32. Maternal Copy of Chromosome 15 | Figure 33. Paternal Copy of Chromosome 15 |


| Maternal Side | Paternal Side |
| :---: | :---: |
| ![Maternal Side](./Maternal_Plots/16_maternal_chromosome.png?raw=true) | ![Paternal Side](./Paternal_Plots/16_paternal_chromosome.png?raw=true) |
| Figure 34. Maternal Copy of Chromosome 16 | Figure 35. Paternal Copy of Chromosome 16 |


| Maternal Side | Paternal Side |
| :---: | :---: |
| ![Maternal Side](./Maternal_Plots/17_maternal_chromosome.png?raw=true) | ![Paternal Side](./Paternal_Plots/17_paternal_chromosome.png?raw=true) |
| Figure 36. Maternal Copy of Chromosome 17 | Figure 37. Paternal Copy of Chromosome 17 |


| Maternal Side | Paternal Side |
| :---: | :---: |
| ![Maternal Side](./Maternal_Plots/18_maternal_chromosome.png?raw=true) | ![Paternal Side](./Paternal_Plots/18_paternal_chromosome.png?raw=true) |
| Figure 38. Maternal Copy of Chromosome 18 | Figure 39. Paternal Copy of Chromosome 18 |


| Maternal Side | Paternal Side |
| :---: | :---: |
| ![Maternal Side](./Maternal_Plots/19_maternal_chromosome.png?raw=true) | ![Paternal Side](./Paternal_Plots/19_paternal_chromosome.png?raw=true) |
| Figure 40. Maternal Copy of Chromosome 19 | Figure 41. Paternal Copy of Chromosome 19 |


| Maternal Side | Paternal Side |
| :---: | :---: |
| ![Maternal Side](./Maternal_Plots/20_maternal_chromosome.png?raw=true) | ![Paternal Side](./Paternal_Plots/20_paternal_chromosome.png?raw=true) |
| Figure 42. Maternal Copy of Chromosome 20 | Figure 43. Paternal Copy of Chromosome 20 |


| Maternal Side | Paternal Side |
| :---: | :---: |
| ![Maternal Side](./Maternal_Plots/21_maternal_chromosome.png?raw=true) | ![Paternal Side](./Paternal_Plots/21_paternal_chromosome.png?raw=true) |
| Figure 44. Maternal Copy of Chromosome 21 | Figure 45. Paternal Copy of Chromosome 21 |


| Maternal Side | Paternal Side |
| :---: | :---: |
| ![Maternal Side](./Maternal_Plots/22_maternal_chromosome.png?raw=true) | ![Paternal Side](./Paternal_Plots/22_paternal_chromosome.png?raw=true) |
| Figure 46. Maternal Copy of Chromosome 22 | Figure 47. Paternal Copy of Chromosome 22 |


| Maternal Side | Paternal Side |
| :---: | :---: |
| ![Maternal Side](./Maternal_Plots/X_maternal_chromosome.png?raw=true) | ![Paternal Side](./Paternal_Plots/Y_paternal_chromosome.png?raw=true) |
| Figure 48. Maternal Chromosome X | Figure 49. Paternal Chromosome Y |

| Maternal Side | Paternal Side |
| :---: | :---: |
| ![Maternal Side](./Maternal_Plots/PAR_maternal_chromosome.png?raw=true) | ![Paternal Side](./Paternal_Plots/PAR_paternal_chromosome.png?raw=true) |
| Figure 48. Maternal Chromosome PAR | Figure 49. Paternal Chromosome PAR |

| Maternal Side |
| :---: |
| ![Maternal Side](./Maternal_Plots/Mitochondrial_DNA.png?raw=true) |
| Figure 50. Mitocnodrial Genome |




To interpret each of these figures, one must know that first, the y-axis is representative of the Genomic Position for each chromosome. Second, the x-axis is representative of the Grandparent of Origin for both maternal and paternal copies of each chromosome, where each corresponding parent is identified through both the plot titles and their figure names. The 0.5 position on the x-axis displays the grandmother DNA of the corresponding parent shaded in red, and the 1.5 position on the x-axis displays the grandfather DNA of the corresponding parent shaded in blue.

Anywhere there is an overlap in genetic data in one of these figures between the corresponding grandparents is representative of the potential range of SNP’s that a recombination event could have occurred on when my mother’s egg cell or my father’s sperm cell were going through homologous recombination during meiosis. The reason for this overlap is because we simply do not have enough genetic markers in the dataset to know the exact location of the recombination event. As the number of known of genetic markers increases, the resolution of the known origin for DNA at the grandparent level would also increase. So if we were to have more markers in this range of overlap, the length of the genetic overlap between grandparents would decrease, and our confidence interval for the exact genetic location of the recombination event would increase. Any holes, gaps or noise in these data are to due missing parts of the raw DNA code that was a result of human error while the saliva samples were being collected for genetic testing.


# GWAS Plots Color Coded By Grandparent of Origin

| Maternal Side | Paternal Side |
| :---: | :---: |
| ![Maternal Side](./Maternal_GWAS_Plots/1_Maternal_Map_Total_Clarity.png?raw=true) | ![Paternal Side](./Paternal_GWAS_Plots/1_Paternal_Map_Total_Clarity.png?raw=true) |
| Figure 51. Maternal Copy of Chromosome 1 | Figure 52. Paternal Copy of Chromosome 1 |


| Maternal Side | Paternal Side |
| :---: | :---: |
| ![Maternal Side](./Maternal_GWAS_Plots/2_Maternal_Map_Total_Clarity.png?raw=true) | ![Paternal Side](./Paternal_GWAS_Plots/2_Paternal_Map_Total_Clarity.png?raw=true) |
| Figure 53. Maternal Copy of Chromosome 2 | Figure 54. Paternal Copy of Chromosome 2 |


| Maternal Side | Paternal Side |
| :---: | :---: |
| ![Maternal Side](./Maternal_GWAS_Plots/3_Maternal_Map_Total_Clarity.png?raw=true) | ![Paternal Side](./Paternal_GWAS_Plots/3_Paternal_Map_Total_Clarity.png?raw=true) |
| Figure 55. Maternal Copy of Chromosome 3 | Figure 56. Paternal Copy of Chromosome 3 |


| Maternal Side | Paternal Side |
| :---: | :---: |
| ![Maternal Side](./Maternal_GWAS_Plots/4_Maternal_Map_Total_Clarity.png?raw=true) | ![Paternal Side](./Paternal_GWAS_Plots/4_Paternal_Map_Total_Clarity.png?raw=true) |
| Figure 57. Maternal Copy of Chromosome 4 | Figure 58. Paternal Copy of Chromosome 4 |


| Maternal Side | Paternal Side |
| :---: | :---: |
| ![Maternal Side](./Maternal_GWAS_Plots/5_Maternal_Map_Total_Clarity.png?raw=true) | ![Paternal Side](./Paternal_GWAS_Plots/5_Paternal_Map_Total_Clarity.png?raw=true) |
| Figure 59. Maternal Copy of Chromosome 5 | Figure 60. Paternal Copy of Chromosome 5 |


| Maternal Side | Paternal Side |
| :---: | :---: |
| ![Maternal Side](./Maternal_GWAS_Plots/6_Maternal_Map_Total_Clarity.png?raw=true) | ![Paternal Side](./Paternal_GWAS_Plots/6_Paternal_Map_Total_Clarity.png?raw=true) |
| Figure 61. Maternal Copy of Chromosome 6 | Figure 62. Paternal Copy of Chromosome 6 |


| Maternal Side | Paternal Side |
| :---: | :---: |
| ![Maternal Side](./Maternal_GWAS_Plots/7_Maternal_Map_Total_Clarity.png?raw=true) | ![Paternal Side](./Paternal_GWAS_Plots/7_Paternal_Map_Total_Clarity.png?raw=true) |
| Figure 63. Maternal Copy of Chromosome 7 | Figure 64. Paternal Copy of Chromosome 7 |


| Maternal Side | Paternal Side |
| :---: | :---: |
| ![Maternal Side](./Maternal_GWAS_Plots/8_Maternal_Map_Total_Clarity.png?raw=true) | ![Paternal Side](./Paternal_GWAS_Plots/8_Paternal_Map_Total_Clarity.png?raw=true) |
| Figure 65. Maternal Copy of Chromosome 8 | Figure 66. Paternal Copy of Chromosome 8 |


| Maternal Side | Paternal Side |
| :---: | :---: |
| ![Maternal Side](./Maternal_GWAS_Plots/9_Maternal_Map_Total_Clarity.png?raw=true) | ![Paternal Side](./Paternal_GWAS_Plots/9_Paternal_Map_Total_Clarity.png?raw=true) |
| Figure 67. Maternal Copy of Chromosome 9 | Figure 68. Paternal Copy of Chromosome 9 |


| Maternal Side | Paternal Side |
| :---: | :---: |
| ![Maternal Side](./Maternal_GWAS_Plots/10_Maternal_Map_Total_Clarity.png?raw=true) | ![Paternal Side](./Paternal_GWAS_Plots/10_Paternal_Map_Total_Clarity.png?raw=true) |
| Figure 69. Maternal Copy of Chromosome 10 | Figure 70. Paternal Copy of Chromosome 10 |


| Maternal Side | Paternal Side |
| :---: | :---: |
| ![Maternal Side](./Maternal_GWAS_Plots/11_Maternal_Map_Total_Clarity.png?raw=true) | ![Paternal Side](./Paternal_GWAS_Plots/11_Paternal_Map_Total_Clarity.png?raw=true) |
| Figure 71. Maternal Copy of Chromosome 11 | Figure 72. Paternal Copy of Chromosome 11 |


| Maternal Side | Paternal Side |
| :---: | :---: |
| ![Maternal Side](./Maternal_GWAS_Plots/12_Maternal_Map_Total_Clarity.png?raw=true) | ![Paternal Side](./Paternal_GWAS_Plots/12_Paternal_Map_Total_Clarity.png?raw=true) |
| Figure 73. Maternal Copy of Chromosome 12 | Figure 74. Paternal Copy of Chromosome 12 |


| Maternal Side | Paternal Side |
| :---: | :---: |
| ![Maternal Side](./Maternal_GWAS_Plots/13_Maternal_Map_Total_Clarity.png?raw=true) | ![Paternal Side](./Paternal_GWAS_Plots/13_Paternal_Map_Total_Clarity.png?raw=true) |
| Figure 75. Maternal Copy of Chromosome 13 | Figure 76. Paternal Copy of Chromosome 13 |


| Maternal Side | Paternal Side |
| :---: | :---: |
| ![Maternal Side](./Maternal_GWAS_Plots/14_Maternal_Map_Total_Clarity.png?raw=true) | ![Paternal Side](./Paternal_GWAS_Plots/14_Paternal_Map_Total_Clarity.png?raw=true) |
| Figure 77. Maternal Copy of Chromosome 14 | Figure 78. Paternal Copy of Chromosome 14 |


| Maternal Side | Paternal Side |
| :---: | :---: |
| ![Maternal Side](./Maternal_GWAS_Plots/15_Maternal_Map_Total_Clarity.png?raw=true) | ![Paternal Side](./Paternal_GWAS_Plots/15_Paternal_Map_Total_Clarity.png?raw=true) |
| Figure 79. Maternal Copy of Chromosome 15 | Figure 80. Paternal Copy of Chromosome 15 |


| Maternal Side | Paternal Side |
| :---: | :---: |
| ![Maternal Side](./Maternal_GWAS_Plots/16_Maternal_Map_Total_Clarity.png?raw=true) | ![Paternal Side](./Paternal_GWAS_Plots/16_Paternal_Map_Total_Clarity.png?raw=true) |
| Figure 81. Maternal Copy of Chromosome 16 | Figure 82. Paternal Copy of Chromosome 16 |


| Maternal Side | Paternal Side |
| :---: | :---: |
| ![Maternal Side](./Maternal_GWAS_Plots/17_Maternal_Map_Total_Clarity.png?raw=true) | ![Paternal Side](./Paternal_GWAS_Plots/17_Paternal_Map_Total_Clarity.png?raw=true) |
| Figure 83. Maternal Copy of Chromosome 17 | Figure 84. Paternal Copy of Chromosome 17 |


| Maternal Side | Paternal Side |
| :---: | :---: |
| ![Maternal Side](./Maternal_GWAS_Plots/18_Maternal_Map_Total_Clarity.png?raw=true) | ![Paternal Side](./Paternal_GWAS_Plots/18_Paternal_Map_Total_Clarity.png?raw=true) |
| Figure 85. Maternal Copy of Chromosome 18 | Figure 86. Paternal Copy of Chromosome 18 |


| Maternal Side | Paternal Side |
| :---: | :---: |
| ![Maternal Side](./Maternal_GWAS_Plots/19_Maternal_Map_Total_Clarity.png?raw=true) | ![Paternal Side](./Paternal_GWAS_Plots/19_Paternal_Map_Total_Clarity.png?raw=true) |
| Figure 87. Maternal Copy of Chromosome 19 | Figure 88. Paternal Copy of Chromosome 19 |


| Maternal Side | Paternal Side |
| :---: | :---: |
| ![Maternal Side](./Maternal_GWAS_Plots/20_Maternal_Map_Total_Clarity.png?raw=true) | ![Paternal Side](./Paternal_GWAS_Plots/20_Paternal_Map_Total_Clarity.png?raw=true) |
| Figure 89. Maternal Copy of Chromosome 20 | Figure 90. Paternal Copy of Chromosome 20 |


| Maternal Side | Paternal Side |
| :---: | :---: |
| ![Maternal Side](./Maternal_GWAS_Plots/21_Maternal_Map_Total_Clarity.png?raw=true) | ![Paternal Side](./Paternal_GWAS_Plots/21_Paternal_Map_Total_Clarity.png?raw=true) |
| Figure 91. Maternal Copy of Chromosome 21 | Figure 92. Paternal Copy of Chromosome 21 |


| Maternal Side | Paternal Side |
| :---: | :---: |
| ![Maternal Side](./Maternal_GWAS_Plots/22_Maternal_Map_Total_Clarity.png?raw=true) | ![Paternal Side](./Paternal_GWAS_Plots/22_Paternal_Map_Total_Clarity.png?raw=true) |
| Figure 93. Maternal Copy of Chromosome 22 | Figure 94. Paternal Copy of Chromosome 22 |

To interpret each of these figures, one must know that first, the y-axis is representative of the Genomic Position for each chromosome in units of Mega Bases. Second, the x-axis is representative of the Grandparent of Origin for both maternal and paternal copies of each chromosome, where each corresponding parent is identified through both the plot titles and their figure names. The 0.5 position on the x-axis displays the grandmother DNA of the corresponding parent shaded in red, and the 1.5 position on the x-axis displays the grandfather DNA of the corresponding parent shaded in blue. Each of the yellow circles labeled on the chromosomes is representative of a known genetic marker (SNP) for a disease trait that has been identified by the Genome Wide Association Studies (GWAS) as of 2026. Each of these yellow circles has a light gray lines coming off of it, connecting to the corresponding maroon colored text labels that identify what the trait is at that specific SNP.

Some the text labels are going to overlap, and this is because the name of the traits are so large that the text simply can not fit onto the graph without falling outside of the set x and y parameters of the GWAS plots. To solve this issue, I have also created two different .csv spreadsheet files for each copy of my 44 autosomal chromosomes. One simply identifies which grandparent gave me which SNP in my genome, identical to the first set of plots, and the second .csv file adds to that data information, by stating the genomic position of each genetic markers for all the traits, their rsid number, the base letter I inherited that creates a risk allele, and which grandparent it came from, but only if the rsid has both a known ancestral marker and a trait marker at the same location. What the plots are allowing me to do is visually identify which grandparent gave me all of these known risk alleles, even if there is no known ancestral marker at that SNP.