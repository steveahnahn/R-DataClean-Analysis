####################
#Ahn, Steve
#Principal Components Analysis - Dimension Reduction
##########################
data(iris)
X <- iris
names(X)
dim(X)
head(X)

### Grab features of interest
X <- as.matrix(iris[,1:4])
head(X)

## All variables are in the same unit,
## so only centering is needed - standardize
Xc <- scale(X, scale = F)
head(Xc)

#Sample variance

Sx=var(Xc)
head(Sx)

EP=eigen(Sx)
V=EP$vectors
head(V)

Lambda=EP$values
Lambda

# see what percent of variance
# is contained in each PC

cumsum(Lambda)/sum(Lambda)
PC=Xc%*%V
PC

### Loadings or correlations between the PC and the
### original variables.

round(cor(X,PC),2)

### Prepare for plot

PCframe=data.frame(PC, iris[,5])
attach(PCframe)
head(PCframe)

#Use jitter to add random noise for better viz
plot(jitter(PCframe[,1]),jitter(PCframe[,2]), xlab="PC1",ylab="PC2",type="n",main="First two PC (based on lecture) with labels")

text(PCframe[,1],PCframe[,2],labels=PCframe[,5],col=c("red"))

abline(h=0)
abline(v=0)


############Using R's prcomp() function
###### to do principal components.

pca.results=prcomp(X[,1:4])
print(summary(pca.results),loadings=T)
biplot(pca.results,xlabs=iris[,1])
abline(h=0); abline(v=0)

