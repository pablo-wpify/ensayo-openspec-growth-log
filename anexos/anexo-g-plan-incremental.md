# Anexo G. Plan incremental

> Anexo de la primera entrega de Growth Log. El resumen está en la
> [sección 10 del README](../README.md#10-plan-de-trabajo-y-uso-de-ia).
> **Plan propuesto:** nada está implementado. No cambia historias,
> criterios, reglas ni decisiones; reorganiza la ejecución de los tickets
> MVP-DB-1, MVP-BE-2, MVP-BE-1 y MVP-FE-1
> ([sección 6](../README.md#6-tickets-de-trabajo)), que se conservan como
> referencia.

## G.1. Por qué por incrementos

Los cuatro tickets agrupan responsabilidades distintas. MVP-DB-1 reúne todo
el modelo en un solo ticket; MVP-BE-2, invitaciones, cuentas, personas y
asignaciones; MVP-BE-1, toda la autorización. Ejecutados uno detrás de otro,
el primer recorrido visible para un usuario llegaría al final. Además, la
interfaz que exigen H2, H4 y H5 (formulario completo, resumen, feed,
compartir y revocar) no tenía ticket propio. Aquí cada ticket se ejecuta
por partes, dentro de incrementos que terminan en un recorrido integrado.

## G.2. Hitos

| Hito | Se alcanza en | Qué significa |
|---|---|---|
| **Primer recorrido usable** | I1 | el administrador habilita una cuenta y asigna una persona; el líder guarda un borrador privado y vuelve a abrirlo, todo por la interfaz |
| **Flujo principal completo** | I6 | los cinco pasos del recorrido de la sección 1.2, integrados: incluye compartir, revocar y explorar el feed |
| **Alcance total del MVP** | I9 | los 67 criterios satisfechos y verificables, con la entrega real de correo de 1.1, y los controles comprometidos completos: recién entonces se pueden cargar datos reales (G.6). I8 completa todo lo demás |

Un recorrido que solo funciona con datos preparados no cuenta como
funcional. Los datos preparados se usan solo para pruebas aisladas, sobre
todo negativas.

## G.3. Tareas habilitadoras

No entregan un recorrido; preparan los incrementos.

| Tarea | Resultado | Procede de | Depende de | Aceptación verificable |
|---|---|---|---|---|
| E1 | proyecto Rails con CI, chequeo de salud y seeds solo de desarrollo | secciones 2.2 a 2.4 | ADR-1 | un pull request corre estilo, seguridad y tests en el CI; el chequeo de salud responde |
| E2 | inicio y cierre de sesión; cuenta administradora inicial por procedimiento documentado; sin registro público | MVP-BE-2, PP-1 | E1, ADR-2 | la cuenta inicial inicia sesión sin secretos en el repositorio; sin sesión, una ruta del producto no responde |
| E3 | autorización que deniega por defecto y fixtures con dos líderes y una administradora | MVP-BE-1, RN-1 | E1, ADR-3 | un test falla si una ruta queda sin política |
| E4 | controles previos a exponer el sistema: HTTPS forzado, CSP, límite de intentos en el inicio de sesión y en los enlaces de invitación, y feedback filtrado de los logs | sección 2.5, Anexo B | E2 | tests de configuración y de límite; un test confirma que el texto de una entrada no aparece en los logs. **Requisito de cualquier despliegue, también de prueba** |

## G.4. Incrementos y tareas

Las pruebas de permisos (PT) están en el
[Anexo A](anexo-a-historias.md#casos-de-prueba-de-permisos-pt).

### I1. Primer recorrido usable

**Resultado:** el administrador invita a un líder, que establece su
contraseña; crea una persona y se la asigna. El líder abre la ficha, guarda
una captura rápida como borrador privado y vuelve a abrirla.
**Decisiones que lo bloquean:** ADR-6 (herramienta E2E), además de las de
E1 a E3.
**Fuera de I1:** formulario completo, marcar como lista, resumen, feed,
compartir, terminar asignaciones y desactivar cuentas. El correo se
**captura en desarrollo**: prueba el flujo de invitación, pero no es
entrega real (I9).

| Tarea | Resultado | Procede de | Criterios | Depende de | Aceptación verificable |
|---|---|---|---|---|---|
| T1.1 | migraciones de cuentas, invitaciones, personas y asignaciones | MVP-DB-1 | soporte de H1 | E1 | tests de modelo: se guarda solo el resumen del token y no hay dos asignaciones activas iguales; la reversión se prueba en una base descartable |
| T1.2 | invitar y establecer la contraseña | MVP-BE-2 | 1.1 (parcial), 1.2, 1.3 | T1.1, E2 | pasan PT-7 y PT-8; el correo capturado no contiene contraseña ni feedback |
| T1.3 | vista de administración: crear y editar personas y asignar líderes | MVP-BE-2 | 1.4, 1.5, 1.8, 1.10 (parcial), 1.20 (parcial), 1.21 (parcial) | T1.1, E3 | el administrador puede y el líder no, también por URL directa; dos líderes asignados a la misma persona; una cuenta administradora asignada a una persona ve como líder solo esa persona |
| T1.4 | «Personas» y ficha mínima del líder | H1, sin ticket | 1.14 (parcial), 1.16, 1.17, 1.19 | T1.3 | sin asignación activa, el líder no abre la ficha, tampoco por URL directa |
| T1.5 | migración de entradas: autor y persona obligatorios, estado restringido | MVP-DB-1 | soporte de H2 y H3 | T1.1 | la base rechaza una entrada sin autor o con un estado inválido |
| T1.6 | captura rápida y reapertura del borrador propio | MVP-FE-1, MVP-BE-1 | 2.8, 3.1, 3.2, 2.9 (parcial), 2.10 (parcial), 3.8 (parcial), 4.8 (parcial) | T1.4, T1.5 | el borrador guarda autor y fecha de hoy y se reabre con sus datos |
| T1.7 | pruebas negativas del borrador | MVP-BE-1 | 4.9 (parcial), 4.11 (parcial), 1.10 (parcial) | T1.6, E3 | con dos líderes asignados y una administradora, solo el autor lee el borrador: ficha, detalle y URL directa |
| T1.8 | E2E del primer recorrido usable | sección 2.6 | — | T1.2 a T1.7 | el E2E pasa en el CI |

### I2. Completar y marcar como lista

**Resultado:** el líder completa su borrador o crea una entrada completa y
la marca como lista; sigue privada.
**Decisión que lo bloquea:** la lista de dimensiones (pendiente en el
[Anexo C](anexo-c-riesgos-decisiones.md#c4-otras-decisiones)).

| Tarea | Resultado | Procede de | Criterios | Depende de | Aceptación verificable |
|---|---|---|---|---|---|
| T2.1 | formulario completo «+ Feedback» en la ficha | H2, sin ticket | 2.1 a 2.5, 2.7, 2.10 | T1.6 | tests de validación y de sistema |
| T2.2 | editar el borrador y marcarlo como lista | MVP-FE-1 | 2.6, 2.9, 3.4 a 3.8 | T2.1 | una entrada incompleta sigue como borrador e indica qué falta; una lista sigue privada; ningún texto dice «Publicar»; ampliar T1.7 a entradas listas |

### I3. Consultar la evidencia por persona

**Resultado:** la ficha muestra el resumen por dimensión y la vista
cronológica de las entradas propias; el listado «Personas» cuenta solo lo
visible.
**Decisiones que lo bloquean:** ninguna nueva.

| Tarea | Resultado | Procede de | Criterios | Depende de | Aceptación verificable |
|---|---|---|---|---|---|
| T3.1 | consulta con alcance común para ficha, detalle y conteos | MVP-BE-1 | soporte de H4 | T2.2 | un test recorre todas las lecturas y ninguna consulta entradas fuera del alcance |
| T3.2 | resumen por dimensión y vista cronológica | H4, sin ticket | 3.3, 4.1, 4.4, 4.5, 4.2 (parcial), 4.3 (parcial), 4.13 (parcial) | T3.1 | un borrador no cuenta; el resumen aclara que no es un puntaje |
| T3.3 | conteo de entradas visibles en «Personas» | H1, sin ticket | 1.15 (parcial) | T3.1 | el conteo excluye borradores y entradas ajenas |

### I4. Compartir y revocar, con fin de asignación y reasignación

**Resultado:** un segundo líder, asignado por la interfaz, recibe una
entrada lista y la ve en su resumen. El autor la revoca. Terminar la
asignación del destinatario le quita el acceso, y reasignarlo no se lo
devuelve.
**Verificación en I4:** solo las rutas y vistas disponibles (ficha,
resumen y detalle). El feed llega en I6: PT-3 y PT-4 se completan allí.
**Decisión que lo bloquea:** confirmar la propuesta de ligar cada
compartición a la asignación del destinatario
([ADR-4](anexo-d-decisiones-arquitectura.md#adr-4-cómo-se-registra-una-compartición),
propuesta adicional no decidida) o elegir otra forma de cumplir D2.

| Tarea | Resultado | Procede de | Criterios | Depende de | Aceptación verificable |
|---|---|---|---|---|---|
| T4.1 | migración de comparticiones con revocación | MVP-DB-1 | soporte de H5 | T1.5, ADR-4 | tests de modelo: unicidad sin revocar, misma persona, destinatario distinto del autor |
| T4.2 | nombres de los otros líderes en la ficha | MVP-BE-1 | 1.18 | T1.4 | pasa PT-12 |
| T4.3 | compartir de a un destinatario, con la interfaz del mock 3 | MVP-BE-1, H5 | 3.9, 4.10, 5.6, 5.9 | T4.1, T4.2 | pasa PT-2; un borrador no se puede compartir |
| T4.4 | revocar por el autor | MVP-BE-1, H5 | 5.7 (parcial) | T4.3 | pasa PT-3 en la ficha, el resumen y el detalle; la rama del feed se completa en T6.1 |
| T4.5 | terminar una asignación y reasignar | MVP-BE-2, MVP-BE-1 | 1.20, 1.9 (parcial), 3.10 (parcial), 4.14 (parcial), 5.10 (parcial) | T4.3 | pasa PT-4 en la ficha, el resumen y el detalle; la rama del feed se completa en T6.1; sin asignación, el autor no edita ni comparte |
| T4.6 | lectura por compartición en ficha, resumen y detalle | MVP-BE-1 | 1.10, 1.15, 4.2, 4.3, 4.8, 4.9, 4.12, 4.13 | T4.3 a T4.5 | dos líderes ven resúmenes distintos; pasa el E2E de compartir de la sección 2.6: captura rápida, completar, marcar como lista, compartir y lectura en el resumen del destinatario, sin el feed |

### I5. Autor sin asignación

**Resultado:** un autor cuya asignación terminó sigue leyendo sus entradas
con datos mínimos y puede revocar sus comparticiones.
**Decisiones que lo bloquean:** qué datos mínimos ve el autor (detalle de
AM-1) y si el motivo del autor es opcional
([Anexo C](anexo-c-riesgos-decisiones.md#c3-reglas-que-cierran-las-ambigüedades)).

| Tarea | Resultado | Procede de | Criterios | Depende de | Aceptación verificable |
|---|---|---|---|---|---|
| T5.1 | vista mínima del autor sin asignación y revocación sin asignación | MVP-BE-1 | 1.9, 3.10, 4.14, 5.12 | T4.5 | pasa PT-11 |

### I6. Feed y filtros

**Resultado:** el líder explora en «Feedback» lo que puede ver, con
filtros en el feed y en la ficha. Con I6 queda completo el flujo principal.
**Decisiones que lo bloquean:** ninguna nueva.

| Tarea | Resultado | Procede de | Criterios | Depende de | Aceptación verificable |
|---|---|---|---|---|---|
| T6.1 | feed con alcance, orden y paginación | H5, sin ticket | 4.11, 5.1, 5.3, 5.4, 5.5, 5.7, 5.8, 5.10 | T3.1, T5.1 | el feed excluye borradores ajenos, privadas ajenas, comparticiones revocadas y las de asignaciones terminadas; completa PT-3 y PT-4 con la rama del feed |
| T6.2 | filtros sin recargar en el feed y en la ficha | H4, H5, sin ticket | 4.6, 4.7, 5.2 | T6.1 | los filtros solo devuelven entradas visibles y se pueden limpiar |

### I7. Ciclo de vida de cuentas y personas

**Resultado:** el administrador da de baja y reactiva personas y desactiva
cuentas. Las sesiones abiertas dejan de valer y siempre queda un
administrador activo.
**Decisiones que lo bloquean:** cómo se otorga o se quita el rol de
administrador: 1.12 lo menciona, pero ningún criterio lo define.

| Tarea | Resultado | Procede de | Criterios | Depende de | Aceptación verificable |
|---|---|---|---|---|---|
| T7.1 | baja y reactivación de personas | MVP-BE-2 | 1.6, 1.7, 1.14 | T1.3 | la persona inactiva desaparece de los listados y conserva su historial |
| T7.2 | desactivar cuentas e invalidar sus sesiones | MVP-BE-2 | 1.11, 5.11 | E2, T4.6 | pasan PT-5 y PT-6 |
| T7.3 | proteger al último administrador | MVP-BE-2 | 1.12 | T7.2 | pasa PT-9, incluida la prueba concurrente |
| T7.4 | cuenta con las dos funciones | MVP-BE-1 | 1.21 | T7.2, T6.1 | un test combinado de la vista de administración y de las vistas del líder |

### I8. Revocación administrativa

**Resultado:** el administrador consulta las comparticiones vigentes con
metadatos mínimos y revoca una con un motivo obligatorio, sin leerla.
**Decisión que lo bloquea:** qué metadatos ve el administrador (detalle de
AM-3, [Anexo C](anexo-c-riesgos-decisiones.md#c3-reglas-que-cierran-las-ambigüedades)).

| Tarea | Resultado | Procede de | Criterios | Depende de | Aceptación verificable |
|---|---|---|---|---|---|
| T8.1 | consulta y revocación administrativa | MVP-BE-1 | 1.13 | T4.4, T6.1 | pasan PT-10 y PT-1 completo, incluido el feed |

### I9. Preparación para datos reales

**Resultado:** la aplicación desplegada envía invitaciones reales y tiene
backups con una restauración probada.
**Decisiones que lo bloquean:** ADR-7 (despliegue y backups) y ADR-8
(proveedor de correo). ADR-5 (RLS) es opcional.

| Tarea | Resultado | Procede de | Criterios | Depende de | Aceptación verificable |
|---|---|---|---|---|---|
| T9.1 | despliegue solo con el CI en verde | sección 2.4, ADR-7 | — | E4 | la aplicación responde por HTTPS; un CI en rojo no despliega |
| T9.2 | entrega real de invitaciones | ADR-8 | 1.1 | T1.2, T9.1 | la invitación llega por el proveedor elegido, sin contraseña ni feedback |
| T9.3 | backups y restauración probada | sección 8, capa 3 | — | T9.1 | una restauración completa en una base descartable |
| T9.4 | seguimiento de errores sin contenido de feedback | sección 8, capa 8; ADR-8 | — | T9.1 | un error de prueba se registra sin el texto de la entrada |

## G.5. Cobertura de los 67 criterios

**Completo** significa satisfecho en todas sus ramas y verificable por la
interfaz y con tests. Un criterio que empieza antes figura también en la
segunda tabla.

| Completo en | Criterios | Cant. |
|---|---|---|
| I1 | 1.2, 1.3, 1.4, 1.5, 1.8, 1.16, 1.17, 1.19, 2.8, 3.1, 3.2 | 11 |
| I2 | 2.1 a 2.7, 2.9, 2.10, 3.4 a 3.8 | 14 |
| I3 | 3.3, 4.1, 4.4, 4.5 | 4 |
| I4 | 1.10, 1.15, 1.18, 1.20, 3.9, 4.2, 4.3, 4.8, 4.9, 4.10, 4.12, 4.13, 5.6, 5.9 | 14 |
| I5 | 1.9, 3.10, 4.14, 5.12 | 4 |
| I6 | 4.6, 4.7, 4.11, 5.1, 5.2, 5.3, 5.4, 5.5, 5.7, 5.8, 5.10 | 11 |
| I7 | 1.6, 1.7, 1.11, 1.12, 1.14, 1.21, 5.11 | 7 |
| I8 | 1.13 | 1 |
| I9 | 1.1 | 1 |
| **Total** | | **67** |

**Criterios que empiezan antes de completarse** (qué rama falta):

| Criterio | Empieza | Completo | Rama que falta al empezar |
|---|---|---|---|
| 1.1 | I1 | I9 | entrega real del correo |
| 1.9 | I4 | I5 | lectura del autor sin asignación |
| 1.10 | I1 | I4 | entradas compartidas con el administrador como líder asignado |
| 1.14 | I1 | I7 | solo personas activas (requiere la baja) |
| 1.15 | I3 | I4 | entradas compartidas en el conteo |
| 1.20 | I1 | I4 | terminar una asignación |
| 1.21 | I1 | I7 | gestión de cuentas y feed |
| 2.9 | I1 | I2 | entradas listas |
| 2.10 | I1 | I2 | formulario completo |
| 3.8 | I1 | I2 | marcar como lista |
| 3.10 | I4 | I5 | lectura de las propias entradas |
| 4.2, 4.3, 4.13 | I3 | I4 | entradas compartidas |
| 4.8 | I1 | I4 | detalle de entradas compartidas |
| 4.9 | I1 | I4 | comparticiones revocadas o sin asignación |
| 4.11 | I1 | I6 | el feed |
| 4.14 | I4 | I5 | datos mínimos de las propias entradas |
| 5.7, 5.10 | I4 | I6 | dejar de verla también en el feed |

**Sin cobertura:** ninguno. **Trabajo sin criterio propio:** E1 a E4 e I9
salen de requisitos no funcionales ya documentados (G.6). No se agregan
funciones nuevas.

## G.6. Requisitos no funcionales y uso de datos reales

| Requisito (sección 2.5 y Anexo B) | Tarea |
|---|---|
| autorización en el servidor, denegar por defecto, también por URL directa | E3, y las pruebas negativas de cada incremento |
| administración sin lectura de entradas | T1.7, T4.6, T8.1 |
| desactivación con invalidación de sesiones; siempre un administrador activo | T7.2, T7.3 |
| invitaciones de un solo uso y con vencimiento; sin contraseñas fijas | T1.2 |
| cuenta administradora inicial sin secretos en el repositorio | E2 |
| HTTPS, CSP, límite de intentos, feedback fuera de los logs | E4, antes de cualquier despliegue |
| índices para las consultas de visibilidad; paginación | T1.1, T1.5, T4.1, T6.1 |
| CI como condición para desplegar; chequeo de salud | E1, T9.1 |
| backups con restauración probada | T9.3 |
| seguimiento de errores sin feedback | T9.4 |
| seeds solo para desarrollo | E1 |

**Exponer el sistema**, aun sin datos reales, requiere E4.
**Cargar datos reales** requiere además I7 (desactivación y último
administrador), I8 (revocación administrativa, necesaria cuando un autor
desactivado deja comparticiones sin revocador) e I9 (correo real y
restauración probada).

## G.7. Complejidad, riesgos y dependencias

| Incremento | Complejidad | Incertidumbre | Riesgo principal |
|---|---|---|---|
| E1 a E4 | media | media | elección de autenticación y de políticas (ADR-2, ADR-3) |
| I1 | media | media | invitaciones con token y correo capturado |
| I2 | baja-media | baja, si la lista de dimensiones está decidida | — |
| I3 | media | baja | que una consulta se salga del alcance (RN-1) |
| I4 | media-alta | media | vínculo entre compartición y asignación; reasignación |
| I5 | media | media | definición de los datos mínimos |
| I6 | media | media | filtros sin recargar respetando el alcance |
| I7 | alta | **alta** | invalidar sesiones con la biblioteca elegida; prueba de concurrencia |
| I8 | baja-media | baja | que la vista administrativa muestre contenido (RN-11) |
| I9 | media | **alta** | hosting y correo todavía sin elegir |

**Camino crítico:** ADR-1 a ADR-3 → E1 a E3 → I1 → I2 → I3 → I4 → I5 → I6.
Algunas tareas de I7 e I8 pueden adelantarse: T7.1 a T7.3 no dependen de I5
ni de I6, y la revocación administrativa puede empezar después de T4.4.
Pero completar I7 requiere I6 (T7.4 depende de T6.1), y completar I8 también,
porque PT-1 incluye el feed. I9 necesita E4 y cierra el camino hacia los
datos reales.

No se publican estimaciones de esfuerzo: dependen de la dedicación
disponible, que no está definida. El plan prioriza dependencias y riesgos,
y no promete fechas.

---

[Volver al README](../README.md)
