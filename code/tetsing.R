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

### setting up the basecurrent file, clumsy as already had the current
#current <- statnav_db[,c(3,14:dim(statnav_db)[2])]
current <- read.table(paste0(input,"current.txt"),header=F,row.names = 1) 
base <- as.matrix(current[,2:6])
baselow <- base-176
sd(base,na.rm=T)

current <- cbind.data.frame(current[,1],baselow,base,current[,7:19])
colnames(current) <- c("FullName","B1","B2","B3","B4","B5","B6","B7","B8","B9","B10","C1","C2","C3","C4","C5","C6","C7","C8","C9","C10","C11","C12","C13")
basecurrent <- current[,1:11]