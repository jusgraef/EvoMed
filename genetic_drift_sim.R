library(tidyverse)
library(learnPopGen)


## Set parameters ##
size=100  # Effective population size
t=100     # Number of generations
sims=10   # Number of simulations
freq=0.5  # Starting frequency for allele 


## Simulate ##
drift <- genetic.drift(p0=freq, 
                       Ne=size, 
                       nrep=sims, 
                       time=t, 
                       show="p", 
                       pause=0)

drift_df <- data.frame(freq = drift[1:t, 1], 
                       time = 1:t, 
                       sim = as.character(1))

for (i in 2:sims) {
  
  drift_loop <- data.frame(freq = drift[1:t, i],  
                           time = 1:t,
                           sim = rep(as.character(i), 100))
  
  drift_df <- rbind(drift_df, drift_loop)
  
}


## Plot ##
ggplot(drift_df)+
  geom_line(aes(x=time, y=freq, color=sim))+
  ylim(c(0,1))+
  ggsci::scale_color_d3()+
  theme_bw(base_size = 20)
