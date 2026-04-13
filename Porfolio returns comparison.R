install.packages("ggplot2")
install.packages("tidyr")
install.packages("scales")

library(ggplot2)
library(tidyr)
library(scales)

# Parámetros
capital_inicial <- 10000
aporte_mensual <- 1000
anios <- 15
meses <- 0:(anios * 12)

# Tasas Anuales
tasas <- c(P1 = 0.1464, P2 = 0.1424, P3 = 0.1200)
tasas_m <- tasas / 12

# Función de Valor Futuro
calcular_fv <- function(r, t, pv, pmt) {
  fv <- pv * (1 + r)^t + pmt * (((1 + r)^t - 1) / r)
  fv[t == 0] <- pv
  return(fv)
}

# Generar Datos
df <- data.frame(
  Mes = meses,
  Anio = meses / 12,
  Portafolio_1 = calcular_fv(tasas_m["P1"], meses, capital_inicial, aporte_mensual),
  Portafolio_2 = calcular_fv(tasas_m["P2"], meses, capital_inicial, aporte_mensual),
  SP500_P3 = calcular_fv(tasas_m["P3"], meses, capital_inicial, aporte_mensual),
  Total_Invertido = capital_inicial + (aporte_mensual * meses)
)

# Formato Largo para ggplot
df_long <- pivot_longer(df, cols = -c(Mes, Anio), names_to = "Estrategia", values_to = "Valor")

# Gráfico
ggplot(df_long, aes(x = Anio, y = Valor, color = Estrategia)) +
  geom_line(aes(linetype = Estrategia == "Total_Invertido"), size = 1.1) +
  scale_y_continuous(labels = dollar_format()) +
  scale_color_manual(values = c("#1b9e77", "#d95f02", "#377eb8", "#000000")) +
  labs(title = "Comparativa: Estrategias Propias vs S&P 500",
       subtitle = "Simulación académica a 15 años con aportes mensuales de $1,000",
       x = "Años", y = "Capital Acumulado (USD)") +
  theme_minimal() +
  guides(linetype = "none")

###
###Optimización de la visualización:
###

# 1. Crear un subset con el último valor de cada estrategia
puntos_finales <- subset(df_long, Anio == 15)

# 2. Generar el gráfico con las etiquetas finales
grafico_final <- ggplot(df_long, aes(x = Anio, y = Valor, color = Estrategia)) +
  
  # Líneas principales
  geom_line(aes(linetype = Estrategia == "Total_Invertido"), linewidth = 1.2, alpha = 0.85) +
  
  # CAPA NUEVA: Etiquetas de texto al final de las líneas
  geom_text(
    data = puntos_finales,
    aes(label = paste0("$", round(Valor/1000), "k")),
    hjust = -0.2,            # Mueve el texto a la derecha del punto final
    vjust = 0.5,             # Centra verticalmente respecto a la línea
    fontface = "bold",
    size = 4,
    show.legend = FALSE      # No incluir la 'a' en la leyenda
  ) +
  
  # Colores y leyenda
  scale_color_manual(
    values = c(
      "Portafolio_1" = "#00b4d8", 
      "Portafolio_2" = "#f77f00", 
      "SP500_P3" = "#8338ec", 
      "Total_Invertido" = "#343a40"
    ),
    labels = c("Portafolio 1 (14.64%)", "Portafolio 2 (14.24%)", "S&P 500 (12.00%)", "Capital Aportado")
  ) +
  
  # Ajuste del Eje Y (Miles)
  scale_y_continuous(labels = dollar_format(scale = 1/1000, suffix = "k")) +
  
  # Ajuste del Eje X: Agregamos un 15% de espacio extra a la derecha para las etiquetas
  scale_x_continuous(
    breaks = seq(0, 15, by = 3), 
    expand = expansion(mult = c(0.02, 0.15)) 
  ) +
  
  # Títulos y Estética Profesional
  labs(
    title = "Crecimiento Proyectado: Estrategias Propias vs. S&P 500",
    subtitle = "Valores finales tras 15 años de aportes mensuales ($1,000/mes)",
    x = "Años",
    y = "Valor Acumulado (Miles de USD)",
    caption = "Ejercicio académico. Fuente: Datos históricos promedio 2021-2025."
  ) +
  
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(face = "bold", size = 18, color = "#2b2d42"),
    plot.subtitle = element_text(size = 12, color = "#6c757d", margin = margin(b = 20)),
    panel.grid.minor = element_blank(),
    legend.position = "bottom",
    legend.title = element_blank(),
    plot.margin = margin(20, 20, 20, 20)
  ) +
  guides(linetype = "none")

# Mostrar resultado
print(grafico_final)
  
