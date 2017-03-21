### orank_processing
source("/home/matt/GIT_Repos/O-Rank/code/orank_functions.R")
input <- "/home/matt/GIT_Repos/O-Rank/input/"
output <- "/home/matt/GIT_Repos/O-Rank/output/"

input <- "/Users/Matt/Documents/R/O_Rank/input/"
output <- "/Users/Matt/Documents/R/O_Rank/output/"

statnav_db <- read.csv(paste0(input,"statnav_db.csv"),header=T,fill=TRUE,sep=";")
current <- statnav_db[,c(3,14:dim(statnav_db)[2])]

### read a winsplits reslut and obtain name, club, and time
### paste a winsplits results to result.csv and save
result <- "results.txt"

race <- winsplit(result="results.txt",split=",")
racefull <- merge(race,statnav_db,by.x="Name",by.y="FullName",all.x=T)

### calculate the race points to add to current for ALL
U <- course_score(racefull);U

current <- merge(current,U,by.x = "FullName",by.y="Name",all.x=T,all.y=T)

write.table(current,paste0(input,"current.txt"),quote=F,col.names = F)

current[current$FullName=="OllieBixley",]

#current <- read.table(paste0(input,"current.txt"),header=F,row.names = 1)
#colnames(current) <- c("FullName","C1","C2","C3","C4","C5","C6","C7","C8","C9","C10","C11","C12","C13")
#current <- current[,-15]

current[current$FullName=="OllieBixley",]
current[current$FullName=="AnnBixley",]
current[current$FullName=="MattBixley",]

x <- current[current$FullName=="NickHann",]
rank5(x)

require(plyr)
ddply(current, "FullName", rank5)

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
