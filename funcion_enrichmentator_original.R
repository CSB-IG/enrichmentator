enrichmentator<-function(x){
#x<-comunidad, as character vector
comunidad<-x
nombre_comunidad<-deparse(substitute(x))
#Enriquecimiento de comunidades

#librerias que necesitas 
library(org.Hs.eg.db)
library(KEGG.db)
library(HTSanalyzeR)

#input: character string 
#comunidad<-read.csv(comunidad.csv)

#pasar comunidad de gene symbol a entrez
comunidad_num<-rep(1, length(comunidad))
names(comunidad_num)<-comunidad

COMUNIDAD_ENTREZ<-annotationConvertor(geneList = comunidad_num, species = "Hs", initialIDs = "Symbol", finalIDs = "Entrez.gene")
COMUNIDAD_ENTREZ<-names(COMUNIDAD_ENTREZ)

#leer una matriz de expresión, con los gene symbols

matriz_nombres_genes <- read.table("/home/sergio/documents/COMUNIDADES_SUBTIPOS/matriz_nombres_genes.csv", row.names = 1, header=TRUE, quote="\"", stringsAsFactors=FALSE)
matrix<-as.matrix(matriz_nombres_genes)
matrix<-as.numeric(matrix)
names(matrix)<-rownames(matriz_nombres_genes)

#tener el universo de genes (todos los genes del chip) en entrez
universo<-annotationConvertor(geneList = matrix, species = "Hs", initialIDs = "Symbol", finalIDs = "Entrez.gene")
universo<-names(universo)

# lista de KEGGS

library(KEGG.db)
GS_KEGG<-KeggGeneSets(species = "Hs")

# lista de GOs 

library(GO.db)
GS_GO_CC<-GOGeneSets(species="Hs",ontologies=c("CC"))
GS_GO_MF<-GOGeneSets(species="Hs",ontologies=c("MF"))
GS_GO_BP<-GOGeneSets(species="Hs",ontologies=c("BP"))                    

#hacer el enriquecimiento de comunidades - KEGG
hypgeoResults_kegg <- multiHyperGeoTest(collectionOfGeneSets= GS_KEGG,
                                        universe= universo, hits= COMUNIDAD_ENTREZ, minGeneSetSize = 15, pAdjustMethod = "BH")
resultados_kegg<-as.data.frame(hypgeoResults_kegg)

#cortar solo por Adj.Pvalue < 0.001
resultados_kegg_significativos<-resultados_kegg[resultados_kegg$Adjusted.Pvalue < 0.001,]
#sacarlos con nombre_de_kegg pathway
rownames(resultados_kegg_significativos)<-str_replace(string = rownames(resultados_kegg_significativos), pattern = "hsa", replacement = "")
diccionario_kegg<-as.list(KEGGPATHID2NAME)
rownames(resultados_kegg_significativos)<-diccionario_kegg[rownames(resultados_kegg_significativos)]
#escribir_tabla
nombre_kegg<-paste0("comunidad_kegg_", nombre_comunidad)
write.table(resultados_kegg_significativos, file = nombre_kegg, sep ="\t", col.names = NA, row.names = TRUE)

#repetir para los tres tipos de GO

#hacer el enriquecimiento de comunidades - GS_GO_MF
hypgeoResults_GS_GO_MF <- multiHyperGeoTest(collectionOfGeneSets= GS_GO_MF,
                                            universe= universo, hits= COMUNIDAD_ENTREZ, minGeneSetSize = 15, pAdjustMethod = "BH")
resultados_GS_GO_MF<-as.data.frame(hypgeoResults_GS_GO_MF)

#cortar solo por Adj.Pvalue < 0.001
resultados_GS_GO_MF_significativos<-resultados_GS_GO_MF[resultados_GS_GO_MF$Adjusted.Pvalue < 0.001,]
rownames(resultados_GS_GO_MF_significativos)<-Term(rownames(resultados_GS_GO_MF_significativos))
#escribir_tabla
nombre_GS_GO_MF<-paste0("comunidad_GS_GO_MF_", nombre_comunidad)
write.table(resultados_GS_GO_MF_significativos, file = nombre_GS_GO_MF, sep ="\t", col.names = NA, row.names = TRUE)

#hacer el enriquecimiento de comunidades - GS_GO_BP
hypgeoResults_GS_GO_BP <- multiHyperGeoTest(collectionOfGeneSets= GS_GO_BP,
                                            universe= universo, hits= COMUNIDAD_ENTREZ, minGeneSetSize = 15, pAdjustMethod = "BH")
resultados_GS_GO_BP<-as.data.frame(hypgeoResults_GS_GO_BP)

#cortar solo por Adj.Pvalue < 0.001
resultados_GS_GO_BP_significativos<-resultados_GS_GO_BP[resultados_GS_GO_BP$Adjusted.Pvalue < 0.001,]
rownames(resultados_GS_GO_BP_significativos)<-Term(rownames(resultados_GS_GO_BP_significativos))
#escribir_tabla
nombre_GS_GO_BP<-paste0("comunidad_GS_GO_BP_", nombre_comunidad)
write.table(resultados_GS_GO_BP_significativos, file = nombre_GS_GO_BP, sep ="\t", col.names = NA, row.names = TRUE)

#hacer el enriquecimiento de comunidades - GS_GO_CC
hypgeoResults_GS_GO_CC <- multiHyperGeoTest(collectionOfGeneSets= GS_GO_CC,
                                            universe= universo, hits= COMUNIDAD_ENTREZ, minGeneSetSize = 15, pAdjustMethod = "BH")
resultados_GS_GO_CC<-as.data.frame(hypgeoResults_GS_GO_CC)

#cortar solo por Adj.Pvalue < 0.001
resultados_GS_GO_CC_significativos<-resultados_GS_GO_CC[resultados_GS_GO_CC$Adjusted.Pvalue < 0.001,]
rownames(resultados_GS_GO_CC_significativos)<-Term(rownames(resultados_GS_GO_CC_significativos))
#escribir_tabla
nombre_GS_GO_CC<-paste0("comunidad_GS_GO_CC_", nombre_comunidad)
write.table(resultados_GS_GO_CC_significativos, file = nombre_GS_GO_CC, sep ="\t", col.names = NA, row.names = TRUE)
}