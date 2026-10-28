# Anexo D. Decisiones de arquitectura

> Anexo de la primera entrega de Growth Log. Borradores de registros de
> decisión (ADR) para el MVP. **Ninguna decisión abierta está tomada**;
> las marcadas como «propuesta» son la opción que recomendamos evaluar
> primero. El resumen está en la
> [sección 9 del README](../README.md#9-decisiones-abiertas-y-riesgos).

Cada ADR tiene contexto, opciones, criterio para decidir y estado. Cuando se
decida, se completa con la decisión, la fecha y sus consecuencias.

## ADR-1. Monolito Rails con HTML renderizado en el servidor

- **Contexto:** una persona construye, pocos usuarios, y una regla central de
  visibilidad que tiene que aplicarse igual en todas las vistas.
- **Opciones:** monolito con vistas del servidor; monolito con API JSON y un
  frontend separado; otro framework web con las mismas características.
- **Criterio:** en todas las opciones la autorización se aplica en el
  servidor; el monolito evita mantener un contrato de API y coordinar dos
  aplicaciones. También pesan la simplicidad de prueba y despliegue y la
  experiencia previa de Pablo. Una instancia es la propuesta inicial; el
  monolito puede ejecutarse en varias.
- **Estado:** propuesta.

## ADR-2. Autenticación

- **Contexto:** PP-1 exige cuentas individuales. El MVP necesita inicio de
  sesión, invitaciones con enlace de un solo uso y con vencimiento (AM-5),
  invalidación de sesiones al desactivar (AM-2) y límite de intentos. No hay
  registro público. La recuperación de contraseña es una mejora pendiente,
  fuera del alcance comprometido: sus requisitos solo aplican si se incluye.
- **Opciones:** Devise; el generador de autenticación de Rails más funciones
  propias; un proveedor externo (OAuth).
- **Criterio:** cubrir esas funciones sin código propio sensible; alta de
  cuentas por invitación de un administrador y procedimiento para la cuenta
  administradora inicial sin secretos en el repositorio (D1, AM-5); sin
  contraseñas fijas ni enviadas en texto plano.
- **Estado:** abierta.

## ADR-3. Implementación de las políticas y respuesta ante acceso no autorizado

- **Contexto:** PP-2 a PP-9 se aplican en el servidor y tienen que poder
  testearse por acción.
- **Opciones de implementación:** una biblioteca de políticas, como Pundit o
  Action Policy; objetos de política propios.
- **Opciones de respuesta:** 404, que no revela si la entrada existe, o 403,
  más explícito.
- **Criterio:** que una acción sin política falle en los tests; que el
  alcance de las consultas y la política compartan la misma regla.
- **Estado:** abierta. Recomendamos evaluar primero 404.

## ADR-4. Cómo se registra una compartición

- **Contexto:** compartir otorga permiso de lectura a líderes concretos y
  debe poder revocarse (D2).
- **Opciones:** una fila por entrada y destinatario, con fecha de revocación;
  compartir con «todos los líderes de la persona» como un indicador en la
  entrada; grupos de destinatarios.
- **Criterio:** permite responder «¿con quién está compartida?» y auditar
  revocaciones; coherencia con 4.11 y 4.12.
- **Estado:** **decidida por D2 y AM-3** (27/10/2026): una fila por entrada y
  destinatario, con `revoked_at`, quién revocó (`revoked_by_id`) y el motivo.
  Es el registro de la revocación de cada compartición, no un sistema general
  de auditoría.
- **Propuesta adicional, no decidida:** ligar cada fila a la asignación del
  destinatario (`assignment_id`). Así, terminar la asignación corta el acceso y
  una reasignación, que crea una asignación nueva, no reactiva comparticiones
  anteriores, como exige D2.

## Salida de un autor (decidida por D5)

No es un ADR propio: es una decisión de producto que condiciona el modelo.

- **Decisión de Pablo (27/10/2026):** se desactiva la cuenta y no se borra; se
  impiden nuevos inicios de sesión y se invalidan las sesiones abiertas; se
  conservan las entradas y su autoría; las compartidas siguen disponibles
  para destinatarios con permiso vigente; las privadas quedan sin acceso
  ordinario, también para el administrador.
- **Descartadas para el MVP:** transferir la autoría y la recuperación
  administrativa de entradas privadas.
- **Cerrado por AM-2 y AM-3** (27/10/2026): desactiva el administrador, y el
  administrador puede revocar comparticiones concretas sin leerlas.

## ADR-5. Row Level Security en PostgreSQL

- **Contexto:** la autorización se aplica en la aplicación. RLS sería una
  segunda defensa en la base.
- **Opciones:** solo en la aplicación; aplicación más RLS.
- **Criterio:** complejidad de pasar la identidad del líder a la base en cada
  petición frente al riesgo RN-1; compatibilidad con el hosting.
- **Estado:** abierta.

## ADR-6. Herramienta E2E

- **Contexto:** se pide al menos un recorrido completo en un navegador.
- **Opciones:** tests de sistema de Rails con Capybara; Playwright.
- **Criterio:** que corra de forma estable en el CI; facilidad para escribir
  el recorrido de H3 a H5.
- **Estado:** abierta.

## ADR-7. Despliegue y backups

- **Contexto:** el MVP necesita HTTPS, PostgreSQL con backups y despliegue
  condicionado al CI.
- **Opciones:** una plataforma gestionada; un servidor propio con
  contenedores.
- **Criterio:** backups automáticos y una restauración probada; costo; HTTPS
  forzado; secretos fuera del repositorio; integración con GitHub Actions.
- **Estado:** abierta.

## ADR-8. Servicios externos

- **Contexto:** las invitaciones (AM-5) requieren correo transaccional, y el
  seguimiento de errores ayuda a operar. Los dos son límites por donde el
  feedback podría salir de la aplicación (RN-5).
- **Correo transaccional:** **requisito del MVP** (AM-5). Falta elegir el
  proveedor. Los correos llevan solo el enlace de invitación, sin contraseñas
  ni contenido de feedback.
- **Seguimiento de errores:** opcional; servicio externo o solo logs.
- **Criterio:** que ningún contenido de feedback salga de la aplicación;
  costo y configuración.
- **Estado:** proveedor de correo, abierto (bloquea MVP-BE-2); seguimiento de
  errores, abierto.

---

[Volver al README](../README.md)
