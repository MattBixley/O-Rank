### functions for calculating orank

### extract info from a winsplit result table
winsplit <- function(result,split=" "){
  winsplit <- read.table(paste0(input,result),header=F,skip=0,fill=T,sep="\t")
  rows <- seq(3,dim(winsplit)[1],by=2)
  
  ###dealing with name format
  Name <- winsplit[rows,2]
  ifelse(split==",",{
    Name2 <- unlist(strsplit(as.character(Name),","))[seq(1,2*length(Name),by=2)]
    Name1 <- unlist(strsplit(as.character(Name),","))[seq(2,2*length(Name),by=2)]
    Name <- paste0(Name1,Name2)
    Name <- gsub(" ","",Name)
  },Name <- gsub(" ","",winsplit[rows,2]))

  ### remove mispunches and dsq
  time <- as.character(winsplit[rows,3])
  x <- which(time=="mp"|time=="dsq"|time=="dnf")
  ifelse(length(x)>0,{
  Name <- Name[-x]
  time <- time[-x]
  },Name)
  
  ltime <- lapply(time,nchar)
  time <- cbind(time,ltime)
  time <- ifelse(ltime<7,paste0("0:",time),time)
  
  timehours <- unlist(strsplit(as.character(time),":"))[seq(1,2*length(time),by=2)]
  time2 <- unlist(strsplit(as.character(time),":"))[seq(2,2*length(time),by=2)]
  timemins <- unlist(substr(as.character(time2),1,2))
  timesec <- unlist(substr(as.character(time2),4,5))
  racetime <- as.character(round((as.numeric(timehours)*60 + as.numeric(timemins) + as.numeric(timesec)/60),2))
  winsplit <- as.data.frame(cbind(Name=Name,Minutes=racetime))
  return(winsplit)
}

race <- racefull
### statnav function
course_score <- function(race){
  race <- race[order(as.numeric(as.character(race$Minutes))),]
  ## RT = Run Time
  RT = as.numeric(as.character(race$Minutes))
  
  ## MT/ST = Mean/SD all runners time
  MT = mean(RT)
  ST = sd(RT)
  
  ## MP/SP = SD of ranked runners current score (mean for ALL events)
  #SP = sd of ranked runners current score) ### need a dataframe of runners
  #MP = mean points of ranked runners current score
  # bottom 10% excluded from SP and MP calc

  MP <- mean(as.matrix(race[1:floor(0.9*length(race$Name)),15:dim(race)[2]]),na.rm=T)
  SP <- sd(as.matrix(race[1:floor(0.9*length(race$Name)),15:dim(race)[2]]),na.rm=T)

  RP <- MP + (((MT-RT)/ST) * SP) 
  
  #Current Ponts to Add
  CP <- cbind.data.frame(Name=as.character(race$Name),Points=round(RP,1))

return(CP)
}

### rescale current score points for entire database
###RPs <- 1000 + (RP - mean(RP))*200/sd(RP)
###

### function to print my rank
my_rank <- function(MyName){
  statnav_db <- read.csv(paste0(input,"statnav_db.csv"),header=T,fill=TRUE,sep=";")
  myrank <- subset(statnav_db,statnav_db$FullName==MyName,select=c("FullName","Rank","Club","Score"))
  return(myrank)
}

rank5 <- function(x,n=5){
  x <- x[,2:dim(x)[2]]
  ndx <- order(x, decreasing = T)[1:n]
  U <- sum(x[ndx])
  return(U)
}

