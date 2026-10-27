# prompts.md — Growth Log

> Flujos de trabajo con asistentes de IA en la preparación de la primera
> entrega de Growth Log, con su herramienta, modelo, fase, resultado y
> criterio humano. El texto de cada prompt está en el [Anexo F](anexos/anexo-f-registro-prompts.md). La
> plantilla pide hasta 3 prompts por sección; cada flujo indica a qué
> sección corresponde.

## Quién hizo qué

En la preparación de esta entrega, **Pablo definió el objetivo y tomó
decisiones; los pedidos se prepararon con ayuda de ChatGPT y se ejecutaron
con Claude Code.** Cada parte se atribuye solo hasta donde llega la
evidencia:

| Parte del trabajo | Quién o qué | Evidencia |
|---|---|---|
| Objetivo y decisiones | **Pablo** | reflejados en los pedidos y en la elección entre las opciones que presentó el asistente |
| Preparación de los pedidos | con ayuda de **ChatGPT** | solo lo declarado por Pablo el 27/10/2026. No se conservan esas conversaciones, no consta el modelo y no se puede distinguir qué parte de cada texto aportó ChatGPT |
| Ejecución | **Claude Code (CLI)** con **Claude Opus 5.5** (`claude-opus-5-5`) | comprobado en la transcripción local de la sesión del 27/10/2026 (no se comparte): texto literal, herramienta y modelo de cada flujo |

## Contexto avanzado y herramientas utilizadas

Lo que se usó realmente en la preparación de esta entrega, según la
transcripción de la sesión y los archivos de configuración:

| Elemento | ¿Se usó? | Evidencia |
|---|---|---|
| Skills | **no** | ninguna invocación en la transcripción |
| Subagentes | **sí, uno**: `web-fetch`, para leer la publicación de LinkedIn que inspira la matriz de confiabilidad (27/10/2026) | transcripción |
| `CLAUDE.md` del proyecto o del usuario | **no** | no existe en las carpetas de trabajo ni en la configuración del usuario |
| Rules | **no** | no hay archivos de reglas |
| Memoria persistente | **no** | el directorio de memoria del proyecto está vacío |
| Servidores MCP | **no** | ninguna llamada a herramientas MCP |
| Instrucciones de la cuenta | **sí** | el entorno tenía instrucciones generales configuradas en la cuenta, no específicas de este proyecto, sobre cómo organizar y delegar el trabajo. No se publican. |
| Herramientas del asistente | **sí** | terminal, lectura y edición de archivos y una pregunta al usuario. Con ellas: scripts de Python para generar y verificar la documentación, Chrome sin interfaz para renderizar los diagramas y los mocks, y `gh` en modo lectura para obtener la plantilla del curso. |

## Qué se publica

Este registro publica **tres flujos** de la preparación de la entrega. Otros
flujos de la misma preparación (por ejemplo, la elaboración de los mocks y
las revisiones de la documentación) **no se incluyen** en esta versión
pública. Dentro de los prompts publicados, los fragmentos omitidos están
marcados como «[fragmento omitido]»; el resto es literal.

## Resumen

| # | Flujo | Fase | Sección de la plantilla | Resultado |
|---|---|---|---|---|
| 1 | Política de privacidad para varios líderes | diseño de producto | 1.2, 2.5, 3, 5 | PP-1 a PP-7 propuestas, criterios y decisiones D1 a D5 |
| 2 | La presentación como fuente de la visión | producto | 1.1 | problema, destinatarios e hipótesis de valor HV-1 a HV-6 |
| 3 | Arquitectura, modelo de datos y stack | diseño técnico | 2, 3, 4, 6 | arquitectura, modelo conceptual, stack con alternativas, tickets y ADR |

---

## Flujo 1. Política de privacidad para varios líderes

*Secciones 1.2, 2.5, 3 y 5 de la plantilla.*

| Campo | Detalle |
|---|---|
| Fase | diseño de producto: privacidad y autorización |
| Herramientas | Ejecución: Claude Code (CLI) con Claude Opus 5.5 (`claude-opus-5-5`), comprobado en la transcripción. Preparación del pedido: con ayuda de ChatGPT, según lo declarado por Pablo; sin registro propio. Objetivo y decisiones: Pablo. |
| Fecha | 27/10/2026 |

**Extracto literal:**

> La regla general es privacidad por defecto y compartición explícita:
>
> Diferenciá «lista» de «compartida»: el estado indica que la entrada
> está preparada; la visibilidad determina quién puede verla.

Texto completo: [Anexo F, flujo 1](anexos/anexo-f-registro-prompts.md#flujo-1-política-de-privacidad-para-varios-líderes).

**Resultado:** política propuesta PP-1 a PP-7, criterios propuestos en las
cinco historias (entre ellos 3.9, 4.11 y 4.12), el ticket de base de datos
condicionado a las decisiones y los riesgos asociados.

**Criterio humano (Pablo):**

- Growth Log es para varios líderes en una misma instancia;
- privacidad por defecto y compartición explícita;
- «lista» no es «compartida»;
- dejar abiertas D1 a D5, sin anticipar el diseño de tablas.

---

## Flujo 2. La presentación como fuente de la visión

*Sección 1.1 de la plantilla.*

| Campo | Detalle |
|---|---|
| Fase | producto: visión, problema e hipótesis |
| Herramientas | Ejecución: Claude Code (CLI) con Claude Opus 5.5 (`claude-opus-5-5`), comprobado en la transcripción. Preparación del pedido: con ayuda de ChatGPT, según lo declarado por Pablo; sin registro propio. Objetivo y decisiones: Pablo. |
| Fecha | 27/10/2026 |

**Extracto literal:**

> En particular, no presentes como resultados medidos la captura en
> 30 segundos, la reducción de sesgos o la mejora de las evaluaciones.
>
> Integrá estas conclusiones a la propuesta de documentación y citá
> el PDF como fuente de la visión.

Texto completo: [Anexo F, flujo 2](anexos/anexo-f-registro-prompts.md#flujo-2-la-presentación-como-fuente-de-la-visión).

**Resultado:** el problema, los destinatarios y el supuesto de adopción
tomados de la presentación «El problema de evaluar de memoria», y la tabla
de hipótesis de valor HV-1 a HV-6.

**Criterio humano (Pablo):**

- usar la presentación como fuente de la visión, sin publicarla;
- tratar la captura en unos 30 segundos, la reducción del sesgo y la mejora
  de las evaluaciones como hipótesis, no como resultados;
- distinguir la privacidad efectiva y el acceso de la persona acompañada
  entre propuesta y decisión abierta.

---

## Flujo 3. Arquitectura, modelo de datos y stack

*Secciones 2, 3, 4 y 6 de la plantilla.*

| Campo | Detalle |
|---|---|
| Fase | diseño técnico del MVP |
| Herramientas | Ejecución: Claude Code (CLI) con Claude Opus 5.5 (`claude-opus-5-5`), comprobado en la transcripción. Preparación del pedido: con ayuda de ChatGPT, según lo declarado por Pablo; sin registro propio. Objetivo y decisiones: Pablo. |
| Fecha | 27/10/2026 |

**Extracto literal:**

> Tomá esto como propuesta inicial, no como una decisión irrevocable ni
> como una descripción de lo que ya está construido.
>
> No afirmes que los permisos, el CI, los backups o el despliegue existen:
> son requisitos o propuestas hasta que se implementen y verifiquen.

Texto completo: [Anexo F, flujo 3](anexos/anexo-f-registro-prompts.md#flujo-3-arquitectura-modelo-de-datos-y-stack).

**Resultado:** la arquitectura propuesta, el modelo conceptual con cinco
entidades, la tabla de stack y alternativas, las rutas propuestas, los
tickets MVP-DB-1, MVP-BE-1 y MVP-FE-1, la matriz de confiabilidad y los
borradores de ADR (Anexo D).

**Criterio humano (Pablo):**

- partir de un monolito Rails con PostgreSQL como propuesta a evaluar, no
  como decisión, y no fijar versiones sin verificar;
- al revisar el resultado: incluir en H4 la consulta cronológica de la
  evidencia, tratar la calibración como un uso posible sin puntaje calculado
  y presentar la desactivación de autores y las filas de compartición como
  alternativas sujetas a D5 y D2.

---

## Secciones de la plantilla sin prompts registrados

| Sección | Estado |
|---|---|
| 2.6. Tests | **Pendiente:** no hay tests ni prompts que los generen todavía. |
| 7. Pull requests | **Pendiente:** corresponde a entregas siguientes. |
