Install.packages("ggplot2")
Install.packages("tidyr")
Install.packages("scales")

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
  
