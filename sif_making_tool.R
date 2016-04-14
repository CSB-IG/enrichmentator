#Takes the output of the "Columnator" script to clean up manual annotation of "Enrichmentator"
#Returns SIF-files
#read the community-process relation files
rel_comms_kegg <- read.csv("rel_comms_kegg", row.names=1, stringsAsFactors=FALSE)
rel_comms_gobp <- read.csv("rel_comms_gobp", row.names=1, stringsAsFactors=FALSE)
rel_comms_gocc <- read.csv("rel_comms_gocc", row.names=1, stringsAsFactors=FALSE)
rel_comms_gomf <- read.csv("rel_comms_gomf", row.names=1, stringsAsFactors=FALSE)

#sif making functions 
makeSIF <- function(x) {
  # args - 
  #    x - m*m distance or correlation matrix
  # @returns data frame in SIF format 
  #
  sif <- as.data.frame(t(combn(as.character(rownames(x)), 2)))
  #print(sif)
  weight <- apply(sif, 1, indexDMatFromLookup, x)
  sif2 <- data.frame(sif, weight)
  return(sif2)
  
}

indexDMatFromLookup <- function(lookup, x) {
  return(indexDMat(x, lookup[1], lookup[2]))
}

indexDMat <- function(x, i1,i2) {
  return(x[i1,i2])
}

##
#Sify_nxm : Experimental; for NxM matrix

sify_nxm <- function(x) {
  # args - 
  #    x - m*m distance or correlation matrix
  # @returns data frame in SIF format 
  #
  sif <- expand.grid(rownames(x), colnames(x))
  #print(sif)
  weight <- apply(sif, 1, indexDMatFromLookup, x)
  sif2 <- data.frame(sif, weight)
  return(sif2)
  
}

#make SIF files

x<-sify_nxm(rel_comms_gobp)
x<-x[x$weight==1,]
x<-x[!is.na(x$weight),]
write.table(x, file = "relation_comm_gobp.txt", row.names = FALSE, quote = FALSE)

x<-sify_nxm(rel_comms_gocc)
x<-x[x$weight==1,]
x<-x[!is.na(x$weight),]
write.table(x, file = "relation_comm_gocc.txt", row.names = FALSE, quote = FALSE)

x<-sify_nxm(rel_comms_gomf)
x<-x[x$weight==1,]
x<-x[!is.na(x$weight),]
write.table(x, file = "relation_comm_gomf.txt", row.names = FALSE, quote = FALSE)

x<-sify_nxm(rel_comms_kegg)
x<-x[x$weight==1,]
x<-x[!is.na(x$weight),]
write.table(x, file = "relation_comm_kegg.txt", row.names = FALSE, quote = FALSE)