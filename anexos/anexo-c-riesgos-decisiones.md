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
| RN-7 | **Decisiones de privacidad sin resolver.** | **Mitigación definida; pendiente de implementación y pruebas:** D1, D2, D5 y AM-1 a AM-5 decididas (27/10/2026). Quedan D3 y D4, que no bloquean el MVP. |
| RN-8 | **Evidencia privada inaccesible** cuando se desactiva a su autor: nadie puede leerla, tampoco el administrador (D5). | Consecuencia aceptada; explicarla a los líderes desde el inicio. |
| RN-9 | **Comparticiones sin revocador** cuando el autor está desactivado. | **Mitigación definida por AM-3; pendiente de implementación y pruebas:** el administrador puede revocar una compartición concreta sin leerla (PT-10). |
| RN-10 | **Sesiones vigentes después de desactivar una cuenta.** | Invalidar las sesiones al desactivar y comprobar la cuenta en cada petición (PT-5). |
| RN-11 | **La vista administrativa de comparticiones deja ver contenido.** | Mostrar solo metadatos mínimos y probarlo (PT-10). |
| RN-12 | **Invitaciones reutilizadas o interceptadas.** | Enlace de un solo uso y con vencimiento, guardar solo el resumen del token y no enviar contraseñas (PT-7, PT-8). |

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

## C.3. Reglas que cierran las ambigüedades

Decididas por Pablo (27/10/2026).

- **AM-1. Fin de la asignación del autor.** Mientras su cuenta esté activa,
  el autor conserva la lectura de sus propias entradas, incluidos los
  borradores. No puede editarlas, marcarlas como listas ni compartirlas hasta
  volver a estar asignado, pero puede revocar sus comparticiones existentes.
  La autoría no le permite abrir la ficha completa ni entradas ajenas: se
  muestran solo los datos mínimos para identificar sus entradas. Volver a
  estar asignado no reactiva comparticiones que perdió como destinatario.
- **AM-2. Desactivación.** La realiza el administrador. Impide nuevos inicios
  de sesión, invalida las sesiones abiertas y no borra entradas ni cambia su
  autoría.
- **AM-3. Revocación administrativa.** El administrador puede revocar una
  compartición concreta sin leer la entrada, viendo solo los metadatos
  mínimos para identificarla. No puede crear comparticiones, editar entradas
  ni acceder al feedback. Se registra quién revocó, cuándo y por qué. No hace
  falta terminar una asignación para revocar un permiso puntual.
- **AM-4. Último administrador.** No se puede desactivar ni quitar el rol al
  último administrador activo, tampoco ante operaciones concurrentes.
- **AM-5. Acceso inicial.** El administrador invita con un enlace de un solo
  uso y con vencimiento para que la cuenta establezca su contraseña. No hay
  contraseñas fijas ni se envían en texto plano. El correo transaccional es
  requisito del MVP. El alta del primer administrador sigue un procedimiento
  documentado, sin secretos en el repositorio. Biblioteca y proveedor, por
  elegir.
- **Visibilidad de otros líderes.** Un líder con asignación activa ve los
  nombres de los demás líderes activos asignados a esa persona, para elegir
  destinatarios. Eso no le permite ver sus entradas privadas ni sus datos de
  contacto.
- **Criterios aceptados:** 3.9 (los borradores no se comparten), 4.11
  (acompañar no permite leer entradas privadas ajenas) y 4.12 (dos líderes
  pueden ver resúmenes distintos).

**Detalles de implementación propuestos, no decididos:**

| Tema | Propuesta mínima |
|---|---|
| Datos mínimos que ve un autor sin asignación (AM-1) | nombre de la persona, fecha del hecho, estado y su propio texto; sin otros datos de la ficha |
| Metadatos que ve el administrador al revocar (AM-3) | autor, destinatario, persona y fecha de la compartición; nunca contexto, evidencia, impacto, señal ni dimensión |
| Motivo cuando revoca el autor | opcional. Cuando revoca el administrador el motivo es obligatorio, porque AM-3 exige registrar por qué. En ambos casos es un campo de la compartición, no un sistema general de auditoría |
| Último administrador ante concurrencia (AM-4) | comprobar y aplicar el cambio dentro de una transacción que bloquee las cuentas administradoras activas |

## C.4. Otras decisiones

- Criterios 3.9, 4.11 y 4.12: **aceptados** (27/10/2026).
- Pendiente: definir la lista de dimensiones.
- Pendiente: D3 (escalar) y D4 (acceso de la persona acompañada).

---

[Volver al README](../README.md)
