# Portfolio-distribution

Comparación de resultados de portafolio a partir del rendimiento anual de los últimos 5 años.

# Simulador de interés compuesto y DCA: portafolios vs S&P 500

Ejercicio académico de ciencia de datos aplicado a finanzas personales. Modela el impacto a largo plazo del interés compuesto y del *dollar-cost averaging* (DCA) comparando estructuras de portafolio frente al rendimiento histórico aproximado del mercado.

## Objetivo

Mostrar, con números, cómo variaciones pequeñas en la tasa anual (CAGR) y en la diversificación sectorial abren brechas grandes de capital en un horizonte de 15 años.

Tres escenarios:

- **Portafolio 1:** core de crecimiento y semiconductores, con base de mercado total de EE. UU. (SPYG 35%, SMH 20%, BRK.B 20%, IEMG 15%, VTI 10%).
- **Portafolio 2:** más concentrado en crecimiento y emergentes, sin VTI (SPYG 40%, SMH 20%, BRK.B 20%, IEMG 20%).
- **Portafolio 3 (benchmark):** rendimiento histórico aproximado del S&P 500 (~12% anual).

## Histórico de rendimientos por activo (2021–2025)

Retornos anuales al cierre de diciembre.

| Activo / ETF | Sector / índice | 2021 | 2022 | 2023 | 2024 | 2025 |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **SMH** | Semiconductores | 42.14% | -33.52% | 73.37% | 39.08% | 49.17% |
| **SPYG** | S&P 500 Growth | 32.01% | -29.42% | 30.02% | 35.99% | 22.08% |
| **BRK.B** | Berkshire Hathaway | 29.57% | 4.00% | 15.77% | 25.49% | 10.85% |
| **VTI** | Total Stock Market | 25.72% | -19.50% | 26.03% | 23.75% | 17.14% |
| **IEMG** | Mercados emergentes | -0.64% | -19.87% | 11.31% | 6.92% | 32.12% |

## Ponderación y rendimiento anual por portafolio

| Activo | Peso Portafolio 1 | Peso Portafolio 2 |
| :--- | :--- | :--- |
| **SPYG** | 35% | 40% |
| **SMH** | 20% | 20% |
| **BRK.B** | 20% | 20% |
| **IEMG** | 15% | 20% |
| **VTI** | 10% | 0% |

### Rendimiento anual ponderado

| Año | Portafolio 1 | Portafolio 2 | Diferencia (P1 vs P2) |
| :--- | :--- | :--- | :--- |
| **2021** | 28.02% | 27.02% | +1.00% |
| **2022** | -21.13% | -21.65% | +0.52% |
| **2023** | 32.63% | 32.10% | +0.53% |
| **2024** | 28.92% | 28.69% | +0.23% |
| **2025** | 26.26% | 27.26% | -1.00% |
| **Media aritmética (5 años)** | **18.94%** | **18.68%** | **+0.26%** |

La media aritmética es el promedio simple de los rendimientos anuales. Para la proyección a 15 años se usa la **CAGR**, que incorpora la caída de 2022: **14.64%** (P1) y **14.24%** (P2).

## Tecnologías

- **Lenguaje:** R
- **Librerías:** `ggplot2`, `tidyr`, `scales`

## Metodología

Valor futuro con aportaciones periódicas y capitalización mensual:

$$FV = PV(1 + r)^n + PMT \left[ \frac{(1 + r)^n - 1}{r} \right]$$

Parámetros base:

- **Capital inicial (PV):** $10,000 USD
- **Aporte mensual (PMT):** $1,000 USD
- **Horizonte (n):** 15 años (180 meses)

## Cómo ejecutarlo

```bash
git clone https://github.com/Andalejo1109/Portfolio-distribution.git
```

En la consola de R:

```r
install.packages(c("ggplot2", "tidyr", "scales"))
```

Luego ejecuta `simulador_portafolios.R`.

## Resultados

El script genera un gráfico de líneas del capital acumulado mes a mes. Incluye una línea base de “Total aportado” ($190,000 USD al final del periodo) para aislar la ganancia neta del interés compuesto.

![Gráfico de simulación](Plot2.jpg)

## Disclaimer

Fines educativos. Los rendimientos históricos no garantizan resultados futuros. Invertir implica riesgo de pérdida de capital.

## Autor

Alejandro Rodríguez / andalejo1109 — data scientist.

- LinkedIn: [linkedin.com/in/andalejo](https://www.linkedin.com/in/andalejo/)
- Perfil en eToro: [@Andalejo1109](https://etoro.tw/4lkmjxn)
