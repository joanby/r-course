# Cambios de la rama `update-2026`

> Esta rama es el mismo curso —Curso completo de Machine Learning: Data Science con RStudio—, con el código
> adaptado a R y los paquetes de hoy (R 4.5.3, caret 7.0, igraph 2.3, sf 1.1, sp 2.2, ggplot2 4.0; octubre de
> 2026). La rama principal sigue exactamente como en el vídeo.

> **Cómo se ha comprobado.** Los scripts del curso están pensados para ejecutarse línea a línea en RStudio, con el
> directorio de trabajo en `scripts/` (por eso leen `../data/…`), y llevan líneas que fallan a propósito
> ("FALLOS A TENER EN CUENTA"). Cada script se ha ejecutado **línea a línea**, como en RStudio, dos veces: con R y
> paquetes de finales de 2019 y con los de hoy. Lo que solo fallaba hoy se ha arreglado: **no queda ninguna línea
> que funcionara entonces y falle hoy.** De los 108 ficheros (las dos apps de Shiny no se lanzan: son servidores),
> 79 se ejecutan sin ningún error.
>
> **Lo que sigue fallando, igual que con el R de entonces, y no se ha tocado:**
> - **Necesita internet o un servicio externo** (no accesible desde el entorno de prueba): descargas de Yahoo
>   Finance (`03-analisis-json.R`, `01-financial-data.R`), MovieLens, el `biocLite.R` de Bioconductor (hoy se
>   instala con `BiocManager`), mapas de Google (`ggmap` pide hoy una clave de API: `register_google()`), las APIs
>   de Meetup y Twitter, MySQL, MongoDB y Spark (tema 13).
> - **Datos que no están en el repositorio así:** `creditcard.csv` viene comprimido (`creditcard.csv.zip`:
>   descomprímelo antes) y `chicago-full-crimes.csv` no está (sí `chicago-crime.csv`).
> - **Scripts que usan algo de un script anterior** (en el vídeo se ejecutan en la misma sesión de RStudio):
>   `aregImpute` (paquete `Hmisc`), `bwplot` (`lattice`), `rmse`, `auto.arima` (`forecast`). Carga el paquete o
>   ejecuta antes el script anterior.
> - **Errores del propio código**, como en el vídeo: `read.csv(..., strings.na = "")` (es `na.strings`),
>   `setwd("tema13")` desde otra carpeta, y alguno más.
> - Paquetes que no estaban en el entorno de prueba: `sentiment` (tema 3; se instalaba desde el archivo de CRAN) y
>   `twitteR` (tema 9; además, la API de Twitter de entonces ya no existe).

## Qué ha cambiado y por qué

### Paquetes retirados de CRAN

- **`maptools` y `rgdal`** (tema 12, mapas) se retiraron de CRAN en 2023. Se cambian solo las líneas que los usaban
  y todo lo demás (los objetos de `sp`, `spplot`…) sigue como en el vídeo:
  - `readOGR(carpeta, capa)` → `as(sf::st_read(carpeta, capa, stringsAsFactors = TRUE), "Spatial")`.
  - `map2SpatialPolygons(nj.map, IDs = nj.county, …)` →
    `spChFIDs(as(sf::st_geometry(sf::st_as_sf(nj.map)), "Spatial"), nj.county)`.
  - `spCbind(nj.spdf, pop.density)` → `nj.spdf$pop.density <- pop.density`.
- **`dummies`** (tema 1, variables dummy) se retiró de CRAN y no funciona con R 4.3 o posterior. Lo sustituye
  `fastDummies`: `dummy.data.frame(students, sep = ".")` → `dummy_cols(students, remove_selected_columns = TRUE)`.
  Salen las mismas columnas, con otro nombre (`State_NJ` en vez de `State.NJ`) y al final de la tabla.

### R y paquetes

- **R 4.0: `read.csv()` ya no convierte el texto en factores.** `boxplot(auto)` (tema 2, gráficos) fallaba con la
  columna de texto `car_name`; la lectura lleva ahora `stringsAsFactors = TRUE`, como hacía R cuando se grabó.
- **caret 7** reparte los datos de entrenamiento de otra forma aunque la semilla sea la misma, así que el árbol de
  clasificación (tema 3) sale distinto y su tabla `cptable` tiene menos filas: la poda usaba la fila 8, que ya no
  existe. Ahora usa la penúltima, que es lo que era la fila 8 en el vídeo. Los números de ese tema no coincidirán
  con los del vídeo.
- **igraph 2:** `graph.incidence()` ya no acepta un `data.frame` (tema 9, grafo bipartito):
  `graph.incidence(as.matrix(membership))`.

### Otras correcciones

- `../data/tema6/INFY-monthly.csv` → `infy-monthly.csv` (tema 6, series temporales), que es como se llama el
  fichero: en Mac y Windows da igual mayúsculas que minúsculas, en Linux no.
- **Caché de knitr subida al repositorio** (`scripts/tema10/intro-markdown_cache`): se ha borrado; RStudio la vuelve
  a crear.

Si te sale el aviso de que una función está *deprecated* (por ejemplo `graph.incidence()`, hoy
`graph_from_biadjacency_matrix()`), el código sigue funcionando: son avisos amarillos.
