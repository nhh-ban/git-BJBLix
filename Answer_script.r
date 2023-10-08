

library(tidyverse)



# loading data
galaxy_data <- readLines("sao.ru_lv_lvgdb_article_suites_dw_Table1.txt")

info_lines <- galaxy_data[1:12] #saving the info

cat(info_lines, file("galaxy_info_line.txt")) # saving the info lines to a .txt. file

# extracting and printing variable names
variable_names_line <- galaxy_data[13]
cat(variable_names_line)

# splitting variable names
variable_names <- strsplit(variable_names_line, split = " \\| ")[[1]]

# trimming white spaces from variable names
column_names <- trimws(variable_names)




data_lines <- galaxy_data[-(1:14)]

# then converting the data lines to a data frame
galaxy_data_df <- data_lines %>% 
  str_split_fixed(" \\| ", n = length(variable_names)) %>% 
  as.data.frame(stringsAsFactors = FALSE) 


#Adding the colmn names to the data frame
colnames(galaxy_data_df) <- column_names

head(galaxy_data_df)
