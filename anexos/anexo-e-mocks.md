# Anexo E. Notas de los mocks

> Anexo de la primera entrega de Growth Log. Relaciona cada mock de la
> [sección 1.3 del README](../README.md#13-diseño-y-experiencia-de-usuario)
> con los criterios de aceptación y las decisiones pendientes.

**Qué son.** Diseño propuesto para el MVP; los permisos y la compartición
aquí mostrados son propuestas. Las imágenes **no son capturas** de un sistema
existente: la aplicación todavía no está construida.

**Datos.** Todos los nombres, equipos y feedback son inventados (Elena
Boceto, Franco Ensayo, Ada Ejemplo, Bruno Muestra, Carla Prueba, Equipo Faro
y Equipo Brújula). Las dimensiones son de ejemplo; la lista definitiva está
por confirmar.

**Textos de la interfaz.** Cada imagen lleva la marca «Mock — propuesta del MVP · Datos ficticios».
Las pantallas usan mensajes para el usuario
(«Solo vos podés ver este borrador»). Las referencias a la política (PP-1 a
PP-7) y a las decisiones (D1 a D5) están en este anexo, no en la interfaz.

## Mock 1. Ficha de una persona

![Mock 1: ficha de una persona](mocks/mock-1-ficha-persona.png)

| Qué muestra | Criterios y reglas | Decisiones pendientes |
|---|---|---|
| Solo aparecen personas que el líder acompaña; una persona puede tener varios líderes | 1.2, 1.9–1.11; PP-2 | Quién asigna líderes y si hay administradores: **D1**. La lista de líderes de la ficha muestra una alternativa. |
| Resumen por dimensión con entradas listas visibles, distinguiendo las propias de las compartidas | 4.1–4.3; PP-6 | — |
| Las entradas privadas de otro líder sobre la misma persona no se muestran ni se cuentan; dos líderes pueden ver resúmenes distintos | 4.11, 4.12 | — |
| Vista cronológica por fecha del hecho, solo con entradas visibles | 4.13 | — |
| Filtros por estado, señal y dimensión, con «Limpiar» | 4.6, 4.7 | — |
| Un borrador propio aparece en la línea de tiempo, pero no en el resumen | 3.3; PP-3 | — |
| El resumen aclara que no es un puntaje; la calibración es un uso posible y la aplicación no calcula la evaluación | 4.5 | — |

## Mock 2. Captura rápida de feedback

![Mock 2: captura rápida](mocks/mock-2-captura-rapida.png)

| Qué muestra | Criterios y reglas | Decisiones pendientes |
|---|---|---|
| Acceso visible desde la ficha con el botón «Captura rápida» | 3.1; MVP-FE-1 | — |
| Solo pide el texto; la fecha viene con el día de hoy | 3.2 | — |
| Se guarda como borrador privado del autor y no cuenta en el resumen | 3.3; PP-3 | — |
| Después se completa y se marca como lista; si falta la dimensión, se indica qué falta | 3.4, 3.5 | — |
| Registrar en unos 30 segundos es un objetivo, no un resultado medido | HV-1 | Se propone cronometrarlo en una prueba de uso |

## Mock 3. Entrada lista con la acción de compartir

![Mock 3: entrada lista y compartir](mocks/mock-3-compartir-entrada.png)

| Qué muestra | Criterios y reglas | Decisiones pendientes |
|---|---|---|
| La entrada está lista y **sin compartir**: «lista» no es «compartida» | 2.9, 3.6; PP-4 | — |
| Franco Ensayo está **seleccionado** (casilla con tilde), pero la acción no se confirmó: la entrada sigue sin destinatarios hasta pulsar «Compartir» y «Compartida con» dice «nadie todavía» | 5.6 | — |
| Destinatarios: líderes que acompañan a la persona | 5.6 | **Alternativa propuesta**, pendiente de **D2**: quiénes pueden recibirla |
| Compartir da permiso de lectura; solo la autora edita | 4.10; PP-5 | — |
| «Dejar de compartir» aparece deshabilitado porque no hay comparticiones | 5.7 | Cómo se revoca: **D2**. Si hace falta algo más que compartir, como escalar: **D3** |
| Un borrador no muestra la sección «Compartir» | 3.9 | — |
| Qué pasa con la entrada si la autora deja el equipo | PP-7 | **D5** |

Registrar cada compartición por destinatario es una alternativa sujeta a D2
(ADR-4).

## Mock 4. Feed con filtros

![Mock 4: feed con filtros](mocks/mock-4-feed.png)

| Qué muestra | Criterios y reglas | Decisiones pendientes |
|---|---|---|
| Más recientes primero; por defecto, solo listas | 5.1 | — |
| Filtros por estado, señal y dimensión, con «Limpiar» | 5.2 | — |
| Filtros por **origen** y **persona** | — | **Propuesta por confirmar**: no forman parte de los criterios; si se aceptan, se suman a 5.2 |
| Solo entradas propias y listas compartidas con el líder; los borradores ajenos nunca aparecen | 5.4, 5.5; PP-3, PP-6 | — |
| Etiquetas de origen con leyenda: «Tuya · privada» (solo la ve su autora), «Tuya · compartida» (la autora la compartió) y «Compartida con vos» (solo lectura) | 4.3, 4.10 | — |
| Cada fila lleva a la persona o al detalle | 5.3 | — |
| Paginación | 5.8 | — |

---

[Volver al README](../README.md)
