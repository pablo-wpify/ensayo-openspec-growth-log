# Anexo A. Historias de usuario en detalle

> Anexo de la primera entrega de Growth Log. Los 59 criterios de aceptación
> del MVP, todos **propuestos**; los que aplican D1, D2 y D5 siguen
> decisiones de Pablo. El resumen está en la
> [sección 5 del README](../README.md#5-historias-de-usuario).

## Política de privacidad y criterios que la aplican

**Incorpora las decisiones D1, D2 y D5 de Pablo; nada está implementado.**

| # | Regla | Criterios |
|---|---|---|
| PP-1 | Cada líder tiene su propia cuenta. Las cuentas las crea un administrador (D1). | 1.1 |
| PP-2 | Un líder accede a la ficha de una persona solo mientras tiene una asignación activa con ella. Una persona puede tener varios líderes (D1). | 1.6, 1.7, 1.10, 1.13, 1.14, 2.10, 4.11 |
| PP-3 | Los borradores solo los ve, edita y marca como listos su autor. | 3.2, 3.8, 5.5 |
| PP-4 | Una entrada lista sigue siendo privada del autor hasta que este decida compartirla. | 2.9, 3.6, 3.9, 4.9, 4.11 |
| PP-5 | Solo el autor comparte una entrada propia y lista, de a un destinatario: un líder con cuenta activa que acompaña actualmente a la persona. El destinatario la lee mientras su cuenta siga activa, mantenga la asignación y la compartición no esté revocada; no la edita ni la vuelve a compartir (D2). | 1.7, 4.3, 4.10, 5.6, 5.7, 5.9, 5.10 |
| PP-6 | El feed y el resumen de una persona muestran únicamente las entradas que el líder tiene permiso para ver. | 1.11, 4.2, 4.6, 4.12, 5.4 |
| PP-7 | Si un autor deja el equipo, su cuenta se desactiva y no se borra: no puede iniciar sesión y sus sesiones abiertas se invalidan. Sus entradas y su autoría se conservan; las compartidas siguen disponibles para destinatarios con permiso vigente y las privadas quedan sin acceso ordinario, también para el administrador (D5). | 1.9, 5.11 |
| PP-8 | Un administrador crea cuentas, crea y edita personas, y asigna y termina asignaciones. Administrar no da permiso para leer entradas. Una misma cuenta puede administrar y acompañar personas (D1). | 1.1–1.5, 1.8, 1.15, 1.16 |

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
política (PP), la decisión (D) o la ambigüedad abierta (AM) de la que
dependen.

### H1. Administrar personas y asignaciones, y consultar las personas que acompaño

**Objetivo.** Como administrador, quiero crear cuentas y personas y asignar
líderes, para que cada líder acompañe a quienes le corresponden. Como líder,
quiero ver las personas que tengo asignadas, para registrar feedback sobre
cada una.

**Recorrido del administrador.** Crea la cuenta de un líder, crea una
persona, la asigna a uno o más líderes y, cuando corresponde, termina una
asignación, da de baja a la persona o desactiva una cuenta.

**Recorrido del líder.** Entra en «Personas», ve las personas activas que
tiene asignadas y abre su ficha.

**Cuenta administradora inicial:** se crea con un procedimiento documentado,
sin credenciales fijas en el repositorio (D1).

**Acciones del administrador:**

| # | Criterio de aceptación (propuesto) |
|---|---|
| 1.1 | **Dado** que soy administrador, **cuando** creo una cuenta, **entonces** queda activa y su titular puede iniciar sesión. *(PP-1, PP-8; AM-5)* |
| 1.2 | **Cuando** creo una persona sin nombre, **entonces** no se guarda y veo el error. *(PP-8)* |
| 1.3 | **Cuando** creo o edito una persona, **entonces** se guardan su nombre, su rol y su equipo. *(PP-8, D1)* |
| 1.4 | **Cuando** doy de baja a una persona, **entonces** deja de aparecer en los listados y conserva su historial. *(PP-8)* |
| 1.5 | **Dado** que hay personas inactivas, **cuando** las busco, **entonces** puedo verlas y reactivarlas. *(PP-8)* |
| 1.6 | **Cuando** asigno un líder activo a una persona, **entonces** ese líder accede a su ficha; una persona puede tener varios líderes. *(PP-2, D1)* |
| 1.7 | **Cuando** termino una asignación, **entonces** el líder deja de acceder a la ficha y a las entradas compartidas con él sobre esa persona, también por URL directa. *(PP-2, PP-5, D2)* |
| 1.8 | **Dado** que soy administrador, **entonces** serlo no me permite leer entradas: solo veo las que escribí o me compartieron como líder asignado. *(PP-8, D1)* |
| 1.9 | **Cuando** se desactiva una cuenta, **entonces** no puede iniciar sesión y sus sesiones abiertas dejan de valer. *(PP-7, D5; AM-2)* |

**Acciones del líder:**

| # | Criterio de aceptación (propuesto) |
|---|---|
| 1.10 | **Dado** que inicié sesión, **cuando** entro en Personas, **entonces** veo solo las personas activas que tengo asignadas, ordenadas por nombre, con su rol y su equipo. *(PP-2)* |
| 1.11 | **Entonces** el conteo de entradas de cada persona incluye solo las que puedo ver. *(PP-6)* |
| 1.12 | **Dado** que no tengo personas asignadas, **cuando** entro en Personas, **entonces** veo un mensaje que lo explica. |
| 1.13 | **Cuando** abro una persona que tengo asignada, **entonces** veo su ficha. *(PP-2)* |
| 1.14 | **Cuando** intento abrir una persona sin asignación activa, incluso por URL directa, **entonces** no accedo. *(PP-2)* |
| 1.15 | **Cuando** intento crear una persona, editar sus datos o cambiar una asignación sin ser administrador, **entonces** no puedo. *(PP-8, D1)* |
| 1.16 | **Dado** que mi cuenta administra y además tengo personas asignadas, **entonces** como líder veo solo esas personas y sus entradas visibles, y como administrador gestiono personas y asignaciones sin leer entradas ajenas. *(PP-8, D1)* |

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
| 2.10 | **Cuando** registro feedback sobre una persona, **entonces** tiene que ser una con la que tengo una asignación activa. *(PP-2)* |

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
conmigo, filtro, paso a la persona o al detalle, comparto una entrada lista
con otro líder de esa persona y, si hace falta, revoco la compartición.

**Qué entradas entran en el feed (política propuesta, PP-6):** mis entradas
(borradores y listas) y las listas que otros compartieron conmigo.

| # | Criterio de aceptación (propuesto) |
|---|---|
| 5.1 | **Cuando** entro en «Feedback», **entonces** veo las entradas, primero las más recientes, solo las listas por defecto. |
| 5.2 | **Cuando** filtro por estado, señal o dimensión, **entonces** la lista se actualiza, y puedo limpiar los filtros. |
| 5.3 | **Cuando** elijo una entrada, **entonces** puedo ir a la persona o al detalle. |
| 5.4 | **Entonces** el feed muestra solo mis entradas y las listas compartidas conmigo. *(PP-6)* |
| 5.5 | **Entonces** los borradores que veo son solo los míos. *(PP-3)* |
| 5.6 | **Cuando** comparto una entrada lista mía, **entonces** lo hago de a un destinatario, solo con cuentas activas de líderes que acompañan actualmente a esa persona, y el destinatario puede leerla. *(PP-4, PP-5, D2)* |
| 5.7 | **Cuando** revoco una compartición, **entonces** queda registrada la revocación y el destinatario deja de verla en sus siguientes consultas; lo que ya leyó no se puede retirar. *(D2)* |
| 5.8 | **Dado** que hay muchas entradas, **entonces** el listado se pagina. |
| 5.9 | **Dado** que recibí una entrada compartida, **cuando** intento editarla o volver a compartirla, incluso por URL directa, **entonces** no puedo. *(PP-5, D2)* |
| 5.10 | **Dado** que terminó mi asignación con una persona, **entonces** dejo de ver las entradas que me compartieron sobre ella; si me vuelven a asignar, no las recupero hasta que el autor las comparta de nuevo. *(D2)* |
| 5.11 | **Dado** que el autor de una entrada compartida conmigo fue desactivado, **entonces** la sigo viendo, con su autoría, mientras mantenga la asignación y el permiso. *(PP-7, D5; AM-3)* |

**Nota.** D2 está decidida. D3 (escalar) sigue abierta y no cambia estos
criterios.



---

[Volver al README](../README.md)
