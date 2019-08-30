getwd()
setwd("~/Downloads/1.DataAnalyst/R/WebScrap/")
library(rvest)
library(stringr)
library(magrittr)
library(data.table)
library(tidyverse)

# Get salary dataset
page <- read_html("https://www.basketball-reference.com/contracts/players.html")
salary.table <- page %>% html_table(header = FALSE) %>% extract2(1)
names(salary.table) <- salary.table[2,]
salary.table <- salary.table[-1,]
salary.table <- salary.table[-1,2:4]
names(salary.table)[3] <- "seson17_18"

#deleting useless rows
salary.table <- salary.table %>%
filter(Player != "" & Player != "Player")

#Removing Dollor sign
salary.table$seson17_18 <-
gsub(",", "", salary.table$seson17_18)

salary.table$seson17_18 <-
gsub('\\$', '', salary.table$seson17_18)
salary.table$seson17_18 <- as.numeric(salary.table$seson17_18)


write.csv(salary.table, "NBA_season1718_salary.csv")

