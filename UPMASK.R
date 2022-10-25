install.packages("UPMASK") # use this command to download the package
library('UPMASK')

# You won't need to change columns' numbers if you use my gaia query.

# I used .csv for input and output
inputFile = "C:\\Users\\ali\\Downloads\\Berkeley39.csv" # Input file location\\name

# Output file location\\name
outputFile = "C:\\Users\\ali\\Documents\\2022_Fall\\R\\Berkeley39_k_25.csv"

posIdx=c(2,3)                 # ra and dec columns (columns start from 1)
photIdx=c(4,6,8,10,13,16)     # clustering parameters' columns in inputFile 
    # I used: parallax, proper_motion in ra, dec, flux in g, bp, rp
    # You can use magnitudes instead of fluxes
    # I used fluxes since gaia gives their errors
PhotErrIdx=c(5,7,9,11,14,17)  # columns of errors in clustering parameters 

ocData = read.csv(inputFile)
# Use next line to remove rows that have any null values
ocData = na.omit((ocData))

k = 25 # you can use different values for this parameter. Make sure 10<=k<=25

# run UPMASK
upmaskRes <- UPMASKdata(ocData, posIdx, photIdx, PhotErrIdx, nRuns=120, 
                        starsPerClust_kmeans=k, verbose=TRUE,nDimsToKeep=4,
                        maxIter=25, considerErrors = TRUE)

# create an output file
write.csv(upmaskRes,outputFile, row.names = TRUE)
# last column include probabilities
