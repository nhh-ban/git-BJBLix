

# Problem 1 -----

# Done with Git

# Problem 2 -----


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

# Converting some of columns to numeric values

columns_to_convert <- c("a_26", "m_b", "log_lk", "log_m26", "log_mhi",
                        "vlg", "ti1", "delta_vlg", "count")

galaxy_data_df <- galaxy_data_df %>% 
  mutate_at(vars(columns_to_convert), as.numeric)

head(galaxy_data_df)

# Problem 3 -----

#loading ggplot-package
library(ggplot2)

# Looking at the galaxy diameters
galaxy_data_df %>% 
  ggplot(aes(x=a_26)) +
  geom_histogram(binwidth = 0.6, fill="blue", color="black", alpha=0.7) +
  labs(title="Distribution of Galaxy Diameters",
       x="Galaxy diameter in kpc",
       y="Number of Galaxies") +
  theme_minimal() +
  theme(panel.grid.minor = element_line(color = "gray", linetype = "dotted"))



