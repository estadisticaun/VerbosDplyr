# Cargar librería requerida
library(readr)

# Hacer uso de la función "read_csv2"
Aspirantes <- read_csv2("https://raw.githubusercontent.com/estadisticaun/VerbosDplyr/main/Datos/Asp_CSV.csv",
                        locale(encoding = "Latin1"), col_names = TRUE, col_types = NULL)
