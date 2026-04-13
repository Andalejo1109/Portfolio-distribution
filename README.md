# Portfolio-distribution
Compared the portfolio results based on the annual return of last 5 years

# 📈 Simulador de Interés Compuesto y DCA: Análisis de Portafolios vs S&P 500

Este proyecto es un ejercicio netamente académico de ciencia de datos aplicado a las finanzas personales. Su objetivo principal es modelar y visualizar el impacto a largo plazo del interés compuesto y la estrategia de promediamiento de costo en dólares (DCA - Dollar Cost Averaging) mediante la comparación de diferentes estructuras de portafolio frente al rendimiento histórico del mercado total.

## 🎯 Objetivo del Proyecto

El análisis busca demostrar matemáticamente cómo pequeñas variaciones en la tasa de rendimiento anual (CAGR) y la diversificación sectorial pueden generar brechas significativas en la acumulación de capital a lo largo de un horizonte de inversión de 15 años.

Se evalúan tres escenarios:
* **Portafolio 1:** Estrategia Core enfocada en crecimiento y semiconductores, manteniendo una base del mercado total estadounidense (SPYG 35%, SMH 20%, BRK.B 20%, IEMG 15%, VTI 10%).
* **Portafolio 2:** Estrategia con mayor concentración en crecimiento y mercados emergentes, excluyendo el mercado total (SPYG 40%, SMH 20%, BRK.B 20%, IEMG 20%).
* **Portafolio 3 (Benchmark):** Rendimiento histórico aproximado del S&P 500 (~12% anual).

## 🛠️ Tecnologías y Herramientas

* **Lenguaje:** R
* **Librerías principales:** * `ggplot2` (Visualización de datos de alto nivel).
    * `tidyr` (Manipulación y estructuración de datos en formato *long*).
    * `scales` (Formateo de escalas financieras y porcentuales).

## 🧮 Metodología y Fórmulas

La simulación se construye utilizando la fórmula de valor futuro (Future Value) para interés compuesto con aportaciones periódicas, adaptada para capitalización mensual:

$$FV = PV(1 + r)^n + PMT \left[ \frac{(1 + r)^n - 1}{r} \right]$$

**Parámetros base de la simulación:**
* **Capital Inicial (PV):** $10,000 USD
* **Aporte Mensual (PMT):** $1,000 USD
* **Horizonte de tiempo (n):** 15 años (180 meses)

## 🚀 Cómo ejecutar el proyecto

1. Asegúrate de tener instalado R y RStudio (o tu entorno preferido).
2. Clona este repositorio:
   ```bash
   git clone [(https://github.com/Andalejo1109/Portfolio-distribution/)]
   
3. Instala las dependencias necesarias ejecutando en la consola de R:

R
install.packages(c("ggplot2", "tidyr", "scales"))
Ejecuta el script principal simulador_portafolios.R.

## 📊 Resultados y Visualización

El script genera un gráfico de líneas comparativo que ilustra la curva exponencial del capital acumulado mes a mes. Se incluye una línea base de "Total Aportado" ($190,000 USD al final del periodo) para aislar visualmente la ganancia neta generada exclusivamente por el efecto del interés compuesto.

Añadir aquí una captura de pantalla del gráfico generado por R.
![Gráfico de Simulación](ruta_de_tu_imagen.png)

## ⚠️ Disclaimer

Este repositorio y el código contenido en él tienen fines única y exclusivamente educativos y académicos. 

Los rendimientos históricos utilizados en la simulación no son garantía de resultados futuros. 

La inversión en mercados financieros conlleva riesgos de pérdida de capital. 

Toda decisión de inversión debe basarse en un análisis de riesgo individual.

✒️ Autor
[Alejandro Rodriguez / andalejo1109] - Data Scientist - [LinkedIn: (https://www.linkedin.com/in/andalejo/)]
