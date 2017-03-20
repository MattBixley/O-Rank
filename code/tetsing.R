### testing

current <- as.matrix(read.table(file="clipboard",header=T,fill=T))
mean(current)
sd(current)

cs <- 1000 + (current - mean(current))*200/sd(current)
mean(cs)
cs
rank <- rowSums(current)
srank <- rowSums(cs)

cbind(rank,srank)
mean(rank)
mean(srank)


### it appears scaling isn't actually done