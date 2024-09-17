library(dplyr)
library(lubridate)
library(openair)

setwd("C:/Users/abrios/Desktop/evaluacion_tendencia")

# Procesar primera estación
bd1 <- read.table("CA-HU-01 HISTORICO 1h_.csv", sep = ";", header = TRUE, quote = "", stringsAsFactors = FALSE, encoding = "UTF-8") %>%
  mutate(date = ymd_hms(date, tz = "UTC")) %>%
  mutate(across(-date, as.numeric)) %>%
  as_tibble() %>%
  filter(date %within% interval(ymd_hms("2024-01-01 00:00:00"), ymd_hms("2024-07-31 23:00:00"))) %>%
  rename(PM10 = PM10_1h_ugm3, PM25 = PM25_1h_ugm3, wd = WD_sexa)

# Gráficas para PM10 y PM25 de la Estación Huachipa Nievería (CA-HU-01)
p1_pm10 <- TheilSen(bd1, 
                    pollutant = "PM10", 
                    ylab = "PM10 (µg/m³)", 
                    xlab = "2024",
                    avg.time = "month",
                    deseason = TRUE,
                    date.format = "%b",
                    main = "Estación Huachipa Nievería (CA-HU-01) - PM10",
                    slope.text = "unidad/mes")

# Guardar gráfico PM10 en PNG
png(
  type = "cairo-png",
  filename = "CA-HU-01_pm10.png",
  width = 5 * 300,
  height = 5 * 300,
  res = 300
)
print(p1_pm10$plot)
dev.off()

p1_pm25 <- TheilSen(bd1, 
                    pollutant = "PM25", 
                    ylab = "PM25 (µg/m³)", 
                    xlab = "2024",
                    avg.time = "month",
                    deseason = TRUE,
                    date.format = "%b",
                    main = "Estación Huachipa Nievería (CA-HU-01) - PM25",
                    slope.text = "unidad/mes")

# Guardar gráfico PM25 en PNG
png(
  type = "cairo-png",
  filename = "CA-HU-01_pm25.png",
  width = 5 * 300,
  height = 5 * 300,
  res = 300
)
print(p1_pm25$plot)
dev.off()

# Procesar segunda estación
bd2 <- read.table("CA-HU-04 HISTORICO 1h_.csv", sep = ";", header = TRUE, quote = "", stringsAsFactors = FALSE, encoding = "UTF-8") %>%
  mutate(date = ymd_hms(date, tz = "UTC")) %>%
  mutate(across(-date, as.numeric)) %>%
  as_tibble() %>%
  filter(date %within% interval(ymd_hms("2024-01-01 00:00:00"), ymd_hms("2024-07-31 23:00:00"))) %>%
  rename(PM10 = PM10_1h_ugm3, PM25 = PM25_1h_ugm3, wd = WD_sexa)

# Gráficas para PM10 y PM25 de la Estación Huachipa El Paraiso (CA-HU-04)
p2_pm10 <- TheilSen(bd2, 
                    pollutant = "PM10", 
                    ylab = "PM10 (µg/m³)", 
                    xlab = "2024",
                    avg.time = "month",
                    deseason = TRUE,
                    date.format = "%b",
                    main = "Estación Huachipa El Paraiso (CA-HU-04) - PM10",
                    slope.text = "unidad/mes")

# Guardar gráfico PM10 en PNG
png(
  type = "cairo-png",
  filename = "CA-HU-04_pm10.png",
  width = 5 * 300,
  height = 5 * 300,
  res = 300
)
print(p2_pm10$plot)
dev.off()

p2_pm25 <- TheilSen(bd2, 
                    pollutant = "PM25", 
                    ylab = "PM25 (µg/m³)", 
                    xlab = "2024",
                    avg.time = "month",
                    deseason = TRUE,
                    date.format = "%b",
                    main = "Estación Huachipa El Paraiso (CA-HU-04) - PM25",
                    slope.text = "unidad/mes")

# Guardar gráfico PM25 en PNG
png(
  type = "cairo-png",
  filename = "CA-HU-04_pm25.png",
  width = 5 * 300,
  height = 5 * 300,
  res = 300
)
print(p2_pm25$plot)
dev.off()

# Procesar tercera estación
bd3 <- read.table("CA-HU-09 HISTORICO 1h_.csv", sep = ";", header = TRUE, quote = "", stringsAsFactors = FALSE, encoding = "UTF-8") %>%
  mutate(date = ymd_hms(date, tz = "UTC")) %>%
  mutate(across(-date, as.numeric)) %>%
  as_tibble() %>%
  filter(date %within% interval(ymd_hms("2024-01-01 00:00:00"), ymd_hms("2024-07-31 23:00:00"))) %>%
  rename(PM10 = PM10_1h_ugm3, PM25 = PM25_1h_ugm3, wd = WD_sexa)

# Gráficas para PM10 y PM25 de la Estación Huachipa Santa María (CA-HU-09)
p3_pm10 <- TheilSen(bd3, 
                    pollutant = "PM10", 
                    ylab = "PM10 (�g/m�)", 
                    xlab = "2024",
                    avg.time = "month",
                    deseason = TRUE,
                    date.format = "%b",
                    main = "Estaci�n CA-HU-09 Santa Mar�a de Huachipa - PM10",
                    slope.text = "unidad/mes")

# Guardar gráfico PM10 en PNG
png(
  type = "cairo-png",
  filename = "CA-HU-09_pm10.png",
  width = 5 * 300,
  height = 5 * 300,
  res = 300
)
print(p3_pm10$plot)
dev.off()

p3_pm25 <- TheilSen(bd3, 
                    pollutant = "PM25", 
                    ylab = "PM25 (�g/m�)", 
                    xlab = "2024",
                    avg.time = "month",
                    deseason = TRUE,
                    date.format = "%b",
                    main = "Estaci�n CA-HU-09 Santa Mar�a de Huachipa - PM25",
                    slope.text = "unidad/mes")

# Guardar gráfico PM25 en PNG
png(
  type = "cairo-png",
  filename = "CA-HU-09_pm25.png",
  width = 6 * 300,
  height = 6 * 300,
  res = 300
)
print(p3_pm25$plot)
dev.off()
