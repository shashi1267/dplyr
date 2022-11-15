#Setting the working directory either through session menu or through the console 
getwd()
setwd("/Users/shashismac/Downloads")
getwd()

#install.packages("dplyr") 
#install.packages("readxl")
install.packages("dplyr")
library(dplyr)
library(readxl)
 
#Loading data
hg = read_excel("Human_genome.xlsx")
View(hg)

#Q1. Which chromosome has maximum size 
#select, arrange, slice
hg1 = hg %>%
select(Chromosome,`Base Pairs`) %>%
arrange(desc(`Base Pairs`)) %>%
slice(1)  
View(hg1)

#Q2. List of chromosomes with more than 500 pseudogenes and     more than 1000 protein coding genes 
#Filter
hg2 = hg %>%
filter(Pseudogenes>500,`Protein Coding genes`>1000)
View(hg2)

#Q3. Which 10 Chromosomes have the highest protein coding gene density (Genes per magebase)
#Mutate 
hg3 = hg %>%
mutate(genes_per_mb=(`Protein Coding genes`/(`Base Pairs`/1000000)))
View(hg3)
#Arrange and select and slice
hg4 = hg3 %>%
arrange(desc(genes_per_mb)) %>%
select(Chromosome,genes_per_mb) %>%
slice(1:10)
View(hg4)

#Q4. Calculate the mean of gene density for autosomes, sex chromosomes and mitochondrial genome 
View(hg)
names = rep("A",22)
hg5 = hg3 %>%
mutate(Type=c(names,"S","S","M"))
View(hg5)

hg6 = hg5 %>%
group_by(Type) %>%  
summarise(gene_density=mean(genes_per_mb))
View(hg6)