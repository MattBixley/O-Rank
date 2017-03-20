### functions for calculating orank

### statnav function
matarae_long <- read.table("/home/matt/GIT_Repos/O-Rank/input/matarae_long.csv",header=T,fill=TRUE,sep=",")
mtross_c1 <- read.table("/home/matt/GIT_Repos/O-Rank/input/mtross_c1.csv",header=T,fill=TRUE,sep=",")
matarae_medium <- read.table("/home/matt/GIT_Repos/O-Rank/input/matarae_medium.csv",header=T,fill=TRUE,sep=",")
mtross_combined <- read.table("/home/matt/GIT_Repos/O-Rank/input/mtross_combined.csv",header=T,fill=TRUE,sep=",")
kairaki <- read.table("/home/matt/GIT_Repos/O-Rank/input/kairaki.csv",header=T,fill=TRUE,sep=",")

race <- matarae_medium
race <- matarae_long
race <- mtross_c1

e1 <- course_score(matarae_medium)
e2 <- course_score(mtross_c1)
e3 <- course_score(mtross_combined)
e4 <- course_score(matarae_long)
e5 <- course_score(kairaki)

eall <- rbind(e1,e2,e3,e4)


course_score <- function(race){
  ## RT = Run Time
  RT = race$Minutes
  
  ## MT/ST = Mean/SD all runners time
  MT = mean(race$Minutes)
  ST = sd(race$Minutes)
  
  ## MP/SP = SD of ranked runners current score (mean for ALL events)
  #SP = sd of ranked runners current score) ### need a dataframe of runners
  #MP = mean points of ranked runners current score
  # bottom 10% excluded from SP and MP calc
  
  MP <- mean(race$Current[1:floor(0.9*length(race$Name))],na.rm=T)
  SP <- sd(race$Current[1:floor(0.9*length(race$Name))],na.rm=T) 

  RP = MP + (((MT-RT)/ST) * SP) 
  
  RankPoints <- cbind(as.character(race$Name),round(RP*5,0))
return(RankPoints)
}

### rescale current score points for entire database
RPs <- 1000 + (RP - mean(RP))*200/sd(RP)

eall <- rbind(e1,e2,e3,e4)
RP <- as.numeric(as.character(eall[,2]))/5

RPs <- round((1000 + (RP - mean(RP))*200/sd(RP))*5,0)

eall <- cbind(eall,RPs)

