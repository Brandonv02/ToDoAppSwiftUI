# ToDoAppSwiftUI

<img width="1000" height="2400" alt="simulator_screenshot_7CB1A662-AFFF-4D4C-9B78-8B2353B9B453" src="https://github.com/user-attachments/assets/e8770b7d-8877-4a13-a811-4cf615490701" />
<img width="1000" height="2400" alt="simulator_screenshot_707017A3-B3DA-4590-9C87-EB5363CA6545" src="https://github.com/user-attachments/assets/b747704d-5f75-4f94-ae4f-767e049c89d7" />

Descripción

ToDoAppSwiftUI es una aplicación desarrollada con SwiftUI que combina un gestor de tareas (TODO) con una sección financiera para registrar ingresos y egresos. Permite crear, editar y eliminar tareas, además de llevar un control sencillo de movimientos económicos basado en un monto base (por ejemplo, un salario).

Características

- Crear, editar y eliminar tareas.
- Marcar tareas como completadas.
- Sección de finanzas para registrar ingresos y egresos.
- Cálculo y visualización de saldo según una base (salario).
- Interfaz construida con SwiftUI (diseño adaptativo).

Requisitos

- Xcode 12 o superior.
- iOS 14 o superior.
- Swift 5.x.

Instalación

1. Clona el repositorio:
   git clone https://github.com/Brandonv02/ToDoAppSwiftUI.git

2. Abre el proyecto en Xcode:
   - Haz doble clic en ToDoAppSwiftUI.xcodeproj o abre la carpeta en Xcode.

3. Selecciona un simulador o dispositivo y ejecuta la aplicación (Cmd+R).

Uso

- Pestaña "Tareas":
  - Añade nuevas tareas.
  - Edita título, descripción y estado.
  - Elimina tareas.
- Pestaña "Finanzas":
  - Registra ingresos y egresos.
  - Define una base (salario) y consulta el saldo resultante.

Estructura (a alto nivel)

- Interfaz: SwiftUI.
- Persistencia: datos locales (revisar el código para la implementación concreta: UserDefaults, CoreData u otro).
- Arquitectura: separación básica entre vistas y lógica (por ejemplo, MVVM si aplica).

Contribuir

¡Contribuciones bienvenidas! Para colaborar:

1. Haz fork del repositorio.
2. Crea una rama: git checkout -b feature/mi-cambio
3. Realiza tus cambios y commitea: git commit -m "Descripción del cambio"
4. Envía un Pull Request describiendo tus cambios.

Licencia

Añade el archivo LICENSE si quieres usar una licencia (por ejemplo MIT).

Contacto

Desarrollador: Brandonv02