# Anexo A. Historias de usuario en detalle

> Anexo de la primera entrega de Growth Log. Los 52 criterios de aceptación
> del MVP, todos **propuestos**. El resumen está en la
> [sección 5 del README](../README.md#5-historias-de-usuario).

## Política de privacidad propuesta y criterios que la aplican

**Propuesta para el MVP; todavía no está implementada.**

| # | Regla propuesta | Criterios |
|---|---|---|
| PP-1 | Cada líder tiene su propia cuenta. | todas |
| PP-2 | Un líder accede a la ficha de una persona si está autorizado a acompañarla. Una persona puede tener más de un líder. | 1.2, 1.9–1.11, 2.10, 4.11 |
| PP-3 | Los borradores solo los ve, edita y marca como listos su autor. | 3.8, 5.5 |
| PP-4 | Una entrada lista sigue siendo privada del autor hasta que este decida compartirla. | 2.9, 3.6, 3.9, 4.9, 4.11 |
| PP-5 | Una entrada compartida la pueden leer los líderes autorizados a recibirla; solo su autor la edita. | 4.3, 4.10, 5.6 |
| PP-6 | El feed y el resumen de una persona muestran únicamente las entradas que el líder tiene permiso para ver. | 1.3, 4.2, 4.6, 4.12, 5.4 |
| PP-7 | Si un líder deja el equipo o pierde su cuenta, sus entradas no se borran automáticamente. Cómo se conserva o transfiere el acceso queda pendiente de diseño (D5). | — |

**Criterios propuestos que se desprenden de la política** (incorporados a
las historias):

- Los borradores no se comparten (3.9).
- Acompañar a una persona no da acceso automático a las entradas privadas de
  otro líder (4.11).
- Dos líderes pueden ver resúmenes distintos de la misma persona según sus
  permisos (4.12).

El estado «lista» no tiene efecto sobre la visibilidad: solo indica que la
entrada está completa (de PP-4).

## Historias

Todos los criterios son **propuestos**. Entre paréntesis, la regla de la
política (PP) o la decisión abierta (D) de la que dependen.

### H1. Mantener la lista de personas que acompaño

**Objetivo.** Como líder, quiero tener al día la lista de personas que
acompaño, para registrar feedback sobre cada una.

**Recorrido.** Entro en «Personas», veo las activas que estoy autorizado a
acompañar, abro su ficha, creo o edito una persona y la marco como inactiva
cuando deja el equipo.

| # | Criterio de aceptación (propuesto) |
|---|---|
| 1.1 | **Dado** que inicié sesión, **cuando** entro en Personas, **entonces** veo las personas activas ordenadas por nombre, con su rol y su equipo. |
| 1.2 | **Entonces** solo veo las personas que estoy autorizado a acompañar. *(PP-2)* |
| 1.3 | **Entonces** el conteo de entradas de cada persona incluye solo las que puedo ver. *(PP-6)* |
| 1.4 | **Dado** que no hay personas, **cuando** entro en Personas, **entonces** veo un mensaje y un enlace para crear la primera. |
| 1.5 | **Cuando** creo una persona sin nombre, **entonces** no se guarda y veo el error. |
| 1.6 | **Cuando** edito el nombre, el rol o el equipo, **entonces** se guardan los cambios. *(D1)* |
| 1.7 | **Cuando** desmarco «Activo», **entonces** la persona deja de aparecer en el listado y conserva su historial. |
| 1.8 | **Dado** que hay personas inactivas, **cuando** las busco, **entonces** puedo verlas y reactivarlas. |
| 1.9 | **Cuando** abro una persona que estoy autorizado a acompañar, **entonces** veo su ficha. |
| 1.10 | **Cuando** intento abrir o editar una persona que no estoy autorizado a acompañar, **entonces** no accedo. *(PP-2)* |
| 1.11 | **Dado** que una persona tiene más de un líder, **entonces** cada uno accede a su ficha. *(PP-2)* |
| 1.12 | **Cuando** se crea una persona, **entonces** queda asignada a uno o más líderes según la regla que se decida. *(D1)* |

- **Fuera de la historia:** borrar una persona (backlog).

### H2. Registrar feedback estructurado

**Objetivo.** Como líder, quiero registrar una observación fechada y
clasificada sobre una persona que acompaño, para acumular evidencia concreta.

**Recorrido.** En la ficha de la persona toco «+ Feedback», completo el
formulario en la misma página, decido si queda como borrador o lista, y
guardo. Con la política propuesta (PP-4), la entrada queda privada hasta que
decida compartirla; compartir es
parte de H5 (criterio 5.6).

| # | Criterio de aceptación (propuesto) |
|---|---|
| 2.1 | **Cuando** toco «+ Feedback» en la ficha de una persona, **entonces** el formulario se abre en la misma página. |
| 2.2 | **Cuando** se abre el formulario, **entonces** la fecha viene con el día de hoy. |
| 2.3 | **Cuando** guardo sin contexto o sin fecha, **entonces** no se guarda y veo el error. |
| 2.4 | **Cuando** completo el formulario, **entonces** elijo una señal (positivo, mejora o neutral) y una dimensión de una lista fija. |
| 2.5 | **Cuando** completo el formulario, **entonces** puedo agregar evidencia, impacto y una confianza de 1 a 5, todos opcionales. |
| 2.6 | **Cuando** marco la entrada como lista sin dimensión, **entonces** no se guarda y veo el error. |
| 2.7 | **Cuando** creo una entrada, **entonces** puedo guardarla como borrador o como lista. |
| 2.8 | **Cuando** guardo, **entonces** quedo registrado como autor, y se ve en el detalle. |
| 2.9 | **Cuando** guardo una entrada, borrador o lista, **entonces** queda **privada**: solo yo la veo. *(PP-3, PP-4)* |
| 2.10 | **Cuando** registro feedback sobre una persona, **entonces** tiene que ser una que estoy autorizado a acompañar. *(PP-2)* |

- **Fuera de la historia (backlog):** etiquetas editables, enlaces de evidencia
  y autor externo.
- **Lista de dimensiones:** **[Por confirmar]**. Los mocks usan dimensiones de
  ejemplo.

### H3. Capturar rápido y completar después

**Objetivo.** Como líder, quiero anotar algo en el momento con lo mínimo y
completarlo más tarde, para no perder la observación.

**Recorrido.** Desde la ficha de la persona abro la captura rápida, escribo y
se guarda como borrador privado; más tarde lo edito, lo completo y lo marco
como lista. Sigue siendo privado hasta que lo comparta (PP-3, PP-4).

| # | Criterio de aceptación (propuesto) |
|---|---|
| 3.1 | **Cuando** estoy en la ficha de una persona, **entonces** tengo un acceso visible a «Captura rápida». |
| 3.2 | **Cuando** guardo una captura rápida, **entonces** se guarda como borrador privado de mi autoría, con la fecha de hoy, pidiendo solo el texto. *(PP-3)* |
| 3.3 | **Dado** un borrador, **entonces** no cuenta en el resumen de la persona ni en su conteo de entradas. |
| 3.4 | **Cuando** edito mi borrador, **entonces** puedo completar la señal, la dimensión y lo demás. |
| 3.5 | **Cuando** marco como lista un borrador incompleto, **entonces** veo qué falta y el borrador sigue como estaba. |
| 3.6 | **Cuando** marco como lista un borrador completo, **entonces** pasa a lista **y sigue privada**. *(PP-4)* |
| 3.7 | **Cuando** edito una entrada lista sin tocar su estado, **entonces** sigue lista. |
| 3.8 | **Dado** un borrador, **entonces** solo su autor lo ve, lo edita y lo marca como lista. *(PP-3)* |
| 3.9 | **Dado** un borrador, **entonces** no se puede compartir. *(PP-3, PP-4)* |

**Fuera de la historia (backlog):** volver a borrador a propósito y borrar
una entrada.

### H4. Preparar una evaluación o un 1:1 (resumen individual)

**Objetivo.** Como líder, quiero ver la evidencia que puedo ver sobre una
persona, organizada por dimensión y en el tiempo, para preparar una
evaluación o un 1:1.

**Recorrido.** Abro la ficha de una persona que acompaño, leo el resumen por
dimensión, recorro las entradas en orden cronológico, las filtro y abro el
detalle de las que necesito.

**Calibración.** Es un uso posible de esta evidencia. La aplicación no
calcula el puntaje de la evaluación (4.5).

**Qué entradas entran en el resumen (política propuesta, PP-6):** las listas
que escribí yo y las listas que otros líderes compartieron conmigo. Nunca los
borradores, tampoco los propios.

| # | Criterio de aceptación (propuesto) |
|---|---|
| 4.1 | **Cuando** abro una persona, **entonces** veo un resumen por dimensión de las entradas listas, con positivos, mejoras y total. |
| 4.2 | **Entonces** el resumen incluye solo las entradas listas que tengo permiso para ver: las mías y las compartidas conmigo. *(PP-6)* |
| 4.3 | **Entonces** distingo cuáles entradas son mías y cuáles me compartieron. *(PP-5, PP-6)* |
| 4.4 | **Dado** que no hay nada que pueda ver, **entonces** veo un mensaje en lugar del resumen. |
| 4.5 | **Entonces** el resumen aclara que no es un puntaje. |
| 4.6 | **Cuando** filtro por estado, señal o dimensión, **entonces** la lista se actualiza sin recargar la página, solo con entradas que puedo ver. *(PP-6)* |
| 4.7 | **Cuando** quiero quitar los filtros, **entonces** puedo limpiarlos. |
| 4.8 | **Cuando** abro una entrada que puedo ver, **entonces** veo autor, fecha y todos sus campos. |
| 4.9 | **Cuando** intento abrir una entrada que no puedo ver, **entonces** no accedo. *(PP-4, PP-5)* |
| 4.10 | **Cuando** veo una entrada compartida conmigo, **entonces** puedo leerla, pero no editarla. *(PP-5)* |
| 4.11 | **Dado** que acompaño a una persona, **entonces** eso no me da acceso a las entradas privadas que otro líder escribió sobre ella. *(PP-2, PP-4)* |
| 4.12 | **Dado** que dos líderes acompañan a la misma persona, **entonces** cada uno puede ver un resumen distinto, según las entradas que tiene permiso para ver. *(PP-6)* |
| 4.13 | **Cuando** reviso la evidencia de una persona, **entonces** puedo recorrerla en orden cronológico, según la fecha en que ocurrió cada hecho, solo con las entradas que puedo ver. |

- **Sobre 4.12:** la interfaz debería dejar claro qué entradas son propias y
  cuáles compartidas (4.3), para que la diferencia no parezca un error.
- **Fuera de la historia (backlog):** confianza promedio por dimensión.

### H5. Explorar y compartir feedback (feed)

**Objetivo.** Como líder, quiero recorrer y filtrar el feedback que puedo ver,
y compartir el mío cuando lo decida, para detectar patrones y coordinarme con
otros líderes.

**Recorrido.** Entro en «Feedback», veo mis entradas y las compartidas
conmigo, filtro, paso a la persona o al detalle, y comparto una entrada lista.

**Qué entradas entran en el feed (política propuesta, PP-6):** mis entradas
(borradores y listas) y las listas que otros compartieron conmigo.

| # | Criterio de aceptación (propuesto) |
|---|---|
| 5.1 | **Cuando** entro en «Feedback», **entonces** veo las entradas, primero las más recientes, solo las listas por defecto. |
| 5.2 | **Cuando** filtro por estado, señal o dimensión, **entonces** la lista se actualiza, y puedo limpiar los filtros. |
| 5.3 | **Cuando** elijo una entrada, **entonces** puedo ir a la persona o al detalle. |
| 5.4 | **Entonces** el feed muestra solo mis entradas y las listas compartidas conmigo. *(PP-6)* |
| 5.5 | **Entonces** los borradores que veo son solo los míos. *(PP-3)* |
| 5.6 | **Cuando** decido compartir una entrada lista mía, **entonces** la ven los líderes autorizados a recibirla. *(PP-4, PP-5, D2, D3)* |
| 5.7 | **Cuando** dejo de compartir una entrada, **entonces** deja de verla quien la recibió. *(D2)* |
| 5.8 | **Dado** que hay muchas entradas, **entonces** el listado se pagina. |

**Nota.** 5.6 y 5.7 no se pueden especificar del todo hasta resolver D2 y D3.
Hasta entonces, 5.4 y 5.5 sí se pueden especificar: no dependen de cómo se
comparte, sino de que todo es privado salvo lo compartido.



---

[Volver al README](../README.md)
