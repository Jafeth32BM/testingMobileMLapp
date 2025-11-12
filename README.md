# 📱 Mobile Testing con Appium y Ruby para Mercado Libre

Este proyecto contiene un script de automatización desarrollado en Ruby con la librería Appium. Está diseñado para simular el proceso de búsqueda, filtrado y extracción de datos de productos dentro de la aplicación móvil de Mercado Libre (Android).

# 🚀 Requisitos y Dependencias
Para ejecutar este proyecto, necesitas tener instalados los siguientes componentes en tu sistema:
- Requisitos de Plataforma

|Componente | Version Recomendada | Notas |
|:--- |:--- | :---|
| Node.js | LTS (v18+) | Necesario para ejecutar el servidor Appium. |
| Ruby| v3.0+ | El lenguaje en el que está escrito el script.|
|Java Development Kit (JDK)| v11+ o v17+| Requisito de Android Studio y Appium.|
| Android Studio| Última versión| Para la gestión del SDK de Android y el emulador.|
| Dispositivo fisico| N/A | Si no se cuenta con el emulador se puede utilizar un dispositivo que se debe preparar para que el script pueda correr de manera correcta |

# 📱Prerar el disposivito fisico ⚙️
1. **Habilitar el modo desarrollador**: esto se logra entrando a la Configuración> Acerca del dispositivo> y oprimir unas 5 vecesVersion del sistema
2. **Habilitar Depuracion USB**: Una ves habilitadas las opciones de desarrollador, ingresar y habilitar la opcion _Depuración USB_
3. **Habilitar Instalar Vía USB**: Dentro de _Opciones de desarrollador_ se debe habilitar la opcion _Instalar Vía USB_ esto permite mantener contacto con appium y el dispositivo para enviar los comandos para ejecutar el script

## 🔑 Obtener el UDID del dispositivo
Con la configuracion previa del dispositivo, conectarlo a la PC y en una terminal ejecutar el comando
```Bash
adb devices
```
Debera mostrar algo como
```bash
List of devices attached
T8GYPZIZZTYPKN5P        device
```
Siendo ```T8GYPZIZZTYPKN5P``` el udid que se necesita para colocarlo en las capabilities del proyecto para su correcta ejeccion con el dispositivo indicado.

## Capabilities para este proyecto

```JSON
  caps ={
    platformName: "Android",
    deviceName: "Pixel_7_Pro", #Nombre del emulador
    # deviceName: "POCO_X7_PRO", #Nombre del dispositivo
    # udid: "T8GYPZIZZTYPKN5P", #ID del dispositivo (obtenido con adb devices)
    appPackage: "com.mercadolibre",
    appActivity: "com.mercadolibre.splash.SplashActivity",
    automationName: "UiAutomator2",
    newCommandTimeout: 120,
    noReset: true
}
  
```
**NOTA:** el '#' es un comentario dentro del codigo

## Dependencias de Automatización

Asegúrate de que tus variables de entorno, como ```ANDROID_HOME``` y ```JAVA_HOME```, estén configuradas correctamente.

1. **Instalar Appium Server:** Usa npm para instalar la versión más reciente del servidor de Appium de forma global.
```Bash
npm install -g appium
```
2. **Instalar UiAutomator2 Driver:** Instala el driver específico para automatizar dispositivos Android.
```Bash
appium driver install uiautomator2
```
3. **Dependencias del Proyecto (Gems de Ruby)**
El script requiere las gemas ```appium_lib``` y ```appium_core```.

    - Crea un archivo llamado Gemfile en la raíz de tu proyecto con el siguiente contenido:
    
    ```GemfileRuby
    source https://rubygems.org

    gem appium_lib
    gem appium_core
    ```
    - Instala las dependencias de Ruby ejecutando el siguiente comando en la terminal desde la carpeta del proyecto:
    ```Bash
    bundle install
    ```
# 💻 Configuración y Ejecución
Sigue estos pasos para poner en marcha el script de automatización.
1. **Iniciar el Emulador**

El script está configurado para utilizar el emulador Pixel_7_Pro.

    - Abre Android Studio.
    - Ve a Device Manager (AVD Manager).
    - Inicia el emulador Pixel_7_Pro (o el dispositivo físico que uses). Asegúrate de que esté completamente cargado.

2. **Iniciar Appium Server**
Abre una nueva ventana de terminal y ejecuta el servidor de Appium.
```Bash
appium
```
El servidor debe estar activo y escuchando en el puerto ```4723```.

3. **Verificar las Desired Capabilities**

Confirma que la configuración en tu archivo ```mercadolibre_test.rb``` (Sección 1) coincida con tu entorno:
```Ruby
# ...
deviceName: Pixel_7_Pro, # Debe ser el nombre del emulador. Si se utiliza un UDID, este campo es opcional
appPackage: com.mercadolibre,
# ...
```
4. **Ejecutar el Script**

Abre una tercera ventana de terminal, navega a la carpeta del proyecto donde se encuentra ```mercadolibre_test.rb``` y ejecuta el script:
```Bash
ruby mercadolibre_test.rb
```
---
---
# 🗒️ NOTAS
Mi prueba falto realizar la extraccion de los 5 productos y precios de la lista, pero ya no pude realizarlo debido que _Appium Inspector_ no reconocio los elementos de los filtros y a pesar de que lo hice con 3 emuladores distintos y mi propio dispositivo fisico, no lo reconocio.
Por lo que mi prueba esta sincompleta. Sin embarrgo fue muy enriquesedor y un reto distinto para mi poder realizar pruebas mobiles con una nueva tecnologia.
Adjunto la imagen de la captura que tomo _Appium Inspector_ de la aplicacion (desde mi dispositivio) y el xml de la pantalla de los filtros.