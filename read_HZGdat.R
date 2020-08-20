read_HZGdat <- function(HZGdat, # a .dat file 
                        add.meta = TRUE, # add meta data from the header as columns
                        plug.parameter.name = TRUE # should the col.name of the value column be changed to the actual parameter name with unit? Especially in combination with add.meta=TRUE this may not be necessary.
){
  # read file
  dat <- readLines(HZGdat)
  
  # create the header, replacing a value col name with proper parameter name and unit
  header <- dat[grep("# Columns:", dat)+1]
  header <- strsplit(header, "\t")
  header <- unlist(header)
  if(plug.parameter.name){
    # extract target parameter and its unit
    parameter <- grep("# Parameter: ", dat, value = TRUE)
    parameter <- sub("# Parameter: ", "", parameter)
    unit <- grep("# Unit: ", dat, value = TRUE)
    unit <- sub("# Unit: ", "", unit)
    unit <- sub(" ", "", unit)
    parameter.unit <- paste(parameter, "_", unit, sep = "")
    header <- sub(paste(c("Value","physval"), collapse="|"), # the data column is called "Value" and "physval" respectively in TSplot and Ferrybox exports
                  parameter.unit, header)
  }
  
  # define the end of the header
  header.end <- grep(paste(c("# Data:","# Rows:"), collapse="|"), # the beginning of the data rows is indicated with  "Rows" and "Data" respectively in TSplot and Ferrybox exports
                     dat)
  
  # load data into df
  data <- read.table(HZGdat,
                     skip = header.end, # not strictly necessary
                     sep = "\t",
                     col.names = header,
                     fill = TRUE # in case data is missing from column
  )
  
  # deal with cases without data
  if(nrow(data)==0){data[1,] = paste("no data in", sub(".*/", "", HZGdat))}
  
  # meta data
  if(add.meta){
    meta <- grep("#", dat, value = TRUE)
    meta <- sub("# ", "", meta)
    meta <- meta[1:(length(meta)-2)]
    meta.value <- sub(".*: ", "", meta)
    meta.par <- sub(": .*", "", meta)
    meta.df <- data.frame(meta.value, row.names = meta.par)
    meta.df <- t(meta.df)
    rownames(meta.df) <- NULL
    data <- cbind(data, meta.df)
  }
  
  return(data)
  
}