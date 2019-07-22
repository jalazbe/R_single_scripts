# Compare two excels to check data 
library(assertthat)
library(readxl)
library(data.table)

args <- vector()
args[1] <- "file1.xlsx"
args[2] <-"file2.xlsx"

args[1] <- "calculations_data_10_20/SAE_PORTFOLIOS_BL_HIST20.xlsx"
args[2] <-"calculations_data_10_20/SAE_PORTFOLIOS_BL_HIST22.xlsx"

data1 <-data.frame(read_excel(args[1]))
setDT(data1)
setkeyv(data1, c("END_DATE", "PORTFOLIO"))

data2 <- data.frame(read_excel(args[2]))
setDT(data2)
setkeyv(data2, c("END_DATE", "PORTFOLIO"))

print("File1 and file2 have the same number of rows")
all.equal(nrow(data1), nrow(data2))


print("File1 and file2 has the same columns: ")
all.equal(names(data1), names(data1))

all.equal(nrow(data1), nrow(data2))
eq_columns <- vector()
not_eq_columns <- vector()

# See which columns are equal and wich are not. 
for (column in names(data1)){
  if (all.equal( data1[, ..column], data2[, ..column] ) == TRUE){
    print(paste("Ok", column))
    eq_columns <- c(eq_columns, column)
  }else{
    print(paste("Not equal", column))
    not_eq_columns <- c(not_eq_columns, column)
  }
}

# See whats different on the columns.
for (column in not_eq_columns){
  print(all.equal( data1[, ..column], data2[, ..column]))
}

