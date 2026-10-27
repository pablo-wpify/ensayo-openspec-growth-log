# Anexo C. Riesgos y decisiones de privacidad

> Anexo de la primera entrega de Growth Log. El resumen está en la [sección 9 del README](../README.md#9-decisiones-abiertas-y-riesgos).

## C.1. Riesgos del MVP

Riesgos del diseño propuesto. Todos son **inferidos**: el MVP no está
construido.

| # | Riesgo | Mitigación propuesta |
|---|---|---|
| RN-1 | **Fuga de feedback por una acción sin política.** Una ruta nueva olvida pasar por la autorización. | Denegar por defecto; consultas con alcance; un test que recorre todas las acciones de entradas (MVP-BE-1). |
| RN-2 | **«Lista» confundida con «compartida».** El líder cree que marcar como lista la hace visible. | Textos separados, nunca «Publicar»; aviso al compartir (MVP-FE-1). |
| RN-3 | **Hipótesis de valor sin validar** (HV-1 a HV-4). | Pruebas de uso y un piloto antes de ampliar el alcance. |
| RN-4 | **Resúmenes distintos parecen un error.** Dos líderes de la misma persona ven cifras diferentes (4.12). | Indicar qué entradas son propias y cuáles compartidas. |
| RN-5 | **Datos sensibles fuera de la aplicación.** El feedback termina en logs o en un servicio externo de errores. | Filtrar el feedback de logs y reportes (2.5); elegir servicios con eso en cuenta (ADR-8). |
| RN-6 | **Alcance.** Sumar funciones fuera de las cinco historias retrasa el MVP. | Limitarse a las cinco historias y llevar el resto al backlog. |
| RN-7 | **Decisiones de privacidad sin resolver** (D1, D2, D5) bloquean el modelo de datos. | Resolverlas en la fase 1 del plan, antes de MVP-DB-1. |

## C.2. Decisiones de privacidad en detalle

No se anticipa el diseño de tablas hasta resolverlas.

| # | Decisión | Qué bloquea |
|---|---|---|
| D1 | **Asignación y administración.** Quién asigna líderes a personas y si habrá administradores. Incluye quién crea las cuentas, a quién queda asignada una persona nueva, quién edita sus datos si tiene varios líderes y qué pasa con el acceso cuando un líder deja de acompañar a una persona. | H1 (1.6, 1.12), MVP-DB-1 |
| D2 | **Destinatarios y revocación.** Cómo se eligen los destinatarios de una entrada compartida (todos los líderes de la persona, líderes elegidos o un rol), si tienen que acompañar a la persona y cómo se revoca una compartición. | H5 (5.6, 5.7), MVP-DB-1, MVP-BE-1, ADR-4 |
| D3 | **Escalar.** Si hace falta algo más que compartir, por ejemplo escalar un caso, y cómo funcionaría. | H5 |
| D4 | **Acceso de la persona acompañada.** Si en el futuro verá su propio feedback, y qué parte. | ninguno del MVP; puede afectar el modelo de datos |
| D5 | **Salida de un autor.** Cómo se conservan o transfieren sus entradas (PP-7). Las alternativas están en el [Anexo D](anexo-d-decisiones-arquitectura.md). | MVP-DB-1 |

## C.3. Otras decisiones de Pablo

- Confirmar PP-1 a PP-7 como política del MVP y los criterios 3.9, 4.11 y
  4.12 que se desprenden de ella.
- Definir la lista de dimensiones.

---

[Volver al README](../README.md)
