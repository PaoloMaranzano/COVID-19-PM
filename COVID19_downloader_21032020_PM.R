###################################################################
########## Automatic download of COVID-19 data for Italy ########## 
###################################################################

# Source: https://github.com/pcm-dpc/COVID-19

## by Paolo Maranzano (Università degli Studi di Milano-Bicocca, p.maranzano@campus.unimib.it)
## Update: 21/03/2020

##### Packages
library(readr)
library(rlist)
library(tidyverse)

##### Insert start date (format yyyy/mm/dd) and end date (format yyyy/mm/dd)
date_start <- "2020/02/24"
date_end <- "2020/03/20"

##### Code
dates <- c(seq(from = as.Date(date_start), to = as.Date(date_end), by=1))
dates_c <- as.character(as.Date(dates, "%Y/%m/%d"), "%Y%m%d")

### Provincial data
prov_list <- vector("list", length = length(dates_c))
for (j in 1:length(dates_c)) {
  prov_list[[j]] <- read_csv(paste("https://raw.githubusercontent.com/pcm-dpc/COVID-19/master/dati-province/dpc-covid19-ita-province-",dates_c[j],".csv",sep = ""))
}
provinces <- list.stack(prov_list)
provinces <- provinces %>%
  filter(!is.na(sigla_provincia)) %>%     # remove missing values
  arrange(codice_provincia)         # reorder by 'codice_provincia'

### Regional data
reg_list <- vector("list", length = length(dates_c))
for (j in 1:length(dates_c)) {
  reg_list[[j]] <- read_csv(paste("https://raw.githubusercontent.com/pcm-dpc/COVID-19/master/dati-regioni/dpc-covid19-ita-regioni-",dates_c[j],".csv",sep = ""))
}
regions <- list.stack(reg_list)
regions <- regions %>%
  arrange(codice_regione)         # reorder by 'codice_regione'

### National data
italy_list <- vector("list", length = length(dates_c))
for (j in 1:length(dates_c)) {
  italy_list[[j]] <- read_csv(paste("https://raw.githubusercontent.com/pcm-dpc/COVID-19/master/dati-andamento-nazionale/dpc-covid19-ita-andamento-nazionale-",dates_c[j],".csv",sep = ""))
}
italy <- list.stack(italy_list)