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

- Dependencias de Automatización

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
    source &quot;https://rubygems.org&quot;

    gem &quot;appium_lib&quot;
    gem &quot;appium_core&quot;
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
deviceName: &quot;Pixel_7_Pro&quot;, # ¡Debe coincidir con el nombre de tu emulador!
appPackage: &quot;com.mercadolibre&quot;,
# ...
```
4. **Ejecutar el Script**

Abre una tercera ventana de terminal, navega a la carpeta del proyecto donde se encuentra ```mercadolibre_test.rb``` y ejecuta el script:
```Bash
ruby mercadolibre_test.rb
```
