# TaskFlow

TaskFlow es una aplicación Flutter para organizar tareas de un taller de reparación de computadoras. Está dirigida a técnicos y estudiantes que necesitan consultar qué actividades siguen pendientes.

## Alcance del proyecto

Las tareas de recepción, diagnóstico, generación de comprobantes y sincronización pueden quedar dispersas. TaskFlow reúne estas actividades en una lista, permite consultar su detalle y cambiar su estado durante el uso de la aplicación.

### Historias de usuario y criterios de aceptación

| Historia de usuario | Criterio de aceptación |
| --- | --- |
| Como técnico, quiero listar mis tareas para saber qué debo hacer. | La lista muestra el título, la prioridad y el estado de cada tarea. |
| Como técnico, quiero abrir una tarea para leer su descripción. | Al tocar una tarjeta, se abre el detalle de esa tarea con descripción, prioridad, estado y usuario. |
| Como técnico, quiero crear una tarea para registrar un pendiente. | El formulario guarda una tarea válida y esta aparece en la lista. |
| Como técnico, quiero editar una tarea para corregir sus datos. | Los cambios guardados aparecen en la lista y en el detalle. |
| Como técnico, quiero eliminar una tarea terminada para limpiar la lista. | Después de confirmar la eliminación, la tarea desaparece de la lista. |

### Modelo de datos

| Campo de `Task` | Tipo | Descripción |
| --- | --- | --- |
| `id` | `int` | Identificador único de la tarea. |
| `title` | `String` | Título de la tarea. |
| `description` | `String` | Descripción de la tarea. |
| `priority` | `String` | Prioridad. En las tareas del taller puede ser Alta, Media o Baja. |
| `isCompleted` | `bool` | Indica si la tarea está completada. |
| `userId` | `int` | Identificador del usuario asociado. |

El formulario usa `TaskDraft` para devolver el título, la descripción, la prioridad y una fecha opcional (`dueDate`, de tipo `DateTime?`).

### Pantallas

- **Lista.** Muestra el título, la prioridad y un icono con el estado de cada tarea. Permite actualizar desde la barra superior o deslizando hacia abajo. El botón **Nueva tarea** abre el formulario.
- **Detalle.** Muestra la información de la tarea seleccionada y permite marcarla como completada o pendiente.
- **Nueva tarea.** Valida que el título tenga al menos tres caracteres sin contar los espacios de los extremos. Permite escribir una descripción, elegir la prioridad y seleccionar una fecha opcional. Al pulsar **Guardar** con datos válidos, vuelve a la lista y muestra una confirmación. En la sesión 9 se devuelve un borrador. La creación mediante `POST` se implementará en la sesión 10.

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

Marcar una tarea como completada o pendiente cambia su estado en memoria. Al actualizar la lista, la app vuelve a consultar el servidor y recupera su estado. Las cinco tareas del taller se conservan en `LocalTaskRepository` como datos de prueba.

### Operaciones previstas para una API propia

| Método y ruta | Operación |
| --- | --- |
| `GET /tasks` | Listar tareas. |
| `GET /tasks/:id` | Consultar el detalle de una tarea. |
| `POST /tasks` | Crear una tarea. |
| `PATCH /tasks/:id` | Actualizar una tarea. |
| `DELETE /tasks/:id` | Eliminar una tarea. |

## Cómo ejecutar el proyecto

Desde la raíz de `taskflow`, con Flutter instalado y un dispositivo o emulador disponible, ejecuta estos comandos.

```sh
flutter pub get
flutter run
```

Con Internet y el filtro `userId=2`, una consulta exitosa muestra en la consola `GET /todos?userId=2 → HTTP 200`.

## Sesión 8 — Estados de la lista remota

| Estado | Cómo probarlo | Resultado esperado |
| --- | --- | --- |
| Carga | Pulsa el icono de actualizar. Si la respuesta es muy rápida, reduce la velocidad de red del emulador. | Aparece un indicador mientras se espera la respuesta. |
| Datos | Abre la app con Internet y `userId=2`, y toca una tarjeta. | Aparece la lista remota y se abre el detalle de la tarea seleccionada. |
| Vacío | Cambia temporalmente `userId` a `9999` en `task_api_service.dart` y reinicia la app. Restaura el valor `2` al terminar. | Aparece el mensaje de lista vacía y el botón **Actualizar**. |
| Error | Desconecta Internet en el emulador y pulsa el icono de actualizar. | Aparece el mensaje de error y el botón **Reintentar**. |
| Recuperación | Reconecta Internet y pulsa **Reintentar**. | La lista remota vuelve a aparecer sin reiniciar la app. |

## Sesión 9 — Formulario de nueva tarea

| Caso | Cómo probarlo | Resultado esperado |
| --- | --- | --- |
| Título vacío | Abre **Nueva tarea** y pulsa **Guardar** sin escribir un título. | El formulario sigue abierto y solicita un título. |
| Título demasiado corto | Escribe `PC` y pulsa **Guardar**. | El formulario indica que el título necesita al menos tres caracteres. |
| Tarea válida sin fecha | Escribe `Revisar laptop Dell`, elige una prioridad y pulsa **Guardar** con la fecha vacía. | La app vuelve a la lista y muestra `Formulario válido: Revisar laptop Dell`. |
| Tarea válida con fecha | Escribe un título válido, pulsa **Elegir fecha**, selecciona un día y guarda. | El formulario muestra la fecha seleccionada y la incluye en el borrador al volver a la lista. |
| Volver sin guardar | Abre el formulario y pulsa la flecha de regreso. | La app vuelve a la lista sin mostrar una confirmación nueva. |
| Detalle de una tarea existente | Toca una tarjeta de la lista. | Se abre el detalle de la tarea seleccionada. |