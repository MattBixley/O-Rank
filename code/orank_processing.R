### orank_processing
source("orank_fucntions")
statnav_db <- read.table("/home/matt/GIT_Repos/O-Rank/input/statnav_db.csv",header=T,fill=TRUE,sep=",")

### read a winsplits reslut and obtain name, club, and time
### paste a winsplits results to result.csv and save

winsplit <- read.csv("/home/matt/GIT_Repos/O-Rank/input/result.csv",header=T,fill=T)
head(winsplit)
rows <- seq(2,dim(winsplit)[1],by=2)
club <- seq(3,dim(winsplit)[1],by=2)
club <- winsplit[club,1]

winsplit <- winsplit[rows,2:4]
winsplit$slub <- club

time <- as.character(winsplit$Finish)
ltime <- lapply(time,nchar)
time <- cbind(time,ltime)

time <- ifelse(ltime<7,paste0("0:",time),time)


timehours <- unlist(strsplit(as.character(time),":"))
as.Date(as.character(time))




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
