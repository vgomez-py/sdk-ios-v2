<a name="inicio"></a>
Decidir SDK IOS
===============

Modulo para conexión con gateway de pago DECIDIR2

+ [Introducción](#introduccion)
  + [Alcance](#scope)
  + [Cierre de lotes](#cierre)
  + [Diagrama de secuencia](#secuencia)
+ [Instalación](#instalacion)
  + [Versiones de IOS soportadas](#versionesdeiosoportadas)
  + [Ambientes](#test)
+ [Uso](#uso)
  + [Inicializar la clase correspondiente al conector](#initconector)
  + [Operatoria del Gateway](#operatoria)
    + [Generaci&oacute;n de Token de Pago](#authenticate)
      +  [Con datos de tarjeta](#datostarjeta)
      +  [Con tarjeta tokenizada](#tokentarjeta)
  + [Integración con Cybersource](#cybersource)
      + [Device fingerprinter](#device)
  
<a name="introduccion"></a>
## Introducción
El flujo de una transacción a través de las **sdks** consta de dos pasos, la **generaci&oacute;n de un token de pago** por parte del cliente y el **procesamiento de pago** por parte del comercio. Existen sdks espec&iacute;ficas para realizar estas funciones en distintos lenguajes que se detallan a continuaci&oacute;n:

+ **Generaci&oacute;n de un token de pago.**  Se utiliza alguna de las siguentes **sdks front-end** :
  + [sdk IOS](https://github.com/decidir/sdk-ios-v2)
  + [sdk Android](https://github.com/decidir/sdk-android-v2)
  + [sdk Javascript](https://github.com/decidir/sdk-javascript-v2)
+ **Procesamiento de pago.**  Se utiliza alguna de las siguentes **sdks back-end** :
  + [sdk Java](https://github.com/decidir/sdk-java-v2)
  + [sdk PHP](https://github.com/decidir/sdk-php-v2)
  + [sdk .Net](https://github.com/decidir/sdk-.net-v2)
  + [sdk Node](https://github.com/decidir/sdk-node-v2)


[<sub>Volver a inicio</sub>](#inicio)

<a name="scope"></a>
## Alcance
La **sdk IOS** provee soporte para su **aplicaci&oacute;n front-end**, encargandose de la **generaci&oacute;n de un token de pago** por parte de un cliente. Este **token** debe ser enviado al comercio al realizar el pago.
Esta sdk permite la comunicaci&oacute;n del cliente con la **API Decidir** utilizando su **API Key p&uacute;blica**<sup>1</sup>.

Para procesar el pago con **Decidir**, el comercio podr&acute; realizarlo a trav&eacute;s de alguna de las siguentes **sdks front-backend**:
+ [sdk Java](https://github.com/decidir/sdk-java-v2)
+ [sdk PHP](https://github.com/decidir/sdk-php-v2)
+ [sdk .Net](https://github.com/decidir/sdk-.net-v2)
+ [sdk Node](https://github.com/decidir/sdk-node-v2)


![imagen de sdks](./docs/img/DiagramaSDKs.png)

---
<sup>_1 - Las API Keys serán provistas por el equipo de Soporte de DECIDIR (soporte@decidir.com.ar). _</sup>

[<sub>Volver a inicio</sub>](#inicio)

<a name="cierre"></a>
## Cierre de lotes
El cierre de lote le permite al comercio hacer la presentación ante cada Marca de las operaciones de Compras, Anulaciones y Devoluciones realizadas para que las mismas puedan ser liquidadas por cada medio de pago.+

Los cierres de lotes de cada medio de pago pueden realizarse de 2 maneras:
Manual: esta modalidad es “on demand”. Para ello, un usuario del comercio debe ingresar a la consola de Decidir y seleccionar el medio de pago a cerrar lote. Opción de menú: Menú --> Cerrar Lote. Para más detalle por favor consultar el Manual de Administración de Decidir.
Automática: Los procesos se ejecutan diariamente luego de la medianoche, y al finalizar, se envían al comercio cada uno de los archivos del cierre de lote de cada medio de pago habilitado.
Los resúmenes correspondientes a los cierres de lotes automáticos efectuados pueden ser enviados por:
- E-MAIL
- FTP/SFTP

En caso de que el comercio opte por recibir los resúmenes vía e-mail, debe indicarnos a qué dirección o direcciones de correo electrónico desea recibir tales archivos.
En caso de que el comercio opte por recibir los resúmenes vía FTP o SFTP, debe indicarnos los siguientes datos: URL del servidor, usuario y clave.

Para mas informacion consultar en :
https://decidir.api-docs.io/1.0/introduccion/cierre-de-lote


[<sub>Volver a inicio</sub>](#inicio)
<a name="secuencia"></a>

## Diagrama de secuencia
El flujo de una transacción a través de las **sdks** consta de dos pasos, a saber:

1. **sdk front-end:** Se realiza una solicitud de token de pago con la Llave de Acceso pública (public API Key), enviando los datos sensibles de la tarjeta (PAN, mes y año de expiración, código de seguridad, titular, y tipo y número de documento) y obteniéndose como resultado un token que permitirá realizar la transacción posterior.

2. **sdk back-end:** Se ejecuta el pago con la Llave de Acceso privada (private API Key), enviando el token generado en el Paso 1 más el identificador de la transacción a nivel comercio, el monto total, la moneda y la cantidad de cuotas.

A continuación, se presenta un diagrama con el Flujo de un Pago.

![imagen de configuracion](./docs/img/FlujoPago.png)</br>

[<sub>Volver a inicio</sub>](#inicio)

<a name="instalacion"></a>
## Instalacion

### CocoaPods

[CocoaPods](https://cocoapods.org) es un manejador de dependencias para proyectos Cocoa. Puedes instalarlo con los siguientes comandos:

```bash
$ gem install cocoapods
```

> CocoaPods 1.5.3+ es requerido para construir sdk-ios 2.1.0

Para integrar sdk-ios-v2 en tu proyecto Xcode usando CocoaPods, especificalo en tu `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'sdk_ios_v2', :git => 'https://github.com/decidir/sdk-ios-v2.git'
end
```

Luego, corre el siguiente comando:

```bash
$ pod install
```

<a name="manual"></a>
### Instalando manualmente
Puede importar el proyecto **Xcode** desde `sdk_ios_v2.xcworkspace` y buildearlo manualente.

<a name="cybersource"></a>
### Cybersource version
Fingerprinting Mobile SDK v5.0.32.

<a name="versionesdeiossoportadas"></a>
### Versiones de IOS soportadas
La versi&oacute;n implementada de la SDK, est&aacute; testeada para versiones desde IOS 9.0

[<sub>Volver a inicio</sub>](#inicio)

<a name="test"></a>

## Ambientes

La **sdk IOS** permite trabajar con los ambientes de Sandbox y Producc&oacute;n de Decidir.
El ambiente se debe instanciar indicando si se utiliza sandbox o producci&oacute;n.

```swift
import sdk_ios_v2

open class MiClase {
  var publicKey: "e9cdb99fff374b5f91da4480c8dca741"
  //Instancia para comunicar con ambiente Sandbox
  var decidirSandbox: PaymentsTokenAPI = PaymentsTokenAPI(publicKey: publicKey, isSandbox: true)
  //Instancia para comunicar con ambiente  de produccion
  var decidirProduccion: PaymentsTokenAPI = PaymentsTokenAPI(publicKey: publicKey) //Se puede omitir el parametro isSandbox o enviar el aEl ambiente se debe instanciar indicando su URL.rgumento false
// ...codigo...
}
```
[<sub>Volver a inicio</sub>](#inicio)

<a name="uso"></a>
## Uso

<a name="initconector"></a>
### Inicializar la clase correspondiente al conector.

Instanciación de la clase `PaymentsTokenAPI`

La misma recibe como parámetros la API Key p&uacute;blica provista por Decidir para el comercio y si trabajar&aacute; con el ambiente de Sandbox.

La API Key será provista por el equipo de Soporte de DECIDIR (soporte@decidir.com.ar).

A partir de ahora y por el resto de la documentaci&oacute;n, se ejemplificar&aacute; utilizando una APIKey habilitada para operar en el ambiente Sandbox.


```swift
// ...codigo...
var publicKey: "e9cdb99fff374b5f91da4480c8dca741"
//Instancia para comunicar con ambiente Sandbox
var decidir: PaymentsTokenAPI = PaymentsTokenAPI(publicKey: publicKey, isSandbox: true)
// ...codigo...
}
```

[<sub>Volver a inicio</sub>](#inicio)

<a name="operatoria"></a>

## Operatoria del Gateway

<a name="authenticate"></a>

### Generaci&oacute;n de Token de Pago

El sdk IOS permite generar, desde el dispositivo, un token de pago con los datos de la tarjeta del cliente. &Eacute;ste se deber&aacute; enviar luego al backend del comercio para realizar la transacci&oacute;n de pago correpondiente.

El token de pago puede ser generado de 2 formas como se muestra a continuaci&oacute;n.

[<sub>Volver a inicio</sub>](#inicio)

<a name="datostarjeta"></a>

#### Con datos de tarjeta

Mediante este recurso, se genera un token de pago a partir de los datos de la tarjeta del cliente.

|Campo | Descripcion  | Oblig | Restricciones  |Ejemplo   |
| ------------ | ------------ | ------------ | ------------ | ------------ |
| card_number| numero de tc  | SI  |  Mayor igual a 6 numeros   | "4507990000004905"  |
| card_expiration_month | mes de vto de tc  | SI  | No debe ser anterior a la fecha (mes/año) del dia actual  | 07  |
| card_expiration_year  |año de vto de tc   | SI  |  No debe ser anterior a la fecha (mes/año) del dia actual   | 17  |
| security_code | codigo de seguridad  | NO  | Sin validacion  | 234  |
| card_holder_name | titular (como figura en la tc)  | SI  | Mayor igual a 1 letra  | Valentin Santiago Gomez  |
| type  |  tipo de documento | NO  | Sin validacion  | dni/DNI, cuil/CUIL  |
| number  | nro de documento  | NO  |  Sin validacion | 23968498  |
| device_unique_identifier  | identificador único del dispositivo  | NO  |  Sin validacion | 12345  |

```swift
// ...codigo...
var publicKey: "e9cdb99fff374b5f91da4480c8dca741"
//Instancia para comunicar con ambiente Sandbox
var decidir: PaymentsTokenAPI = PaymentsTokenAPI(publicKey: publicKey, isSandbox: true)
// ...codigo...
//Datos de tarjeta
let pt = PaymentToken()
pt.cardNumber = "4507990000004905" //Nro de tarjeta. MANDATORIO
pt.cardExpirationMonth = "03" //Mes de vencimiento [01-12]. MANDATORIO
pt.cardExpirationYear = "19" //Año de vencimiento[00-99]. MANDATORIO
pt.cardHolderName = "TITULAR" //Nombre del titular tal como aparece en la tarjeta. MANDATORIO
pt.securityCode = "123" // CVV. OPCIONAL

let holder = CardHolderIdentification() //Identificacion del titular de la tarjeta. Es opcional, pero debe estar completo si se agrega
holder.type = "dni" //MANDATORIO
holder.number = "12345678" //MANDATORIO

pt.cardHolderIdentification = holder //OPCIONAL

//generar token de pago
self.decidir.createPaymentToken(paymentToken: pt) { (paymentTokenResponse, error) in
   //Manejo de error general
  guard error == nil else {
      if case let ErrorResponse.Error(_, _, dec as ModelError) = error! {
        // Manejo de error especifico de Decidir
          //..codigo...
      }
      //...codigo...
      return
  }
  // Procesamiento de respuesta de la generacion de token de pago
  if let paymentTokenResponse = paymentTokenResponse {
    //...codigo...
    //Token de pago se encuentra en paymentTokenResponse.id
  }
}
```

[<sub>Volver a inicio</sub>](#inicio)

<a name="tokentarjeta"></a>

#### Con tarjeta tokenizada

Mediante este recurso, se genera una token de pago a partir una tarjeta tokenizada previamente.

```swift
// ...codigo...
var publicKey: "e9cdb99fff374b5f91da4480c8dca741"
//Instancia para comunicar con ambiente Sandbox
var decidir: PaymentsTokenAPI = PaymentsTokenAPI(publicKey: publicKey, isSandbox: true)
// ...codigo...
//Datos de tarjeta
let pct = PaymentCardToken()
pct.token = "ae9fc3e5-ff41-4de2-9c91-81030be1c4a6" //Tarjeta tokenizada MANDATORIO
pct.securityCode = "123" // CVV. OPCIONAL

//generar token de pago
self.decidir.createPaymentCardToken(paymentCardToken: pct) { (paymentTokenResponse, error) in
   //Manejo de error general
  guard error == nil else {
      if case let ErrorResponse.Error(_, _, dec as ModelError) = error! {
        // Manejo de error especifico de Decidir
          //..codigo...
      }
      //...codigo...
      return
  }
  // Procesamiento de respuesta de la generacion de token de pago
  if let paymentTokenResponse = paymentTokenResponse {
    //...codigo...
    //Token de pago se encuentra en paymentTokenResponse.id
  }
}
```

[<sub>Volver a inicio</sub>](#inicio)


<a name="cybersource"></a>

## Integración con Cybersource

> **IMPORTANTE:** Para usar `Cybersource` es necesario modificar la configuración del proyecto. Seleccionar el/los target/s correspondiente/s y en `Build Settings` agregar a `Framework Search Paths` una nueva entrada con el texto `$PODS_ROOT/sdk_ios_v2`.

Para habilitar el Servicio de Control de Fraude Cybersource, la vista inicial de su aplicaci&oacute;n deber&aacute; extenderla de `CyberSourceDelegate`. Luego al finalizar la carga de su vista, invocar&aacute; a CyberSource con su public APIKey y se le devolver&aacute; un **sessionId** correspondiente al dispositivo. Este **sessionId** debe enviarse a Decidir al momento de generar un token de pago.

A continuaci&oacute;n se ejemplifica la integraci&oacute;n en la vista.
```swift
import UIKit
import sdk_ios_v2

class HomeViewController: UIViewController, CyberSourceDelegate {

    var cyberSource:CyberSource?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.cyberSource = CyberSource()
        self.cyberSource?.delegate = self
        self.cyberSource?.auth(publicKey: "e9cdb99fff374b5f91da4480c8dca741")
        // Do any additional setup after loading the view.
    }


    func authFinished(sessionId: String) {
      NSLog("Session id created: %s", sessionId)
      // Funcion callback que devuelve el sessionId
      // A continuacion debe almacenar este campo para enviarlo al generar un token de pago
      //...codigo...
    }
  //...codigo...
}
```

Luego debe agregar `sessionId` dentro de `FraudDetection` y generar el token de pago

```swift
// ...codigo...
var publicKey: "e9cdb99fff374b5f91da4480c8dca741"
var sessionId: String // debe asignarle el sessionId retornado por CyberSource
//Instancia para comunicar con ambiente Sandbox
var decidir: PaymentsTokenAPI = PaymentsTokenAPI(publicKey: publicKey, isSandbox: true)
// ...codigo...
//Datos de tarjeta
let pct = PaymentCardToken()
pct.token = "ae9fc3e5-ff41-4de2-9c91-81030be1c4a6" //Tarjeta tokenizada MANDATORIO
pct.securityCode = "123" // CVV. OPCIONAL
//SessionId para integracion con CyberSource
let fd = FraudDetection()
fd.deviceUniqueIdentifier = sessionId
pct.fraudDetection = fd

//generar token de pago
self.decidir.createPaymentCardToken(paymentCardToken: pct) { (paymentToken, error) in
   //Manejo de error general
  guard error == nil else {
      if case let ErrorResponse.Error(_, _, dec as ModelError) = error! {
        // Manejo de error especifico de Decidir
          //..codigo...
      }
      //...codigo...
      return
  }
  // Procesamiento de respuesta de la generacion de token de pago
  if let paymentTokenResponse = C {
    //...codigo...
    //Token de pago se encuentra en paymentTokenResponse.id
  }
}
```
[<sub>Volver a inicio</sub>](#inicio)
<a name="device"></a>

## Device FingerPrint
El **Device Fingerprint (DF)** es la huella digital del dispositivo que realiza la transacción. 
Es un dato muy importante que se tiene en cuenta en el proceso de validación
Para acceder a la documentación: 
https://decidir.api-docs.io/1.0/prevencion-de-fraude-by-cybersource/cs_device_fingerprint


[<sub>Volver a inicio</sub>](#inicio)

