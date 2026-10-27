# Anexo F. Registro de prompts

> Anexo de [prompts.md](../prompts.md). Texto de los prompts publicados,
> ejecutados en Claude Code, en el orden en que se enviaron.

**Colaboración:** Pablo definió el objetivo y tomó decisiones; los pedidos
se prepararon con ayuda de ChatGPT (según lo declarado por Pablo; esas
conversaciones no se conservan) y se ejecutaron en Claude Code (CLI) con
Claude Opus 5.5 (comprobado en la transcripción).

**Nota de sanitización.** Se publican tres prompts de la preparación de la
entrega; otros no se incluyen en esta versión pública. Cambios respecto del
original:

- la ruta de la carpeta de notas se reemplazó por `[carpeta de notas]` y la
  del PDF de la visión por `[ruta local del PDF]`;
- se omitieron fragmentos que no corresponden a esta versión pública,
  marcados como `[fragmento omitido]` en el lugar donde estaban;
- en los flujos 2 y 3 se quitaron las marcas técnicas de texto pegado.

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

---

[Volver a prompts.md](../prompts.md)
