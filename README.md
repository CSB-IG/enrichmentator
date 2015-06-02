# enrichmentator

#####Enrichmentator is a tool to perform systematical enrichment analysis of gene sets.
#####Enrichmentator is written in R 
#####It currently supports Gene Ontology and KEGG pathway data.
#####Input is a text file containing the genes in a gene set. 
#####Output is a collection of four csv files containing the results of hypergeometric tests for categories on each database
#####Enrichmentator is being developed to study community structure in breast cancer gene regulatory networks. 
#####A universe of genes measured is needed for Enrichmentator.  
######matriz_nombres_genes.csv is provided for experiments derived from the HGU133A platform.
####Enrichmentator uses the following R packages: HTSanalyzeR, org.Hs.eg.db, KEGG.db, stringr.
#####enrichmentator_required_libraries.R will install these libraries

### TO DO:

##### Enrichmentator must be able to read multiple communities. 
##### Enrichmentator could be used upon other process databases. 

######Share and Enjoy. 
