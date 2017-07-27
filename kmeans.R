#### Read March 2015 bikes/docks availability ####
library(readr)
march2015= read_delim("~/Dropbox/-CornellUniversity/Summer2017/CitiBike/bikeshare_nyc_raw.csv", "\t", escape_double = FALSE, trim_ws = TRUE)

#### Clean up ####
march2015= march2015[march2015$in_service != 0,] #get rid of not-in-service rows
march2015= march2015[,c(1,3,4,6:9)] #don't need the other columns
march2015$date= as.integer(as.Date(march2015$date,format = "%y-%m-%d")) #turn dates into integers
march2015[march2015$pm == 0 & march2015$hour == 12,]$hour= 0 #12am gets 0
march2015[march2015$pm == 1 & march2015$hour != 12,]$hour= march2015[march2015$pm == 1 & march2015$hour != 12,]$hour + 12 #increase all pm hours except 12 by 12
march2015= march2015[,-c(4)] #now we don't need pm column

#### For each station, get 24 features: avg availability percentage by hour ####
stations= unique(march2015$dock_id)
avg_avail_bikes= c()
avg_tot_docks= c()
for (station in stations) {
  for (hour in 0:23) {
    avg_avail_bikes= c(avg_avail_bikes,mean(march2015[march2015$dock_id == station & march2015$hour == hour,]$avail_bikes))
  }
  avg_tot_docks= c(avg_tot_docks,mean(march2015[march2015$dock_id == station,]$tot_docks))
}

#Get availability percentage for each station for each hour
avail_percent= avg_avail_bikes / rep(avg_tot_docks,each=24)
march2015_2= data.frame(rep(stations,each=24),rep(0:23,times=length(stations)),avail_percent)
colnames(march2015_2)[c(1,2)]= c("station","hour")

#One row per station
march2015_3= stations
for (hour in 0:23) {
  march2015_3= data.frame(march2015_3, march2015_2[march2015_2$hour == hour,]$avail_percent)
}
colnames(march2015_3)[1]= "station"
colnames(march2015_3)[2:25]= 0:23

#### Put data in matlab file ####
#Note: Station 521 sometimes has more available bikes than docks, remove it
march2015_3= march2015_3[march2015_3$station != 521,]
rownames(march2015_3)= 1:326

#install R.matlab before this step, see https://stackoverflow.com/questions/15205879/how-to-get-r-data-into-a-matlab-matrix
library(R.matlab)
writeMat(con='/Users/EamonWoods/Dropbox/-CornellUniversity/Summer2017/CitiBike/march2015.mat',x=as.matrix(march2015_3[,c(2:25)]))

