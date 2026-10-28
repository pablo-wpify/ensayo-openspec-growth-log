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
| RN-7 | **Decisiones de privacidad sin resolver.** | **Mitigado:** D1, D2 y D5 decididas (27/10/2026); quedan AM-1 a AM-5, D3 y D4, que no bloquean el modelo base. |
| RN-8 | **Evidencia privada inaccesible** cuando se desactiva a su autor: nadie puede leerla, tampoco el administrador (D5). | Consecuencia aceptada; explicarla a los líderes desde el inicio. |
| RN-9 | **Comparticiones sin revocador** cuando el autor está desactivado (AM-3). | Resolver AM-3; mientras tanto, el acceso termina con la asignación del destinatario. |
| RN-10 | **Sesiones vigentes después de desactivar una cuenta.** | Invalidar las sesiones al desactivar y comprobar la cuenta en cada petición (PT-5). |

## C.2. Decisiones de privacidad

| # | Decisión | Estado |
|---|---|---|
| D1 | **Asignación y administración.** | **Decidida por Pablo** (27/10/2026) |
| D2 | **Destinatarios y revocación.** | **Decidida por Pablo** (27/10/2026) |
| D3 | **Escalar:** si hace falta algo más que compartir, por ejemplo escalar un caso. | abierta; no bloquea el MVP |
| D4 | **Acceso de la persona acompañada** a su propio feedback. | abierta; fuera del MVP |
| D5 | **Salida de un autor.** | **Decidida por Pablo** (27/10/2026) |

**Lo que decidió Pablo:**

- **D1. Administración.** Un administrador crea cuentas, crea y edita
  personas, asigna líderes y termina sus asignaciones. Los líderes consultan
  las personas asignadas y registran feedback; no crean personas ni modifican
  sus datos o asignaciones. Una persona puede tener varios líderes. Ser
  administrador no permite leer todo el feedback: para consultar entradas se
  aplican las mismas reglas de autoría y compartición. Una misma cuenta puede
  administrar y acompañar personas. La cuenta administradora inicial se
  provisiona con un procedimiento documentado, sin credenciales fijas en el
  repositorio.
- **D2. Compartición.** Solo el autor comparte una entrada propia y lista,
  individualmente, con cuentas activas de líderes que acompañan actualmente a
  esa persona. El destinatario lee, pero no edita ni vuelve a compartir.
  Revocar registra `revoked_at` y quita el permiso en las siguientes
  consultas; no retira lo que alguien ya leyó. Terminar la asignación del
  destinatario también quita el acceso, y una nueva asignación no reactiva
  comparticiones anteriores: el autor debe compartir otra vez. Todo se
  comprueba en el servidor, incluidas las peticiones directas por URL.
- **D5. Salida de un autor.** La cuenta se desactiva y no se borra: se
  impiden nuevos inicios de sesión y se invalidan las sesiones abiertas. Se
  conservan las entradas y su autoría. Las compartidas siguen disponibles
  para destinatarios activos con asignación y permiso; las privadas quedan
  sin acceso ordinario, tampoco para el administrador. No hay transferencia
  de autoría ni recuperación administrativa de entradas privadas en el MVP.

## C.3. Ambigüedades abiertas

Surgen al aplicar las decisiones. Las resoluciones son **propuestas, no
aceptadas**.

| # | Ambigüedad | Resolución propuesta | Afecta |
|---|---|---|---|
| AM-1 | ¿Qué puede hacer el autor con sus entradas sobre una persona cuando termina **su propia** asignación? | Conserva la lectura de sus entradas por autoría, pero no crea entradas nuevas ni comparte sobre esa persona hasta tener una asignación activa. | PP-2, PP-5; H2, H4, H5 |
| AM-2 | ¿Quién desactiva una cuenta? D5 define el efecto, no el responsable. | El administrador, coherente con D1. | 1.9; PT-5 |
| AM-3 | Si el autor está desactivado, nadie puede revocar sus comparticiones vigentes. | Siguen vigentes hasta que termine la asignación del destinatario; el administrador puede cortar el acceso terminando esa asignación, sin leer la entrada. | D2, D5; PT-6 |
| AM-4 | ¿Se puede desactivar o quitar el rol a la última cuenta administradora? | Impedirlo, para que la instancia no quede sin administración. | PP-8; MVP-BE-2 |
| AM-5 | ¿Cómo recibe su acceso inicial una cuenta creada por el administrador? | Definirlo con la autenticación (ADR-2), sin contraseñas fijas ni enviadas en texto plano. | 1.1; MVP-BE-2 |

## C.4. Otras decisiones de Pablo

- Confirmar los criterios 3.9, 4.11 y 4.12, que se desprenden de la política.
- Resolver AM-1 a AM-5.
- Definir la lista de dimensiones.

---

[Volver al README](../README.md)
