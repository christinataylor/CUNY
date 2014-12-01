library(Rcpp)

vec <- rnorm(100000000, mean=0, sd=1)

system.time(mean(vec))

#user  system elapsed 
#0.29    0.00    0.31 


cppFunction('double meanC(NumericVector x){
            int n = x.size();
            double total = 0;
            for(int i=0; i<n; ++i){
            total += x[i];
            }
            return total/n;
            }')

system.time(meanC(vec))

#user  system elapsed 
#0.17    0.00    0.18
#http://stackoverflow.com/questions/2944297/postgresql-function-for-last-inserted-id
