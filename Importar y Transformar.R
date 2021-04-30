# IMPORTAR DATOS A R 
# Instalar Librerías ----
# Importar y exportar datos a Excel

# Importar usando la librería readxl
# Exportar datos a Excel usando la librería writexl
# Instalar las liberarías en R

install.packages("readxl", dependencies = TRUE)
install.packages("writexl", dependencies = TRUE)

# Instalar la libería dplyr 
# libería especializada con funciones orientadas a la transformación de datos

install.packages("dplyr", dependencies = TRUE) 


# Cargar las librerías requeridas al espacio de trabajo

library(readxl)
library(dplyr)

# Importar datos ----

# Muestra de estudiantes aspirantes a la UNAL - primera hoja
Aspirantes <- read_excel("Datos/Muestras.xlsx")

# Primeros 50 individuos
Aspirantes50 <- read_excel("Datos/Muestras.xlsx", range = cell_rows(c(1, 51)))

# Primeras 3 variables
Aspirantes3 <- read_excel("Datos/Muestras.xlsx", range = cell_cols("A:C"))


# Importar base de datos iris
Iris <- read_excel("Datos/Muestras.xlsx", sheet = "Iris", skip = 2)

# Importar base de datos carros

# Sin nombres

Carros <- read_excel("Datos/Muestras.xlsx", sheet = "Carros", 
                     col_names = c("modelo", "mpg", "cilindros",
                                   "disp", "hp", "drat", "wt",
                                   "qsec", "vs", "am", "gear", 
                                   "carb"))

# Importar base de datos tabla

# Sin nombres

Tabla <- read_excel("Datos/Muestras.xlsx", sheet = "Tabla", range = "D5:E10")


# Verbo 1 - SELECCIONAR ----

########################-
# Seleccionar variables por nombre
########################-

names(Aspirantes)

select(Aspirantes, c(YEAR, SEMESTRE, SEXO)) # sin comillas
Aspirantes[c("YEAR", "SEMESTRE", "SEXO")] # Haciendo uso de la base del lenguaje
select(Aspirantes, c("YEAR", "SEMESTRE", "SEXO")) # con comillas - vector de caracteres
select(Aspirantes, !c(YEAR, SEMESTRE, SEXO)) # con operador lógico (!)

# Ejemplo de la base del lenguaje

# Aspirantes[c("YEAR", "SEMESTRE", "SEXO")] # Haciendo uso de la base del lenguaje
# Aspirantes[ , c("YEAR", "SEMESTRE", "SEXO")]
# Aspirantes[ , -c("YEAR", "SEMESTRE", "SEXO")] # con operadores lógicos 

##########################-
# Seleccionar variables con vectores numéricos
##########################-

select(Aspirantes, c(1, 2, 10)) # sin comillas
select(Aspirantes, -c(1, 2, 10)) # haciendo uso del signo menos
select(Aspirantes, c(-1, -2, -10)) # alternativa al signo menos
# select(Aspirantes, c(-1, -2, -10))
select(Aspirantes, !c(1, 2, 10)) # haciendo uso del operador lógico (!)
# Guardar la selección dentro de una variable/objeto
Asp_menos <- select(Aspirantes, !c(1, 2, 10))
Asp_menos

# Haciendo uso de la base del lenguaje

# Aspirantes[c(1, 2, 10)]
# Aspirantes[ , c(1, 2, 10)]
# Aspirantes[ , -c(1, 2, 10)]
# Aspirantes[ , c(-1, -2, -10)]

#####################################-
# Seleccionar variables ubicadas en un rango
####################################-

names(Aspirantes)
select(Aspirantes, EDAD:DISCAPACIDAD) # Forma básica

select(Aspirantes, c(EDAD:DISCAPACIDAD)) # Alternativa 1
select(Aspirantes, "EDAD":"DISCAPACIDAD") # Alternativa 2
select(Aspirantes, c("EDAD":"DISCAPACIDAD")) # Alternativa 3

# Con la base del lenguaje

#Aspirantes[c("EDAD":"DISCAPACIDAD")]
# Aspirantes[c(9:12)]

################################-
# Seleccionar variables con vectores lógicos
###############################-

# Select(iris, c(TRUE, FALSE, FALSE, TRUE, TRUE)) # con vectores lógicos
# iris[c(TRUE, FALSE)]
# Aspirantes[c(TRUE, FALSE)]
# class(iris)
# class(Aspirantes)
# Aspirantes1 <- as.data.frame(Aspirantes)
# class(Aspirantes1)
# Aspirantes1[c(TRUE, FALSE)]

###########################################-
# Selección de variables con funciones Auxiliares ----
###########################################-

# starts_with()

names(Iris)
select(Iris, starts_with("Sepal"))
iris_petal <- select(Iris, starts_with("Petal"))
iris_petal

# ends_with()

names(Aspirantes)
select(Aspirantes, ends_with("CIU_NAC"))
Asp_naci <- select(Aspirantes, ends_with("CIU_NAC"))
Asp_naci

# contains()

select(Aspirantes, contains("NAC"))
Nacimiento <- select(Aspirantes, contains("NAC"))
Nacimiento

# matches() 
names(iris)
select(Iris, matches("gth$")) # Selecciona aquellos nombres que finalizan con "gth"
select(Iris, matches("^Spe")) # Finaliza a quellos nombres que inician con "Spe"
select(iris, matches("^Spe"), matches("gth$")) # Combina los dos anteriores
# para saber un poco más sobre expresioens regulares, consultar el siguiente enlace:
# http://edrub.in/CheatSheets/cheatSheetStringr.pdf
# https://www.rstudio.com/resources/cheatsheets/ 

# any_of()
names(Aspirantes)
variables <- c("YEAR", "SEMESTRE", "EDAD", "ADMITIDO", "ADMITIDO")
select(Aspirantes, one_of(variables))
Aspi_var <- select(Aspirantes, one_of(variables))
Aspi_var
View(Aspi_var) # Ver en una pestaña diferente

# num_range()
nuevo <- tibble (X1 = rnorm(10),
                X2 = rnorm(10), 
                X3 = rnorm(10),
                X4 = rnorm(10),
                X5 = rnorm(10))

select(nuevo, num_range("X", c(2:4)))

# everything()
names(Iris)
select(Iris, everything()) # Seleccionar el mismo conjunto
select(iris, c(Species, Petal.Width), everything()) # reubicar variables

#######################################-
# Selección de variables con cambio de nombre
#######################################-
names(Aspirantes)

select(Aspirantes, c(YEAR, SEMESTRE, EDAD))
select(Aspirantes, c(YEAR, PERIODO = SEMESTRE, EDAD_FINAL = EDAD))
select(Aspirantes, c(YEAR, PERIODO = "SEMESTRE", EDAD_FINAL = "EDAD"))

Asp_renom <- select(Aspirantes, c(YEAR, PERIODO = "SEMESTRE", EDAD_FINAL = "EDAD"))
Asp_renom

####################################-
# Selección de variables combinada
####################################-

names(Aspirantes)

select(Aspirantes, c(YEAR, SEMESTRE, SEXO), ends_with("CIU_NAC"))
Asp_Comb <- select(Aspirantes, c(1), contains("NAC"))
Asp_Comb

Asp_Comb1 <- select(Aspirantes, c(YEAR:DEP_NAC, starts_with("A")))
Asp_Comb1

# Verbo 2 - RENOMBRAR ----

names(Aspirantes)

rename(Aspirantes, DEPARTAMENTO = DEP_NAC, 
                   MUNICIPIO = CIU_NAC,
                   GENERO = SEXO,
                   AREA = AREAC_SNIES)

rename(Aspirantes, DEPARTAMENTO = 'DEP_NAC', 
       MUNICIPIO = 'CIU_NAC',
       GENERO = 'SEXO',
       AREA = 'AREAC_SNIES')


Cambio <- rename(Aspirantes, DEPARTAMENTO = DEP_NAC, 
                 MUNICIPIO = CIU_NAC,
                 GENERO = SEXO,
                 AREA = AREAC_SNIES)
Cambio
View(Cambio)

# Cambio de nombres de variables con la base de R

# names(Aspirantes)[c(3, 5, 10, 18)] <- c('DEPARTAMENTO', 'MUNICIPIO', 'GENERO', 'AREA')
# Aspirantes

# Verbo 3 - REUBICAR ----

###################################-
# Ubicar variables en la primera posición
###################################-

names(Aspirantes)

# Una variable
relocate(Aspirantes, NIVEL)
relocate(Aspirantes, c(NIVEL))
Asp_Reu <- relocate(Aspirantes, c(NIVEL))
Asp_Reu
relocate(Aspirantes, c("NIVEL"))
relocate(Aspirantes, c(19))

# Más de una variable
relocate(Aspirantes, c(NIVEL, SEXO, ADMITIDO))
relocate(Aspirantes, c("NIVEL", "SEXO", "ADMITIDO"))
relocate(Aspirantes, c(19, 10, 16))

# Haciendo uso de los operadores (! y -)
relocate(Aspirantes, !c(19, 10, 16))
relocate(Aspirantes, -c(19, 10, 16))


#########################################-
# Ubicar variables antes de una variable dada (.before)
#########################################-

names(Aspirantes)

# Una variable
relocate(Aspirantes, NIVEL, .before = EDAD)
relocate(Aspirantes, c(NIVEL), .before = c(EDAD))
relocate(Aspirantes, c(19), .before = c(10))

# más de una variable
relocate(Aspirantes, c(NIVEL, ADMITIDO), .before = EDAD)
relocate(Aspirantes, c(ADMITIDO, NIVEL), .before = EDAD)
Asp_Reu1 <- relocate(Aspirantes, c(ADMITIDO, NIVEL), .before = EDAD)
Asp_Reu1
View(Asp_Reu1)

# Ubicar en la última comuna

relocate(Aspirantes, NIVEL, .after = last_col())
relocate(Aspirantes, c(ADMITIDO, NIVEL), .before = last_col())
View(relocate(Aspirantes, c(ADMITIDO, NIVEL), .before = last_col()))
# relocate(Aspirantes, -c(ADMITIDO, NIVEL), .before = last_col())


# Ubicar con cambio de nombre
relocate(Aspirantes, FORMACIÓN = NIVEL, .before = EDAD)
relocate(Aspirantes, c(ADMI = ADMITIDO, NIV = NIVEL), .before = EDAD)

########################################-
# Ubicar variables después de una variable data (. after)
########################################-


names(Aspirantes)

# Una variable
relocate(Aspirantes, NIVEL, .after = EDAD)
relocate(Aspirantes, c(NIVEL), .after = c(EDAD))
relocate(Aspirantes, c(19), .after = c(9))

# más de una variable
relocate(Aspirantes, c(NIVEL, ADMITIDO), .after = EDAD)
relocate(Aspirantes, c(ADMITIDO, NIVEL), .after = EDAD)
Asp_Reu2 <- relocate(Aspirantes, c(NIVEL, MOD_INS), .after = EDAD)
Asp_Reu2

# Otras opciones
# Función where

relocate(Aspirantes, where(is.numeric))
relocate(Aspirantes, where(is.numeric), .after = where(is.character))

# Ver más posibilidades en
# https://dplyr.tidyverse.org/reference/relocate.html








