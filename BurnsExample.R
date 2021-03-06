# load data
load("FacialBurns.rda")

# install lavaan package 
install.packages("lavaan", dependencies = TRUE)

# call lavaan library
library("lavaan")


# model syntax with starting values 
burnsModel <- 'Selfesteem ~ Age + c(m1, f1)*TBSA + HADS +
                          start(-.10, -.20)*TBSA  
                HADS ~ Age + c(m2, f2)*TBSA + RUM +
                       start(.10, .20)*TBSA '


# constraints syntax
burnsConstraints <- 'm1 < 0  
                     f1 < 0  
		     f1 < m1
		     m2 > 0
                     f2 > 0 
		     f2 > m2'


# necessary function arguments
burnsOUT <- InformativeTesting(model              = burnsModel, 
                               data               = burns.data,
                               constraints        = burnsConstraints, 
                               R                  = 1000,
                               double.bootstrap   = "standard",
                               double.bootstrap.R = 249, 
                               group              = "Sex",
                               parallel           = "multicore",
                               ncpus              = 8)


# print() function
burnsOUT


# plot() function
plot(burnsOUT)


# request unconstrained parameter estimates
summary(burnsIT$fit.B1)


# request constrained parameter estimates
summary(burnsIT$fit.A1)



