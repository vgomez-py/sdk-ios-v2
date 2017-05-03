<a name="inicio"></a>
Decidir SDK IOS
===============

Modulo para conexión con gateway de pago DECIDIR2

+ [Introducción](#introduccion)
  + [Alcance](#scope)
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

<a name="introduccion"></a>
## Introducción
El flujo de una transacción a través de las **sdks** consta de dos pasos, la **generaci&oacute;n de un token de pago** por parte del cliente y el **procesamiento de pago** por parte del comercio. Existen sdks espec&iacute;ficas para realizar estas funciones en distintos lenguajes que se detallan a continuaci&oacute;n:

+ **Generaci&oacute;n de un token de pago.**  Se utiliza alguna de las siguentes **sdks front-end** :
 + [sdk IOS](https://github.com/decidir/SDK-IOS.v2)
 + [sdk Android](https://github.com/decidir/SDK-Android.v2)
 + [sdk Javascript](https://github.com/decidir/sdk-javascript-v2)
+ **Procesamiento de pago.**  Se utiliza alguna de las siguentes **sdks back-end** :
 + [sdk Java](https://github.com/decidir/SDK-JAVA.v2)
 + [sdk PHP](https://github.com/decidir/SDK-PHP.v2)
 + [sdk .Net](https://github.com/decidir/SDK-.NET.v2)
 + [sdk Node](https://github.com/decidir/SDK-.NODE.v2)

[<sub>Volver a inicio</sub>](#inicio)

<a name="scope"></a>
## Alcance
La **sdk IOS** provee soporte para su **aplicaci&oacute;n front-end**, encargandose de la **generaci&oacute;n de un token de pago** por parte de un cliente. Este **token** debe ser enviado al comercio al realizar el pago.
Esta sdk permite la comunicaci&oacute;n del cliente con la **API Decidir** utilizando su **API Key p&uacute;blica**<sup>1</sup>.

Para procesar el pago con **Decidir**, el comercio podr&acute; realizarlo a trav&eacute;s de alguna de las siguentes **sdks front-backend**:
+ [sdk Java](https://github.com/decidir/SDK-JAVA.v2)
+ [sdk PHP](https://github.com/decidir/SDK-PHP.v2)
+ [sdk .Net](https://github.com/decidir/SDK-.NET.v2)
+ [sdk Node](https://github.com/decidir/SDK-.NODE.v2)

![imagen de sdks](./docs/img/DiagramaSDKs.png)</br>

---
<sup>_1 - Las API Keys serán provistas por el equipo de Soporte de DECIDIR (soporte@decidir.com.ar). _</sup>

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
## Instalación
Se debe descargar la última versión del SDK desde el botón Download ZIP del branch master y utilzar alguna de las siguientes opciones: [CocoaPods](#cocoapods), [Carthage](#carthage) o [manualmente](#manual). 

Luego en su proyecto puede referenciar a la sdk agregando el siguiente import
```swift
import sdk_ios_v2
```
<a name="cocoapods"></a>
### Instalando con CocoaPods
Deber&aacute; tener instalado [CocoaPods](https://cocoapods.org/).

Una vez descargado y descomprimido el archivo zip, se debe generar la librer&iacute;a con el comando `pod lib lint` sobre la misma.
Debe agregar en el archivo _Podfile_ de su proyecto el siguiente c&oacute;digo. Si no posee un archivo _Podfile_, puede crearlo con el comando `pod init`.

```
target 'MiProyecto' do
  pod 'sdk_ios_v2', :path => <PATH_TO_SDK-IOS.v2>
end
```
Ahora instalara las dependecias en su proyecto con el comando `pod install`
<a name="carthage"></a>
### Instalando con Carthage
Deber&aacute; tener instalado [Carthage](https://github.com/Carthage/Carthage).

Una vez descargado y descomprimido el archivo zip, se debe generar la librer&iacute;a con el comando `carthage update` sobre la misma.
Luego en su proyecto **Xcode**, debe agregar el archivo `.framework` generado desde la carpeta [Carthage/Builds](https://github.com/Carthage/Carthage/blob/master/Documentation/Artifacts.md#carthagebuild).
Para m&aacute;s informaci&oacute;n consulte este [enlace](https://github.com/Carthage/Carthage).

<a name="manual"></a>
### Instalando manualmente
Puede importar el proyecto **Xcode** desde `sdk_ios_v2.xcworkspace` y buildearlo manualente.


[<sub>Volver a inicio</sub>](#inicio)

<a name="versionesdeiossoportadas"></a>
### Versiones de IOS soportadas
La versi&oacute;n implementada de la SDK, est&aacute; testeada para versiones desde IOS 8.0

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

```swift
// ...codigo...
  var publicKey: "e9cdb99fff374b5f91da4480c8dca741"
  //Instancia para comunicar con ambiente  de produccion (default) utilizando la API Key publica
  var decidir: PaymentsTokenAPI = PaymentsTokenAPI(publicKey: publicKey)
// ...codigo...
}
```

[<sub>Volver a inicio</sub>](#inicio)

<a name="operatoria"></a>

## Operatoria del Gateway

<a name="authenticate"></a>

### Generaci&oacute;n de Token de Pago

El SDK-IOS permite generar, desde el dispositivo, un token de pago con los datos de la tarjeta del cliente. &Eacute;ste se deber&aacute; enviar luego al backend del comercio para realizar la transacci&oacute;n de pago correpondiente.

El token de pago puede ser generado de 2 formas como se muestra a continuaci&oacute;n.

[<sub>Volver a inicio</sub>](#inicio)

<a name="datostarjeta"></a>

#### Con datos de tarjeta

Mediante este recurso, se genera un token de pago a partir de los datos de la tarjeta del cliente.

```swift
// ...codigo...
var publicKey: "e9cdb99fff374b5f91da4480c8dca741"
var decidir: PaymentsTokenAPI = PaymentsTokenAPI(publicKey: publicKey)
// ...codigo...
//Datos de tarjeta
let pti = PaymentTokenInfo()
pti.cardNumber = "4509790112684851" //Nro de tarjeta. MANDATORIO
pti.cardExpirationMonth = "03" //Mes de vencimiento [01-12]. MANDATORIO
pti.cardExpirationYear = "19" //Año de vencimiento[00-99]. MANDATORIO
pti.cardHolderName = "TITULAR" //Nombre del titular tal como aparece en la tarjeta. MANDATORIO
pti.securityCode = "123" // CVV. OPCIONAL

let holder = CardHolderIdentification() //Identificacion del titular de la tarjeta. Es opcional, pero debe estar completo si se agrega
holder.type = "dni" //MANDATORIO
holder.number = "12345678" //MANDATORIO

pti.cardHolderIdentification = holder //OPCIONAL

//generar token de pago
self.decidir.createPaymentToken(paymentTokenInfo: pti) { (paymentToken, error) in
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
  if let paymentToken: PaymentToken = paymentToken {
    //...codigo...
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
var decidir: PaymentsTokenAPI = PaymentsTokenAPI(publicKey: publicKey)
// ...codigo...
//Datos de tarjeta
let pti = PaymentTokenInfoWithCardToken()
pti.token = "f522e031-90cb-41ed-ba1f-46e813e8e789" //Tarjeta tokenizada MANDATORIO
pti.securityCode = "123" // CVV. OPCIONAL

//generar token de pago
self.decidir.createPaymentTokenWithCardToken(paymentTokenInfoWithCardToken: pti) { (paymentToken, error) in
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
  if let paymentToken: PaymentToken = paymentToken {
    //...codigo...
  }
}
```

[<sub>Volver a inicio</sub>](#inicio)


<a name="cybersource"></a>

## Integración con Cybersource

**No se encuentra disponible en este momento**

[<sub>Volver a inicio</sub>](#inicio)
