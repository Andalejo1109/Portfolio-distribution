install.packages("ggplot2")
install.packages("tidyr")
install.packages("scales")

library(ggplot2)
library(tidyr)
library(scales)


# Parámetros
capital_inicial <- 200
aporte_mensual <- 50
anios <- 15
meses <- 0:(anios * 12)

# Tasas Anuales
tasas <- c(P1 = 0.18, P2 = 0.15, P3 = 0.1200)
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
       subtitle = "Simulación académica a 15 años con aportes mensuales de $50",
       x = "Años", y = "Capital Acumulado (USD)") +
  theme_minimal() +
  guides(linetype = "none")


# Gráfico Mejorado
grafico_estilizado <- ggplot(df_long, aes(x = Anio, y = Valor, color = Estrategia)) +
  
  # 1. Ajuste de líneas: Usamos 'linewidth' (el nuevo estándar) y un poco de transparencia
  geom_line(aes(linetype = Estrategia == "Total_Invertido"), linewidth = 1.2, alpha = 0.85) +
  
  # 2. Paleta de colores moderna y nombres limpios para la leyenda
  scale_color_manual(
    values = c(
      "Portafolio_1" = "#00b4d8",      # Cian vibrante (Moderno y tecnológico)
      "Portafolio_2" = "#f77f00",      # Naranja cálido (Alto contraste)
      "SP500_P3" = "#8338ec",          # Morado elegante para el benchmark
      "Total_Invertido" = "#343a40"    # Gris oscuro/Casi negro para la base
    ),
    labels = c(
      "Portafolio 1 (18%)", 
      "Portafolio 2 (15%)", 
      "S&P 500 (12.00%)", 
      "Capital Aportado"
    )
  ) +
  
  # 3. Formato del eje Y: Resumido en miles ('k') para que sea más fácil de leer
  scale_y_continuous(labels = dollar_format(scale = 1/1000, suffix = "k")) +
  
  # 4. Formato del eje X: Marcas cada 3 años para no saturar
  scale_x_continuous(breaks = seq(0, 15, by = 3)) +
  
  # 5. Títulos y etiquetas mejor estructurados
  labs(
    title = "El Poder del Interés Compuesto y la Diversificación",
    subtitle = "Proyección a 15 años: Estrategias Propias vs. S&P 500 (Aportes de $50/mes)",
    x = "Años de Inversión",
    y = "Capital Acumulado (Miles de USD)",
    caption = "Nota: Ejercicio académico. Rendimientos basados en promedios históricos a 5 años."
  ) +
  
  # 6. Tema completamente personalizado
  theme_minimal(base_family = "sans", base_size = 14) +
  theme(
    # Estilos de texto
    plot.title = element_text(face = "bold", size = 18, color = "#2b2d42", margin = margin(b = 8)),
    plot.subtitle = element_text(size = 12, color = "#6c757d", margin = margin(b = 20)),
    plot.caption = element_text(size = 9, color = "#adb5bd", face = "italic", hjust = 0, margin = margin(t = 15)),
    
    # Ejes
    axis.title.x = element_text(margin = margin(t = 12), color = "#495057", face = "bold"),
    axis.title.y = element_text(margin = margin(r = 12), color = "#495057", face = "bold"),
    axis.text = element_text(color = "#6c757d"),
    
    # Fondo y cuadrícula: Eliminamos la menor para un look más limpio
    panel.grid.major = element_line(color = "#e9ecef", linewidth = 0.5),
    panel.grid.minor = element_blank(),
    
    # Leyenda: Movida abajo para darle todo el ancho disponible al gráfico
    legend.position = "bottom",
    legend.title = element_blank(),
    legend.text = element_text(size = 11, color = "#495057"),
    legend.key.width = unit(2, "cm"), # Líneas más largas en la leyenda para mayor claridad
    
    # Márgenes generales del gráfico
    plot.margin = margin(t = 20, r = 25, b = 20, l = 20)
  ) +
  guides(linetype = "none") # Ocultamos la leyenda duplicada del tipo de línea

# Mostrar el gráfico
print(grafico_estilizado)  


# Instalar los paquetes necesarios
install.packages("gganimate")
install.packages("gifski") # Motor necesario para renderizar el GIF

library(gganimate)
library(gifski)

# 1. Reconstruimos el gráfico base (sin las etiquetas finales estáticas)
grafico_base_anim <- ggplot(df_long, aes(x = Anio, y = Valor, color = Estrategia)) +
  geom_line(aes(linetype = Estrategia == "Total_Invertido"), linewidth = 1.2, alpha = 0.85) +
  scale_color_manual(
    values = c("Portafolio_1" = "#00b4d8", "Portafolio_2" = "#f77f00", 
               "SP500_P3" = "#8338ec", "Total_Invertido" = "#343a40"),
    labels = c("Portafolio 18%", "Portafolio 15%", "S&P 500", "Capital Aportado")
  ) +
  scale_y_continuous(labels = dollar_format(scale = 1/1000, suffix = "k")) +
  scale_x_continuous(breaks = seq(0, 15, by = 1)) +
  labs(
    title = "Crecimiento del Portafolio: Año {frame_along}", # El título se actualiza dinámicamente!
    subtitle = "Aportes DCA de $50 mensuales",
    x = "Años",
    y = "Valor Acumulado (Miles USD)"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(face = "bold", size = 18),
    legend.position = "bottom",
    legend.title = element_blank()
  ) +
  guides(linetype = "none")

# 2. Agregar la "magia" de la animación
grafico_animado <- grafico_base_anim + 
  transition_reveal(Anio) # Esto hace que las líneas se dibujen a lo largo del eje X (Años)

# 3. Renderizar y guardar el GIF (Esto puede tomar unos 15-30 segundos en procesar)
# Ajustamos los frames (fps) y la duración para que sea fluido
anim_save(
  "crecimiento_portafolios.gif", 
  animation = grafico_animado, 
  renderer = gifski_renderer(),
  width = 800, 
  height = 500, 
  fps = 15, 
  duration = 15 # El GIF durará 15 segundos
)