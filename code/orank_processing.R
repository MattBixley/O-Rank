### orank_processing
source("/home/matt/GIT_Repos/O-Rank/code/orank_functions.R")
input <- "/home/matt/GIT_Repos/O-Rank/input/"
output <- "/home/matt/GIT_Repos/O-Rank/output/"
statnav_db <- read.table(paste0(input,"statnav_db.csv"),header=T,fill=TRUE,sep=",")

### read a winsplits reslut and obtain name, club, and time
### paste a winsplits results to result.csv and save

winsplit <- function(result){
  winsplit <- read.csv(paste0(input,result),header=T,fill=T)
  head(winsplit)
  rows <- seq(2,dim(winsplit)[1],by=2)
  club <- seq(3,dim(winsplit)[1],by=2)
  club <- winsplit[club,1]
  winsplit <- winsplit[rows,2:4]
  time <- as.character(winsplit$Finish)
  ltime <- lapply(time,nchar)
  time <- cbind(time,ltime)
  time <- ifelse(ltime<7,paste0("0:",time),time)
  timehours <- unlist(strsplit(as.character(time),":"))[seq(1,length(time),by=2)]
  time2 <- unlist(strsplit(as.character(time),":"))[seq(2,length(time),by=2)]
  timemins <- unlist(substr(as.character(time2),1,2))
  timesec <- unlist(substr(as.character(time2),4,5))
  racetime <- round((as.numeric(timehours)*60 + as.numeric(timemins) + as.numeric(timesec)/60),2)
  winsplit <- cbind(Name=paste0(winsplit$Name,winsplit$X),Club=club,RT=racetime)
}






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
