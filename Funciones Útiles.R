# FUNCIONES ÚTILES PARA LA GESTIÓN DE PAQUETES

# Total de paquetes disponibles en CRAN

nrow(available.packages())

# Paquetes instalados en nuestros entornos de trabajo
library() # con menor detalle
View(installed.packages()) # con mayor detalle

# Paquetes disponibles para trabajo - con library
search()

# Total de funciones de un paquete de R

lsf.str("package:dplyr") 

funciones <- data.frame(Función = as.character(lsf.str("package:dplyr")))
nrow(funciones)
View(funciones)

# En qué paquete se  encuentra una función

find("mutate")
find("filter")
