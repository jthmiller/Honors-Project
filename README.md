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




To interpret each of these figures, one must know that the x-axis is the maternal or paternal label, where par1 is the maternal DNA, and par2 is the paternal DNA. The 0.5 position on the x-axis displays the grandmother DNA of the corresponding parent shaded in red, and the 1.5 position on the x-axis displays the grandfather DNA of the corresponding parent shaded in blue.

Anywhere there is an overlap in genetic data in one of these figures between the corresponding grandparents is representative of the potential range of SNP’s that a recombination event could have occurred on when my mother’s egg cell or my father’s sperm cell were going through homologous recombination during meiosis. The reason for this overlap is because we simply do not have enough genetic markers in the dataset to know the exact location of the recombination event. As the number of known of genetic markers increases, the resolution of the known origin of grandparent level DNA would also increase, so if we were to have more markers in this range of overlap, the length of the genetic overlap between grandparents would decrease, and our confidence interval for the exact genetic location of the recombination event would increase. Any holes, gaps or noise in these data are to due missing parts of the raw DNA code that was a result of human error while the saliva samples were being collected for genetic testing.


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