### functions for calculating orank

### extract info from a winsplit result table
winsplit <- function(result){
  winsplit <- read.csv(paste0(input,result),header=T,fill=T)
  head(winsplit)
  rows <- seq(2,dim(winsplit)[1],by=2)
  Name <- paste0(winsplit[rows,2],winsplit[rows,3])
  #winsplit <- winsplit[rows,2:4]
  time <- as.character(winsplit[rows,4])
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

### statnav function
course_score <- function(race){
  race <- racefull
  race$Minutes <- as.numeric(race$Minutes)
  ## RT = Run Time
  RT = race$Minutes
  
  ## MT/ST = Mean/SD all runners time
  MT = mean(race$Minutes)
  ST = sd(race$Minutes)
  
  ## MP/SP = SD of ranked runners current score (mean for ALL events)
  #SP = sd of ranked runners current score) ### need a dataframe of runners
  #MP = mean points of ranked runners current score
  # bottom 10% excluded from SP and MP calc
  
  MP <- mean(race[,14:dim(race)[2]][1:floor(0.9*length(race$Name))],na.rm=T)
  SP <- sd(race[,14:dim(race)[2]][1:floor(0.9*length(race$Name))],na.rm=T) 

  RP = MP + (((MT-RT)/ST) * SP) 
  
  RankPoints <- cbind(as.character(race$Name),round(RP*5,0))
return(RankPoints)
}

### rescale current score points for entire database
RPs <- 1000 + (RP - mean(RP))*200/sd(RP)

