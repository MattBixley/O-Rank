### orank_processing
source("/home/matt/GIT_Repos/O-Rank/code/orank_functions.R")
input <- "/home/matt/GIT_Repos/O-Rank/input/"
output <- "/home/matt/GIT_Repos/O-Rank/output/"
statnav_db <- read.table(paste0(input,"statnav_db.csv"),header=T,fill=TRUE,sep=",")

### read a winsplits reslut and obtain name, club, and time
### paste a winsplits results to result.csv and save
result <- "result.csv"
race <- winsplit("result.csv")

head(statnav_db)
racefull <- merge(race,statnav_db,by.x="Name",by.y="FullName")

head(racefull)

which(statnav_db$FullName %in% race$Name)


course_score(racefull)




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
