# TaskFlow

TaskFlow es una aplicación Flutter para organizar tareas de un taller de reparación de computadoras. Está dirigida a técnicos y estudiantes que necesitan consultar qué actividades siguen pendientes.

## Alcance del proyecto

En el taller, las tareas de recepción, diagnóstico, generación de comprobantes y sincronización pueden quedar dispersas. TaskFlow reúne estas actividades en una lista y permite consultar el detalle y cambiar el estado de cada tarea.

### Historias de usuario y criterios de aceptación

| Historia de usuario | Criterio de aceptación |
| --- | --- |
| Como técnico, quiero listar mis tareas para saber qué debo hacer. | La lista muestra el título, la prioridad y el estado de cada tarea. |
| Como técnico, quiero abrir una tarea para leer su descripción. | Al tocar una tarjeta, se abre el detalle de esa tarea con descripción, prioridad, estado y usuario. |
| Como técnico, quiero crear una tarea para registrar un pendiente. | El formulario guarda una tarea válida y esta aparece en la lista. |
| Como técnico, quiero editar una tarea para corregir sus datos. | Los cambios guardados aparecen en la lista y en el detalle. |
| Como técnico, quiero eliminar una tarea terminada para limpiar la lista. | Después de confirmar la eliminación, la tarea desaparece de la lista. |

### Modelo de datos

| Campo | Tipo | Descripción |
| --- | --- | --- |
| `id` | `int` | Identificador único de la tarea. |
| `title` | `String` | Título de la tarea. |
| `description` | `String` | Descripción de la tarea. |
| `priority` | `String` | Prioridad. En las tareas del taller puede ser Alta, Media o Baja. |
| `isCompleted` | `bool` | Indica si la tarea está completada. |
| `userId` | `int` | Identificador del usuario asociado. |

### Pantallas

- **Lista.** Muestra el título, la prioridad y un icono con el estado de cada tarea. Permite actualizar desde la barra superior o deslizando hacia abajo.
- **Detalle.** Muestra la información de la tarea seleccionada y permite marcarla como completada o pendiente.
- **Formulario previsto.** Permitirá crear y editar tareas con campos de título, descripción y prioridad.

### Requisitos no funcionales

- La navegación debe usar textos comprensibles.
- Si el ID de una tarea es inválido o inexistente, la app debe mostrar un mensaje.

## API de tareas

TaskFlow usa Dio para consultar las tareas de prueba de JSONPlaceholder mediante `GET` por HTTPS.

```text
https://jsonplaceholder.typicode.com/todos?userId=2
```

El parámetro `userId=2` filtra las tareas del usuario 2. La API devuelve `id`, `title`, `completed` y `userId`. El método `Task.fromJson` convierte `completed` en `isCompleted` y usa los siguientes valores cuando faltan campos.

| Campo | Valor por defecto |
| --- | --- |
| `description` | `Sin descripción (API)` |
| `priority` | `Sin prioridad (API)` |

`TaskApiService` realiza la consulta y registra el código HTTP en la consola. `RemoteTaskRepository` entrega las tareas a `TasksViewModel`, que avisa a la interfaz cuando cambia el estado de la consulta.

Marcar una tarea como completada o pendiente cambia su estado solo en memoria. Al actualizar la lista, la aplicación vuelve a consultar el servidor y recupera su estado. Las cinco tareas del taller se conservan en `LocalTaskRepository` como datos de prueba.

### Operaciones previstas para una API propia

| Método y ruta | Operación |
| --- | --- |
| `GET /tasks` | Listar tareas. |
| `GET /tasks/:id` | Consultar el detalle. |
| `POST /tasks` | Crear una tarea. |
| `PATCH /tasks/:id` | Actualizar una tarea. |
| `DELETE /tasks/:id` | Eliminar una tarea. |

## Cómo ejecutar el proyecto

Desde la raíz de `taskflow`, con Flutter instalado y un dispositivo o emulador disponible, ejecuta los siguientes comandos.

```sh
flutter pub get
flutter run
```

Con Internet y el filtro `userId=2`, una consulta exitosa muestra en la consola `GET /todos?userId=2 → HTTP 200`.

## Sesión 8 — Estados de la lista remota

| Estado | Cómo provocarlo | Resultado esperado |
| --- | --- | --- |
| **Carga** | Pulsa el icono de actualizar. Si la respuesta es muy rápida, reduce la velocidad de red del emulador. | Se muestra un indicador mientras se espera la respuesta. |
| **Datos** | Abre la app con Internet y `userId=2`. Toca una tarjeta. | Aparece la lista remota y se abre el detalle de la tarea seleccionada. |
| **Vacío** | Cambia temporalmente `userId` a `9999` en `lib/features/tasks/data/task_api_service.dart` y reinicia la app. Después de la prueba, restaura `userId=2`. | Aparece el mensaje de lista vacía con el botón **Actualizar**. |
| **Error** | Desconecta Internet en el emulador y pulsa el icono de actualizar. | Aparece un mensaje de error con el botón **Reintentar**. |
| **Recuperación** | Desde la pantalla de error, vuelve a conectar Internet y pulsa **Reintentar**. | La lista remota vuelve a aparecer sin reiniciar TaskFlow. |