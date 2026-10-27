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
- **Criterio:** un único lugar para la autorización; simplicidad de prueba y
  despliegue; experiencia previa de Pablo.
- **Estado:** propuesta.

## ADR-2. Autenticación

- **Contexto:** PP-1 exige cuentas individuales. El MVP necesita inicio de
  sesión, probablemente recuperación de contraseña y límite de intentos.
- **Opciones:** Devise; el generador de autenticación de Rails más funciones
  propias; un proveedor externo (OAuth).
- **Criterio:** funciones necesarias sin código propio sensible; si la
  recuperación exige correo (ADR-8); quién crea las cuentas (D1).
- **Estado:** abierta.

## ADR-3. Implementación de las políticas y respuesta ante acceso no autorizado

- **Contexto:** PP-2 a PP-6 se aplican en el servidor y tienen que poder
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
- **Estado:** abierta. Alternativa propuesta para evaluar primero: filas por
  destinatario. **No está resuelta:** depende de D2.

## Alternativas para la salida de un autor (sujetas a D5)

No es un ADR propio: depende de la decisión de producto D5. Se registra aquí
porque condiciona el modelo de datos.

- **Desactivar al autor en lugar de borrarlo** (alternativa propuesta): sus
  entradas se conservan y siguen legibles para quienes ya las tenían
  compartidas.
- **Transferir sus entradas** a otro líder de la persona.
- **Archivar sus entradas:** se conservan, pero nadie las ve hasta que se
  decida otra cosa.

**Estado:** abierta; sujeta a D5.

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

- **Contexto:** la recuperación de contraseña necesita correo, y el
  seguimiento de errores ayuda a operar. Los dos son límites por donde el
  feedback podría salir de la aplicación (RN-5).
- **Opciones:** correo transaccional sí o no en el MVP; seguimiento de
  errores con un servicio externo o solo con logs.
- **Criterio:** que ningún contenido de feedback salga de la aplicación;
  costo y configuración.
- **Estado:** abierta.

---

[Volver al README](../README.md)
