install.packages("UPMASK") # use this command to download the package
library('UPMASK')

# In the end you will find the gaia query I used.
# If you use it, you won't need to change columns' numbers. Just make sure to
# change the location and download in .csv.

# Use ctrl+shift+c to comment/uncomment

# I used .csv for input and output


inputFile = "C:\\Users\\aliii\\Downloads\\Berkeley39.csv" # Input file location

# Output file location\\name
outputFile = "C:\\Users\\aliii\\Documents\\2022_Fall\\R\\Berkeley39_k_25.csv"

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


# my gaia query

# SELECT gaia_source.source_id,gaia_source.ra,gaia_source.dec,gaia_source.parallax,gaia_source.parallax_error,gaia_source.pmra,gaia_source.pmra_error,gaia_source.pmdec,gaia_source.pmdec_error,gaia_source.phot_g_mean_flux,gaia_source.phot_g_mean_flux_error,gaia_source.phot_g_mean_mag,gaia_source.phot_bp_mean_flux,gaia_source.phot_bp_mean_flux_error,gaia_source.phot_bp_mean_mag,gaia_source.phot_rp_mean_flux,gaia_source.phot_rp_mean_flux_error,gaia_source.phot_rp_mean_mag,gaia_source.bp_rp,gaia_source.bp_g,gaia_source.g_rp
# FROM gaiadr3.gaia_source 
# WHERE
# (phot_g_mean_flux is not null)
# and
# (phot_bp_mean_flux is not null)
# and
# (phot_rp_mean_flux is not null)
# and
# (parallax_error is not null)
# and
# (parallax is not null)
# and
# (pmra is not null)
# and
# (pmdec is not null)
# and
# 
# CONTAINS(
#   POINT('ICRS',gaiadr3.gaia_source.ra,gaiadr3.gaia_source.dec),
#   CIRCLE(
#     'ICRS',
#     COORD1(EPOCH_PROP_POS(116.70199999999998,-4.665,.2010,-1.7300,-1.6450,59.8900,2000,2016.0)),
#     COORD2(EPOCH_PROP_POS(116.70199999999998,-4.665,.2010,-1.7300,-1.6450,59.8900,2000,2016.0)),
#     0.11666666666666667)
# )=1