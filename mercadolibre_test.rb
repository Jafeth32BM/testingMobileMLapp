require 'appium_lib'

# 1. Definir Desired Capabilities
  caps ={
    platformName: "Android",
    deviceName: "Pixel_7_Pro", #Nombre del dispositivo o emulador
    appPackage: "com.mercadolibre",
    appActivity: "com.mercadolibre.splash.SplashActivity",
    automationName: "UiAutomator2",
    newCommandTimeout: 120,
    noReset: true
  }

# 2. Iniciar el Driver de Appium
begin
  $driver = Appium::Driver.new(caps: caps).start_driver
  Appium.promote_appium_methods Object
  puts "Driver iniciado con éxito."
rescue StandardError => e
  puts "--- ERROR FATAL AL INICIAR EL DRIVER ---"
  puts "Asegúrate de que el servidor Appium esté corriendo y las Capabilities sean correctas."
  puts "Detalles del error: #{e.message}"
  exit
end

#=============Funcion para la espera dinamica (Helper)================
# Función de ayuda para la espera (para evitar repetir código)
# 'strategy' debe ser un símbolo (:id, :xpath, etc.)
def wait_for_element(strategy, locator_value, timeout = 5, success_msg = "Elemento encontrado.")
  begin
    $driver.wait_until(timeout: timeout) do
      # Sintaxis Correcta: se usa el símbolo de la estrategia como llave.
      $driver.find_element(strategy => locator_value).displayed?
    end
    puts success_msg
  rescue
    puts "ADVERTENCIA: El elemento con #{strategy.to_s.upcase} '#{locator_value}' no apareció después de #{timeout} segundos."
  end
end
#============================================================

#3. Realizar acciones
puts "Sesión iniciada. Abirendo aplicacion"
#Buscar componentes

#Si pregunta por iniciar sesion o invitado, seleccionar visitante.
# Xpath del boton
visitante = '//android.widget.TextView[@resource-id="com.mercadolibre:id/andes_button_text" and @text="Continuar como visitante"]'
# Guarda el elemetno en una variable
visitBtn = $driver.find_elements(xpath: visitante)
# Condicional
if visitBtn.size > 0
  puts "Se encontró el botón 'Continuar como visitante'. Haciendo clic."
  # Si encuentra un elemento hacer clic.
  visitBtn[0].click
  # Esperar por cambio de pantalla
  # wait_for_element(:xpath, visitante, 5, "Pantalla principal cargada") # Reemplazado por una espera a la barra de búsqueda si fuera necesario
else
  #Si no se encuentra, continuar
  puts "El botón 'Continuar como visitante' no apareció. Continuando..."
end

# Condicional por si preguntan de notificaciones
notif = '//android.widget.Button[@content-desc="Ahora no."]'
# Guardar elemento
notifBtn = $driver.find_elements(xpath: notif)
# Condicional
if notifBtn.size > 0
  puts "Se mostro la pantalla de notificaiones'. Haciendo clic, en Ahora no"
  # Si encuentra un elemento hacer clic.
  notifBtn[0].click
  # Esperar por cambio de pantalla
  # wait_for_element(:xpath, notif, 5, "Notificaciones cerradas") # Reemplazado por una espera a la barra de búsqueda si fuera necesario
else
  #Si no se encuentra, continuar
  puts "No hay ventana de notificaciones. Continuando. . . "
end

#4 Buscar el producto en la barra de busqueda
searchBar_Id ='com.mercadolibre:id/ui_components_toolbar_title_toolbar'
inputSearch_Id = 'com.mercadolibre:id/autosuggest_input_search'

$driver.find_element(id: searchBar_Id).click
# CORRECCIÓN DE SINTAXIS: Uso de :id y 5 segundos de timeout
wait_for_element(:id, inputSearch_Id, 5, "- Barra de busqueda abierta")

$driver.find_element(id: inputSearch_Id).send_keys("playstation 5")
$driver.press_keycode(66) #Tecla de Enter

#5 Colocar los filtros

#5.1 Filtro de "Condicion: Nuevo"
filtros = '(//android.widget.LinearLayout[@resource-id="com.mercadolibre:id/appbar_content_layout"])[1]/android.widget.LinearLayout'
# CORRECCIÓN DE SINTAXIS
wait_for_element(:xpath, filtros, 5, "===Aplicando Filtros===")
$driver.find_element(xpath: filtros).click

# CORRECCIÓN DE SINTAXIS
condicion = '//android.view.View[@content-desc="Condición"]'
wait_for_element(:xpath, condicion, 5, "Condicion...")
$driver.find_element(xpath: condicion).click

# CORRECCIÓN DE SINTAXIS
nuevo= '//android.widget.ToggleButton[@resource-id="ITEM_CONDITION-2230284"]'
wait_for_element(:xpath, nuevo, 5, "... nuevo")
$driver.find_element(xpath: nuevo).click

#5.2 Filtro de Envio: Local
envio= '(//android.widget.TextView[@text="Envíos"])[1]'
# CORRECCIÓN DE SINTAXIS
wait_for_element(:xpath, envio, 5, "Envío: . . .")
$driver.find_element(xpath: envio).click

# Corregido a ID (si el XPath de tu original fallaba)
local= '//android.widget.ToggleButton[@resource-id="SHIPPING_ORIGIN-10215068"]'
wait_for_element(:xpath, local, 5, ". . . Local")
$driver.find_element(xpath: local).click

#5.3 Ordernar por: Menor precio
#Ubicacion de los elementos con xpath
ordenar_xpath = '//android.view.View[@content-desc="Ordenar por "]' 
menor_xpath = '//android.widget.ToggleButton[@resource-id="sort-price_asc"]'

max_scrolls = 10 
scroll_count = 0
found = false

puts "Ubicando componente: 'Ordenar por'..."

while scroll_count < max_scrolls && !found #Repite la funcion hasta encontrar el elmento o al maximo de scrolls
    begin
        #Verificar si aparece el elemento
        $driver.find_element(:xpath, ordenar_xpath)
        found = true
        puts "Elemento 'Ordenar por' encontrado."
    rescue
        # Si no lo encuentra realiza un scroll
        puts "#{scroll_count + 1}.- Elemento no encontrado, deslizando..."

        $driver.execute_script('mobile: dragGesture', {
            startX: 720,
            startY: 2500,
            endX: 720,
            endY: 1000,
            duration: 800
        })
        
        scroll_count += 1
        sleep 2 # Actualizar la interfaz de la app
    end
end

# ----------------- Revisa si el boton se encuentra -----------------
if found
    begin
        # Seleccionar Ordenar por
        $driver.find_element(:xpath, ordenar_xpath).click
        
        # Seleccionar Menor precio
        wait_for_element(:xpath, menor_xpath, 5, ". . . Menor precio")
        $driver.find_element(xpath: menor_xpath).click
        
    rescue StandardError => e
        puts "ERROR al interactuar con el elemento 'Ordenar por' después del scroll. Detalles: #{e.message}"
    end
else
    puts "ERROR: El elemento 'Ordenar por' no se encontró después de #{max_scrolls} intentos de deslizamiento."
end

# 5.4 Aplicar Filtros
aplicar= '//android.widget.Button[@resource-id=":r3:"]'
# Aumentar un poco el timeout aquí por si el ID dinámico tarda en cargar.
wait_for_element(:xpath, aplicar, 10, "Filtros aplicados")
$driver.find_element(xpath: aplicar).click
sleep 2

#6 Obtener nombre y precio de los primeros 5 productos listados
puts "Extrayendo Nombre y Precio de los primeros 5 productos..."
#Identificar el contenwedor de los productos
contenedor = '//android.view.View[@resource-id="search_content"]'
componentList = "(//android.view.View[@resource-id='polycard_component'])"
wait_for_element(:xpath, contenedor, 10, "Contenedor Cargado")
sleep 2
nameProduct = "#{componentList}[1]//android.widget.TextView[1]"
priceProduct = "#{componentList}[1]//android.widget.TextView[@resource-id='current amount']"
wait_for_element(:xpath, nameProduct, 10, "Producto encontrado")
wait_for_element(:xpath, priceProduct, 10, "Costo encontrado")
puts "Primer producto: #{$driver.find_element(:xpath, nameProduct).text} - Precio : #{$driver.find_element(xpath: priceProduct).attribute('content-desc')}"
#========================================================================

# 4. Cerrar la sesión
$driver.quit