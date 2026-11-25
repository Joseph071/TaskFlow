# TaskFlow

TaskFlow es una aplicación Flutter para consultar y organizar tareas de un taller de reparación de computadoras. Está dirigida a técnicos y estudiantes que necesitan saber qué actividades siguen pendientes.

## Alcance del proyecto

En el taller, las actividades de recepción, diagnóstico, emisión de comprobantes y sincronización pueden quedar dispersas. TaskFlow reúne las tareas en una lista y permite consultar el detalle y cambiar su estado.

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
| `priority` | `String` | Prioridad de la tarea. En los datos del taller puede ser Alta, Media o Baja. |
| `isCompleted` | `bool` | Indica si la tarea está completada. |
| `userId` | `int` | Identificador del usuario asociado. |

### Pantallas

- **Lista.** Muestra las tareas con su título, prioridad e icono de estado. Al tocar una tarjeta, se abre el detalle.
- **Detalle.** Muestra la descripción, prioridad, estado y usuario. Permite marcar la tarea como completada o pendiente.
- **Formulario previsto.** Permitirá crear y editar tareas con campos de título, descripción y prioridad.

### Requisitos no funcionales

- La navegación debe usar textos comprensibles.
- Si el ID de una tarea es inválido o inexistente, la app debe mostrar un mensaje.

## API de tareas

En la sesión 7, TaskFlow obtiene las tareas de prueba de JSONPlaceholder con Dio mediante una solicitud `GET` por HTTPS.

```text
https://jsonplaceholder.typicode.com/todos?userId=2