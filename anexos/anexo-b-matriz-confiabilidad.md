# Anexo B. Matriz de confiabilidad

> Anexo de la primera entrega de Growth Log. El resumen está en la [sección 8 del README](../README.md#8-estado-de-confiabilidad).

**De dónde sale.** La matriz está **inspirada en la publicación compartida
por Igor Buinevici** en LinkedIn, que atribuye la idea a **Manthan Patel**: una
lista de 11 capas que suelen faltarle a un prototipo hecho con vibe coding
para ser un producto real. La publicación **no trae una matriz, niveles ni
puntajes**. Las capas salen de ella; **los estados y el análisis son
nuestros**.

Fuente: <https://www.linkedin.com/posts/igor-buinevici_i-have-used-many-vibe-coding-tools-and-i-share-7501301223619203072-Iczm/>

## Requisitos del MVP por capa

**Nada de esta tabla está implementado:** son requisitos propuestos y lo
que falta decidir o validar para cumplirlos.

| # | Capa | Requisito del MVP (propuesto) | Pendiente de decisión o validación |
|---|---|---|---|
| 1 | Límite de peticiones | Limitar intentos de inicio de sesión y de recuperación de contraseña. | mecanismo (en la aplicación o delante de ella) y umbrales; ADR-2 |
| 2 | Caché y CDN | No es un requisito del MVP; caché de recursos estáticos. | medir antes de agregar nada |
| 3 | Backups y recuperación | Backups automáticos de PostgreSQL y **una restauración probada antes de cargar datos reales**. | proveedor, retención y frecuencia; ADR-7 |
| 4 | Optimización de la base | Índices para las consultas de visibilidad (autor, persona, destinatario); listados sin consultas repetidas; paginación del feed. | medir con datos de prueba |
| 5 | Disponibilidad | Chequeo de salud; un arranque en frío aceptable o una instancia siempre encendida. | según el hosting; ADR-7 |
| 6 | CI/CD y control de versiones | CI en cada pull request (estilo, seguridad, tests) y **despliegue solo con el CI en verde**. | destino de despliegue; ADR-7 |
| 7 | Balanceo y escalado | Una instancia como propuesta inicial, por simplicidad y volumen esperado; el monolito puede ejecutarse en varias. | — |
| 8 | Errores y monitoreo | Seguimiento de errores **sin contenido de feedback**; logs con el feedback filtrado. | herramienta y si es un servicio externo; ADR-8 |
| 9 | Seguridad y Row Level Security | Autorización en el servidor, denegar por defecto, con tests de permitido y rechazado; CSP y HTTPS forzados. | si se suma RLS en PostgreSQL como segunda defensa; ADR-5 |
| 10 | Autenticación y permisos | Invitaciones de un solo uso y con vencimiento por correo; política PP-1 a PP-9; política de contraseñas; desactivación con invalidación de sesiones; siempre un administrador activo; cuenta administradora inicial sin secretos en el repositorio; seeds solo en desarrollo. | biblioteca de autenticación (ADR-2) y proveedor de correo (ADR-8) |
| 11 | Hosting e infraestructura | HTTPS forzado, PostgreSQL gestionado y secretos fuera del repositorio. | proveedor; ADR-7 |

**Lectura de conjunto (nuestra).** Para el MVP pesan sobre todo la
capa 9 (es la que protege el feedback entre líderes), la 3 (antes de cargar
datos reales) y la 6 (para que lo que se despliega esté probado).

---

[Volver al README](../README.md)
