# Anexo F. Registro de prompts

> Anexo de [prompts.md](../prompts.md). Texto de los prompts publicados,
> ejecutados en Claude Code, en el orden en que se enviaron.

**Colaboración:** Pablo definió el objetivo y tomó decisiones; los pedidos
se prepararon con ayuda de ChatGPT (según lo declarado por Pablo; esas
conversaciones no se conservan) y se ejecutaron en Claude Code (CLI) con
Claude Opus 5.5 (comprobado en la transcripción).

**Nota de sanitización.** Se publican cuatro prompts de la preparación de la
entrega; otros no se incluyen en esta versión pública. Cambios respecto del
original:

- la ruta de la carpeta de notas se reemplazó por `[carpeta de notas]` y la
  del PDF de la visión por `[ruta local del PDF]`;
- se omitieron fragmentos que no corresponden a esta versión pública,
  marcados como `[fragmento omitido]` en el lugar donde estaban;
- en los flujos 2, 3 y 4 se quitaron las marcas técnicas de texto pegado.

Los prompts usan algunos nombres provisorios de borradores anteriores de la
documentación: «TK-4» es el ticket de base de datos que en la entrega se
llama MVP-DB-1.

El resto es literal, incluidos los errores de tipeo. Los textos no contienen
credenciales, correos ni feedback real. Las respuestas del asistente no se
incluyen.

## Flujo 1. Política de privacidad para varios líderes

Enviado el 27/10/2026 a las 15:26 UTC.

```text
Definamos una propuesta inicial de privacidad para el MVP de Growth Log,
pensado para varios líderes en una misma instancia.

La regla general es privacidad por defecto y compartición explícita:

1. Cada líder tiene su propia cuenta.
2. Un líder puede acceder a la ficha de una persona si está autorizado
   a acompañarla. Una persona puede tener más de un líder.
3. Los borradores solo los ve, edita y publica su autor.
4. Una entrada marcada como «lista» sigue siendo privada del autor
   hasta que este decida compartirla.
5. Una entrada compartida puede ser leída por los líderes autorizados
   a recibirla, pero solo su autor puede editarla.
6. El feed y el resumen de una persona muestran únicamente las entradas
   que el líder tiene permiso para ver.
7. Si un líder deja el equipo o pierde su cuenta, sus entradas no se
   borran automáticamente. Cómo se conserva o transfiere el acceso
   queda pendiente de diseño.

Diferenciá «lista» de «compartida»: el estado indica que la entrada
está preparada; la visibilidad determina quién puede verla.

Todavía no decidimos:
- quién asigna líderes a personas ni si habrá administradores;
- cómo se eligen los destinatarios y cómo se revoca una compartición;
- [fragmento omitido]
- si la persona que recibe feedback tendrá acceso en el futuro;
- cómo se recupera el acceso a las entradas cuando un autor se va.

Actualizá los dos borradores de la carpeta [carpeta de notas]:
- la visión y los requisitos transversales;
- las cinco historias y sus criterios de aceptación;
- la historia del feed y la del resumen individual;
- el ticket TK-4 y los diagramas, dejando el diseño de base de datos
  pendiente hasta resolver las decisiones anteriores;
- los riesgos y el backlog.

[fragmento omitido]

Mostrame el resumen de los cambios y las preguntas que quedan abiertas.
[fragmento omitido]
```

## Flujo 2. La presentación como fuente de la visión

Enviado el 27/10/2026 a las 22:19 UTC.

```text
Usá también el PDF «El problema de evaluar de memoria», ubicado en
[ruta local del PDF], como fuente de la
visión original del producto.

Contrastá sus objetivos [fragmento omitido] con el MVP nuevo:

- qué problema describe y para quién;
- qué propone para capturar y revisar feedback;
- qué coincide con las cinco historias que elegimos;
- qué es una intención o hipótesis y todavía no está comprobado.

En particular, no presentes como resultados medidos la captura en
30 segundos, la reducción de sesgos o la mejora de las evaluaciones.
La privacidad efectiva y el acceso de cada persona a su propio
feedback también deben distinguirse entre propuesta y [fragmento omitido].

Integrá estas conclusiones a la propuesta de documentación y citá
el PDF como fuente de la visión. No lo publiques ni lo copies al
repositorio todavía.
```

## Flujo 3. Arquitectura, modelo de datos y stack

Enviado el 27/10/2026 a las 22:24 UTC.

```text
Vamos a preparar una propuesta concreta de arquitectura, modelo de datos
y stack para la primera entrega de Growth Log en AI4Devs.

Contexto

Growth Log es un proyecto personal de Pablo. [fragmento omitido]

La primera entrega es documental. Necesitamos un diseño coherente y
defendible, distinguiendo claramente lo propuesto de lo implementado.

Punto de partida para evaluar

- Una aplicación web para varios líderes.
- Un monolito Ruby on Rails, con vistas ERB y Hotwire.
- PostgreSQL como base de datos.
- Cuentas individuales y autorización aplicada en el servidor.
- Privacidad por defecto y compartición explícita.
- Tests unitarios, de integración y al menos un recorrido completo.
- CI para verificar los cambios antes del despliegue.
- Documentación en Markdown y diagramas Mermaid.

Tomá esto como propuesta inicial, no como una decisión irrevocable ni
como una descripción de lo que ya está construido.

1. Arquitectura

Proponé una arquitectura que soporte las cinco historias del MVP.
Mostrá en un diagrama Mermaid:

- navegador e interfaz;
- aplicación Rails;
- autenticación y autorización;
- personas y feedback;
- base de datos;
- límites con servicios externos, solo si proponés alguno.

Explicá por qué un monolito encaja, qué responsabilidades tendría cada
componente y cuáles son las principales decisiones pendientes.

No afirmes que los permisos, el CI, los backups o el despliegue existen:
son requisitos o propuestas hasta que se implementen y verifiquen.

2. Modelo de datos conceptual

Partí de estas entidades y relaciones como hipótesis:

- líder o usuario;
- persona acompañada;
- acompañamiento o asignación de líderes a personas;
- entrada de feedback, con autor y persona;
- compartición de una entrada con líderes autorizados.

Prepará un diagrama Mermaid y una tabla con la responsabilidad de cada
entidad. Indicá cardinalidades y restricciones necesarias para las cinco
historias.

Todavía no presentes el diagrama como una migración lista. Señalá qué
depende de decidir quién asigna líderes, cómo se comparten y revocan
entradas, y qué ocurre cuando un autor deja el equipo.

Definí «lista» como estado y compartición como permiso de lectura:
una entrada lista sigue siendo privada hasta compartirse. Los borradores
son privados de su autor.

3. Stack y alternativas

Evaluá la propuesta inicial:

- Ruby y Rails;
- ERB y Hotwire;
- PostgreSQL;
- Devise u otra opción de autenticación;
- RSpec y una herramienta E2E por elegir;
- GitHub Actions para CI;
- despliegue por decidir.

Para cada elección, indicá por qué encaja, qué alternativa razonable
hay y qué decisión o comprobación falta. No fijes versiones concretas
sin verificar compatibilidad y soporte.

4. Relación con la entrega

Vinculá el diseño con las cinco historias, los criterios de aceptación
y los tickets. Proponé cómo representar las operaciones principales
en la sección de API/rutas de la plantilla, sin afirmar que ya existe
una API JSON.

Usá el PDF «El problema de evaluar de memoria» como fuente de la visión
del producto. Tratá los 30 segundos, la reducción del sesgo y los
beneficios de evaluación como objetivos o hipótesis, no como resultados
medidos.

Conservá la matriz de confiabilidad y diferenciá:
- [fragmento omitido]
- los requisitos del MVP nuevo;
- lo que queda pendiente de decisión o validación.

5. Resultado

Prepará los cambios propuestos al README y a los anexos en
[carpeta de notas]/, conservando los borradores anteriores.
Mostranos:

- los diagramas;
- la tabla de stack y alternativas;
- cómo cada historia queda cubierta;
- decisiones abiertas y riesgos;
- qué cambió respecto del borrador anterior.

[fragmento omitido]
No hagas fork, commits, push, PR ni publicación.
```
## Flujo 4. Decisiones de administración, compartición y salida de un autor

Enviado el 27/10/2026 a las 23:51 UTC.

```text
Acepto estas decisiones para el MVP de Growth Log. Registralas como
decisiones de Pablo y alineá la entrega con ellas.

Trabajá en feature/entrega-1-pp-mvp, cuyo HEAD esperado es:
ee84919c2514945e7aade68c7c50fc6c1d053269

Confirmá primero la rama y el estado. No crees otra rama.

D1. Administración
- Un administrador crea cuentas, crea y edita personas, asigna líderes
  y termina sus asignaciones.
- Los líderes consultan las personas asignadas y registran feedback.
  No crean personas ni modifican sus datos o asignaciones.
- Una persona puede tener varios líderes.
- Ser administrador no permite leer todo el feedback. Para consultar
  entradas se aplican las mismas reglas de autoría y compartición.
- Una misma cuenta puede administrar y acompañar personas.
- Para el MVP, la cuenta administradora inicial se provisionará mediante
  un procedimiento documentado, sin credenciales fijas en el repositorio.

D2. Compartición
- Solo el autor puede compartir una entrada propia y lista.
- Se comparte individualmente con cuentas activas de líderes que
  acompañan actualmente a esa persona.
- El destinatario puede leer, pero no editar ni volver a compartir.
- Revocar registra revoked_at y quita el permiso en las siguientes
  consultas. No puede retirar información que alguien ya haya leído.
- Terminar la asignación del destinatario también quita el acceso.
- Si vuelve a ser asignado, las comparticiones anteriores no recuperan
  vigencia automáticamente: el autor debe compartir nuevamente.
- Las operaciones deben comprobar estas condiciones en el servidor,
  incluidas las peticiones directas por URL.

D5. Salida de un autor
- Se desactiva la cuenta; no se borra.
- Se impiden nuevos inicios de sesión y se invalidan las sesiones
  existentes.
- Se conservan las entradas y su autoría.
- Las entradas compartidas siguen disponibles para destinatarios activos
  que mantengan asignación y permiso.
- Las privadas se conservan sin acceso ordinario, tampoco para el
  administrador.
- No hay transferencia de autoría ni recuperación administrativa de
  entradas privadas en este MVP.

Qué actualizar:
1. README, política PP, decisiones D1/D2/D5 y ADR relacionados.
2. H1: separar explícitamente las acciones del administrador de las del
   líder. Conservá cinco historias y ajustá los criterios necesarios,
   sin mantener artificialmente el conteo actual.
3. Modelo de datos y reglas: expresar capacidades administrativas,
   asignaciones, desactivación y comparticiones. Asegurar que una nueva
   asignación no reactive permisos antiguos.
4. Tickets: cubrir la administración mínima necesaria para habilitar el
   recorrido, las dependencias y las pruebas de permisos.
5. Mocks y sus notas: alinearlos con las decisiones aceptadas. No hace
   falta agregar pantallas; identificá si queda alguna acción del
   administrador sin ilustrar.
6. Riesgos y matriz: actualizar consecuencias y decisiones resueltas.
7. Registro de IA: registrar este pedido y su resultado conforme al
   formato existente, sin superar los cinco workflows principales.

Incluí casos de prueba propuestos para:
- administrador sin permiso de lectura;
- destinatario que intenta editar o compartir;
- revocación;
- fin de asignación y posterior reasignación;
- desactivación con una sesión previamente abierta;
- permanencia de la autoría y de las comparticiones válidas cuando
  se desactiva al autor.

No inventes decisiones adicionales. Si aparece una ambigüedad que afecte
permisos, señalala y proponé una resolución sin darla por aceptada.

Revisá coherencia completa, conteos, enlaces, diagramas renderizados,
mocks y datos sensibles. Hacé un commit local nuevo y mostrame:
- hash y estado final;
- cambios principales;
- decisiones que siguen abiertas;
- cualquier contradicción pendiente.

No crees fork ni remotos, no hagas push ni PR y no completes el
formulario. [fragmento omitido]
```

---

[Volver a prompts.md](../prompts.md)
