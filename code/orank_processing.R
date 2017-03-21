### orank_processing
source("/home/matt/GIT_Repos/O-Rank/code/orank_functions.R")
input <- "/home/matt/GIT_Repos/O-Rank/input/"
output <- "/home/matt/GIT_Repos/O-Rank/output/"

#input <- "/Users/Matt/Documents/R/O_Rank/input/"
#output <- "/Users/Matt/Documents/R/O_Rank/output/"

statnav_db <- read.csv(paste0(input,"statnav_db.csv"),header=T,fill=TRUE,sep=";")
current <- read.table(paste0(input,"current.txt"),header=F,row.names = 1) 

### read a winsplits reslut and obtain name, club, and time
### paste a winsplits results to result.csv and save
result <- "results.txt"

#######################################################################################
race <- winsplit(result="results.txt",split=",")
racefull <- merge(race,statnav_db,by.x="Name",by.y="FullName",all.x=T)

### calculate the race points to add to current for ALL
U <- course_score(racefull);U
#######################################################################################

X <- merge(current,U,by.x = "FullName",by.y="Name",all.x=T,all.y=T)
X <- current
### scale current to Mean 1000, SD 200
Z <- as.matrix(X[,2:dim(X)[2]]) 
Zscaled <- 1000 + (Z - mean(Z,na.rm=T))*200/sd(Z,na.rm=T)
current2 <- cbind.data.frame(current[,1],Zscaled)
colnames(current2) <- "FullName"
write.table(current2,paste0(input,"current.txt"),quote=F,col.names = F)
#######################################################################################
current2[current2[,"FullName"]=="OllieBixley",]
current2[current2[,1]=="AnnBixley",]
current[current[,1]=="MattBixley",]

x <- current2[current2[,1]=="JeniPelvin",]
rank5(x)

require(plyr)
ddply(current, "FullName", rank5)

mean(scaledcurrent,na.rm=T)
curr <- as.matrix(current[,2:19])
scaledcurrent <- 1000 + (curr - mean(curr,na.rm=T))*200/sd(curr,na.rm=T)
newcurr <- cbind.data.frame(FullName=current$FullName,scaledcurrent)
x <- newcurr[newcurr$FullName=="NickHann",]
rank5(x)


my_rank("AnnBixley")
my_rank("MattBixley")


#### running single jobs from excel
matarae_long <- read.table("/home/matt/GIT_Repos/O-Rank/input/matarae_long.csv",header=T,fill=TRUE,sep=",")
mtross_c1 <- read.table("/home/matt/GIT_Repos/O-Rank/input/mtross_c1.csv",header=T,fill=TRUE,sep=",")
matarae_medium <- read.table("/home/matt/GIT_Repos/O-Rank/input/matarae_medium.csv",header=T,fill=TRUE,sep=",")
mtross_combined <- read.table("/home/matt/GIT_Repos/O-Rank/input/mtross_combined.csv",header=T,fill=TRUE,sep=",")
kairaki <- read.table("/home/matt/GIT_Repos/O-Rank/input/kairaki.csv",header=T,fill=TRUE,sep=",")

e1 <- course_score(matarae_medium)
e2 <- course_score(mtross_c1)
e3 <- course_score(mtross_combined)
e4 <- course_score(matarae_long)
e5 <- course_score(kairaki)

eall <- rbind(e1,e2,e3,e4)


eall <- rbind(e1,e2,e3,e4)
RP <- as.numeric(as.character(eall[,2]))/5


eall <- cbind(eall,RP)
