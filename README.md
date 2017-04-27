<a name="inicio"></a>
Decidir SDK IOS
===============

Modulo para conexión con gateway de pago DECIDIR2

+ [Instalación](#instalacion)
  + [Versiones de IOS soportadas](#versionesdeiosoportadas)
  + [Manual de Integración](#manualintegracion)
  + [Ambientes](#test)
+ [Uso](#uso)
  + [Inicializar la clase correspondiente al conector](#initconector)
  + [Operatoria del Gateway](#operatoria)
    + [Generaci&oacute;n de Token de Pago](#authenticate)
      +  [Con datos de tarjeta](#datostarjeta)
      +  [Con tarjeta tokenizada](#tokentarjeta)
  + [Integración con Cybersource](#cybersource)


<a name="instalacion"></a>
## Instalación
Se debe descargar la última versión del SDK desde el botón Download ZIP del branch master.
Deber&aacute; tener instalado [CocoaPods](https://cocoapods.org/).

Una vez descargado y descomprimido, se debe generar la librer$iacute;a con el comando `pod lib lint` sobre la misma.
Debe agregar en el archivo _Podfile_ de su proyecto el siguiente c&oacute;digo. Si no posee un archivo _Podfile_, puede crearlo con el comando `pod init`.

```
target 'MiProyecto' do
  pod 'sdk_ios_v2', :path => <PATH_TO_SDK-IOS.v2>
end
```
Ahora instalara las dependecias en su proyecto con el comando `pod install`

Luego en su proyecto puede referenciar a la sdk agregando el siguiente import
```swift
import sdk_ios_v2
```

<a name="versionesdeandroidsoportadas"></a>
### Versiones de IOS soportadas
La versi&oacute;n implementada de la SDK, est&aacute; testeada para versiones desde IOS 8.0
[<sub>Volver a inicio</sub>](#inicio)

<a name="manualintegracion"></a>

## Manual de Integración

Se encuentra disponible en Gitbook el **[Manual de Integración Decidir2] (https://decidir.api-docs.io/1.0/guia-de-inicio/)** para su consulta online, en este detalla el proceso de integración. En el mismo se explican los servicios y operaciones disponibles, con ejemplos de requerimientos y respuestas, aquí solo se ejemplificará la forma de llamar a los distintos servicios usando la presente SDK.

[<sub>Volver a inicio</sub>](#inicio)

<a name="test"></a>

## Ambientes

El SDK-IOS permite trabajar con todos los ambientes de Decidir.
El ambiente se debe instanciar indicando si se utiliza sandbox o producci&oacute;n.

```swift
import sdk_ios_v2

open class MiClase {
  var publicKey: "e9cdb99fff374b5f91da4480c8dca741"
  //Instancia para comunicar con ambiente Sandbox
  var decidirSandbox: PaymentsTokenAPI = PaymentsTokenAPI(publicKey: publicKey, isSandbox: true)
  //Instancia para comunicar con ambiente  de produccion
  var decidirProduccion: PaymentsTokenAPI = PaymentsTokenAPI(publicKey: publicKey) //Se puede omitir el parametro isSandbox o enviar el argumento false
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
