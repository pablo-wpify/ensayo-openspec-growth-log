# E1-ENSAYO. Base del proyecto: Rails con PostgreSQL, chequeo de salud y CI

> Ticket del ensayo con OpenSpec, derivado de la tarea habilitadora E1 del
> [Anexo G](../anexos/anexo-g-plan-incremental.md#g3-tareas-habilitadoras).
> Copia aislada y descartable: nada de esto forma parte de la entrega.

## Problema

No existe código. Antes de cualquier incremento (I1 en adelante) hace falta
una base que arranque, se pruebe sola y tenga definido el CI.

## Resultado esperado

Una aplicación Rails 8.1.4 sobre Ruby 4.0.9 con PostgreSQL 18.6 que
responde al chequeo de salud, tiene tests automatizados con RSpec que
incluyen una consulta real a PostgreSQL, pasa estilo, seguridad y tests con
`bin/ci` en local, e incluye un workflow de GitHub Actions equivalente,
definido pero no ejecutado en este ensayo.

## Decisiones aceptadas por Pablo para el ensayo

- Ruby 4.0.9 y Rails 8.1.4, las últimas estables. `.ruby-version` es la
  fuente de la versión de Ruby; en local, asdf la toma mediante
  `ASDF_RUBY_VERSION`, limitado al entorno del ensayo, sin modificar
  `~/.tool-versions` ni `~/.asdfrc`.
- RSpec como framework de tests, como propone la sección 2.2 del README.
- Monolito Rails (ADR-1) como base del ensayo.
- PostgreSQL 18.6, en local y en el workflow de CI, con autenticación por
  contraseña.
- La auditoría de importmap forma parte del pipeline de seguridad, en
  `bin/ci` y en el workflow, porque la aplicación generada usa importmap.
- Copia aislada, herramientas instaladas solo para el ensayo y un
  contenedor de PostgreSQL exclusivo.

## Alcance

- `rails new` con PostgreSQL, sin generar tests de Minitest (`-T`).
  Opciones: `--database=postgresql -T --skip-kamal --skip-thruster
  --skip-docker --skip-solid --skip-action-mailbox --skip-action-text
  --skip-active-storage --skip-jbuilder --skip` (`--skip` conserva el
  README y los anexos existentes).
- `.ruby-version` como única fuente de configuración de la versión de Ruby:
  el `Gemfile`, el CI y el entorno local del ensayo la leen de allí. Los
  archivos generados, como `Gemfile.lock`, pueden registrarla
  automáticamente.
- Conexión a PostgreSQL por las variables `DATABASE_HOST`, `DATABASE_PORT`,
  `DATABASE_USERNAME` y `DATABASE_PASSWORD`, las mismas en local y en el CI.
  - En local, los valores salen del archivo de entorno del ensayo, fuera
    del repositorio.
  - En el CI, el servicio `postgres:18.6` usa un usuario y una contraseña
    exclusivamente de prueba, definidos en el workflow, que no coinciden con
    ninguna credencial local ni real.
- Preparación explícita de las bases `growth_log_ensayo_development` y
  `growth_log_ensayo_test`: en local, las dos, con `bin/rails db:prepare` y
  `RAILS_ENV=test bin/rails db:prepare`; en GitHub Actions, solo la de test.
- RSpec (`rspec-rails`) con:
  - un test de petición de `GET /up`, cuya comprobación negativa consiste
    en alterar temporalmente la ruta o su respuesta, no la expectativa del
    test;
  - un test que ejecuta una consulta real a PostgreSQL en el entorno de
    test y comprueba el adaptador y la versión mayor del servidor, sin
    crear modelos del dominio;
  - un test de los seeds que comprueba directamente que, fuera de
    desarrollo, la ejecución no llega a la parte que crea datos.
- Pipeline de verificación, igual en `bin/ci` y en el workflow:
  - estilo: RuboCop;
  - seguridad: `bundler-audit` (gemas), auditoría de importmap (paquetes
    JavaScript fijados por importmap) y `brakeman` (análisis estático);
  - tests: preparación de la base de test y RSpec.
- `db/seeds.rb` que solo ejecuta la creación de datos en desarrollo.

## Exclusiones

Autenticación (E2), políticas (E3), controles previos a exponer el sistema
(E4), invitaciones, personas, entradas, modelos de dominio y pantallas;
despliegue, Kamal, Thruster y Dockerfile (ADR-7 abierta); herramienta E2E
(ADR-6 abierta).

## Dependencias

- Ruby 4.0.9 y Rails 8.1.4 instalados solo para el ensayo.
- Contenedor `growthlog-ensayo-pg` (PostgreSQL 18.6) en `127.0.0.1:55432`.
- Credenciales locales de la base solo en el archivo de entorno del ensayo,
  fuera del repositorio.

## Criterios de aceptación

| # | Criterio | Dónde se verifica |
|---|---|---|
| A1 | con el entorno del ensayo cargado, `ruby -v` en el proyecto coincide con `.ruby-version` y `bin/rails -v` da 8.1.4; `.ruby-version` es la única fuente de configuración de la versión de Ruby: el `Gemfile`, el workflow de CI y el entorno local la leen de allí sin escribir el número. `Gemfile.lock` y otros metadatos generados pueden registrarla automáticamente y no se editan para quitarla | local |
| A2 | en local, `bin/rails db:prepare` y `RAILS_ENV=test bin/rails db:prepare` crean o actualizan las bases de desarrollo y de test del ensayo en PostgreSQL 18.6, y pueden repetirse sin errores | local |
| A3 | `GET /up` responde 200, comprobado por un test de petición de RSpec | local |
| A4 | un test de RSpec ejecuta una consulta real a PostgreSQL en el entorno de test y comprueba que el servidor es PostgreSQL 18, sin modelos del dominio | local |
| A5 | `bin/ci` termina sin errores: RuboCop, `bundler-audit`, auditoría de importmap, `brakeman`, preparación de la base de test y RSpec | local |
| A6 | `.github/workflows/ci.yml` corre los mismos pasos en cada pull request, con el servicio `postgres:18.6` autenticado por contraseña de prueba y la base de test preparada | **solo GitHub Actions** |
| A7 | fuera de desarrollo, la ejecución de los seeds no llega a la parte que crea datos, comprobado por un test directo | local |
| A8 | el repositorio no contiene secretos ni credenciales locales o reales: `config/master.key` no está versionada y la única contraseña versionada es la de prueba del servicio de CI | local |

**A6 queda pendiente** hasta que el workflow se ejecute en GitHub Actions.
Mientras siga pendiente, **E1 no se declara completo** y el cambio de
OpenSpec **no se archiva**.

## Relación con la entrega

E1 del Anexo G; secciones 2.2 a 2.5 del README; Anexo B, capas 5
(chequeo de salud), 6 (CI/CD) y 9 (seguridad). La aceptación de E1 dice
«un pull request corre … en el CI»: en el ensayo se cumple solo en local
hasta ejecutar A6.
