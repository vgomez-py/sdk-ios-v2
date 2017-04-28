// Models.swift
//


import Foundation

protocol JSONEncodable {
    func encodeToJSON() -> Any
}

public enum ErrorResponse : Error {
    case Error(Int, Data?, Error)
}


open class Response<T> {
    open let statusCode: Int
    open let header: [String: String]
    open let body: T?

    public init(statusCode: Int, header: [String: String], body: T?) {
        self.statusCode = statusCode
        self.header = header
        self.body = body
    }

    public convenience init(response: HTTPURLResponse, body: T?) {
        let rawHeader = response.allHeaderFields
        var header = [String:String]()
        for (key, value) in rawHeader {
            header[key as! String] = value as? String
        }
        self.init(statusCode: response.statusCode, header: header, body: body)
    }
}

private var once = Int()
class Decoders {
    static fileprivate var decoders = Dictionary<String, ((AnyObject) -> AnyObject)>()

    static func addDecoder<T>(clazz: T.Type, decoder: @escaping ((AnyObject) -> T)) {
        let key = "\(T.self)"
        decoders[key] = { decoder($0) as AnyObject }
    }

    static func decode<T>(clazz: T.Type, discriminator: String, source: AnyObject) -> T {
        let key = discriminator;
        if let decoder = decoders[key] {
            return decoder(source) as! T
        } else {
            fatalError("Source \(source) is not convertible to type \(clazz): Maybe swagger file is insufficient")
        }
    }

    static func decode<T>(clazz: [T].Type, source: AnyObject) -> [T] {
        let array = source as! [AnyObject]
        return array.map { Decoders.decode(clazz: T.self, source: $0) }
    }

    static func decode<T, Key: Hashable>(clazz: [Key:T].Type, source: AnyObject) -> [Key:T] {
        let sourceDictionary = source as! [Key: AnyObject]
        var dictionary = [Key:T]()
        for (key, value) in sourceDictionary {
            dictionary[key] = Decoders.decode(clazz: T.self, source: value)
        }
        return dictionary
    }

    static func decode<T>(clazz: T.Type, source: AnyObject) -> T {
        initialize()
        /*if T.self is Int32.Type && source is NSNumber {
            return source.int32Value as! T;
        }*/
        if T.self is Int64.Type && source is NSNumber {
            return source.int64Value as! T;
        }
        if T.self is UUID.Type && source is String {
            return UUID(uuidString: source as! String) as! T
        }
        if source is T {
            return source as! T
        }
        if T.self is Data.Type && source is String {
            return Data(base64Encoded: source as! String) as! T
        }

        let key = "\(T.self)"
        if let decoder = decoders[key] {
           return decoder(source) as! T
        } else {
            fatalError("Source \(source) is not convertible to type \(clazz): Maybe swagger file is insufficient")
        }
    }

    static func decodeOptional<T>(clazz: T.Type, source: AnyObject?) -> T? {
        if source is NSNull {
            return nil
        }
        return source.map { (source: AnyObject) -> T in
            Decoders.decode(clazz: clazz, source: source)
        }
    }

    static func decodeOptional<T>(clazz: [T].Type, source: AnyObject?) -> [T]? {
        if source is NSNull {
            return nil
        }
        return source.map { (someSource: AnyObject) -> [T] in
            Decoders.decode(clazz: clazz, source: someSource)
        }
    }

    static func decodeOptional<T, Key: Hashable>(clazz: [Key:T].Type, source: AnyObject?) -> [Key:T]? {
        if source is NSNull {
            return nil
        }
        return source.map { (someSource: AnyObject) -> [Key:T] in
            Decoders.decode(clazz: clazz, source: someSource)
        }
    }

    private static var __once: () = {
        let formatters = [
            "yyyy-MM-dd",
            "yyyy-MM-dd'T'HH:mm:ssZZZZZ",
            "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ",
            "yyyy-MM-dd'T'HH:mm:ss'Z'",
            "yyyy-MM-dd'T'HH:mm:ss.SSS",
            "yyyy-MM-dd HH:mm:ss"
        ].map { (format: String) -> DateFormatter in
            let formatter = DateFormatter()
            formatter.dateFormat = format
            return formatter
        }
        // Decoder for Date
        Decoders.addDecoder(clazz: Date.self) { (source: AnyObject) -> Date in
           if let sourceString = source as? String {
                for formatter in formatters {
                    if let date = formatter.date(from: sourceString) {
                        return date
                    }
                }
            }
            if let sourceInt = source as? Int64 {
                // treat as a java date
                return Date(timeIntervalSince1970: Double(sourceInt / 1000) )
            }
            fatalError("formatter failed to parse \(source)")
        } 

        // Decoder for [CardHolder]
        Decoders.addDecoder(clazz: [CardHolder].self) { (source: AnyObject) -> [CardHolder] in
            return Decoders.decode(clazz: [CardHolder].self, source: source)
        }
        // Decoder for CardHolder
        Decoders.addDecoder(clazz: CardHolder.self) { (source: AnyObject) -> CardHolder in
            let sourceDictionary = source as! [AnyHashable: Any]

            let instance = CardHolder()
            instance.name = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["name"] as AnyObject?)
            instance.identification = Decoders.decodeOptional(clazz: CardHolderIdentification.self, source: sourceDictionary["identification"] as AnyObject?)
            return instance
        }


        // Decoder for [CardHolderIdentification]
        Decoders.addDecoder(clazz: [CardHolderIdentification].self) { (source: AnyObject) -> [CardHolderIdentification] in
            return Decoders.decode(clazz: [CardHolderIdentification].self, source: source)
        }
        // Decoder for CardHolderIdentification
        Decoders.addDecoder(clazz: CardHolderIdentification.self) { (source: AnyObject) -> CardHolderIdentification in
            let sourceDictionary = source as! [AnyHashable: Any]

            let instance = CardHolderIdentification()
            instance.type = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["type"] as AnyObject?)
            instance.number = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["number"] as AnyObject?)
            return instance
        }


        // Decoder for [FraudDetaction]
        Decoders.addDecoder(clazz: [FraudDetaction].self) { (source: AnyObject) -> [FraudDetaction] in
            return Decoders.decode(clazz: [FraudDetaction].self, source: source)
        }
        // Decoder for FraudDetaction
        Decoders.addDecoder(clazz: FraudDetaction.self) { (source: AnyObject) -> FraudDetaction in
            let sourceDictionary = source as! [AnyHashable: Any]

            let instance = FraudDetaction()
            instance.deviceUniqueIdentifier = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["device_unique_identifier"] as AnyObject?)
            return instance
        }


        // Decoder for [ModelError]
        Decoders.addDecoder(clazz: [ModelError].self) { (source: AnyObject) -> [ModelError] in
            return Decoders.decode(clazz: [ModelError].self, source: source)
        }
        // Decoder for ModelError
        Decoders.addDecoder(clazz: ModelError.self) { (source: AnyObject) -> ModelError in
            let sourceDictionary = source as! [AnyHashable: Any]

            let instance = ModelError()
            instance.errorType = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["error_type"] as AnyObject?)
            instance.validationErrors = Decoders.decodeOptional(clazz: Array.self, source: sourceDictionary["validation_errors"] as AnyObject?)
            instance.status = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["status"] as AnyObject?)
            return instance
        }


        // Decoder for [PaymentToken]
        Decoders.addDecoder(clazz: [PaymentToken].self) { (source: AnyObject) -> [PaymentToken] in
            return Decoders.decode(clazz: [PaymentToken].self, source: source)
        }
        // Decoder for PaymentToken
        Decoders.addDecoder(clazz: PaymentToken.self) { (source: AnyObject) -> PaymentToken in
            let sourceDictionary = source as! [AnyHashable: Any]

            let instance = PaymentToken()
            instance.id = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["id"] as AnyObject?)
            instance.status = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["status"] as AnyObject?)
            instance.cardNumberLength = Decoders.decodeOptional(clazz: Double.self, source: sourceDictionary["card_number_length"] as AnyObject?)
            instance.dateCreated = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["date_created"] as AnyObject?)
            instance.bin = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["bin"] as AnyObject?)
            instance.lastFourDigits = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["last_four_digits"] as AnyObject?)
            instance.securityCodeLength = Decoders.decodeOptional(clazz: Double.self, source: sourceDictionary["security_code_length"] as AnyObject?)
            instance.expirationMonth = Decoders.decodeOptional(clazz: Double.self, source: sourceDictionary["expiration_month"] as AnyObject?)
            instance.expirationYear = Decoders.decodeOptional(clazz: Double.self, source: sourceDictionary["expiration_year"] as AnyObject?)
            instance.dateDue = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["date_due"] as AnyObject?)
            instance.cardholder = Decoders.decodeOptional(clazz: CardHolder.self, source: sourceDictionary["cardholder"] as AnyObject?)
            return instance
        }


        // Decoder for [PaymentTokenInfo]
        Decoders.addDecoder(clazz: [PaymentTokenInfo].self) { (source: AnyObject) -> [PaymentTokenInfo] in
            return Decoders.decode(clazz: [PaymentTokenInfo].self, source: source)
        }
        // Decoder for PaymentTokenInfo
        Decoders.addDecoder(clazz: PaymentTokenInfo.self) { (source: AnyObject) -> PaymentTokenInfo in
            let sourceDictionary = source as! [AnyHashable: Any]

            let instance = PaymentTokenInfo()
            instance.cardNumber = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["card_number"] as AnyObject?)
            instance.cardExpirationMonth = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["card_expiration_month"] as AnyObject?)
            instance.cardExpirationYear = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["card_expiration_year"] as AnyObject?)
            instance.securityCode = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["security_code"] as AnyObject?)
            instance.cardHolderName = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["card_holder_name"] as AnyObject?)
            instance.cardHolderIdentification = Decoders.decodeOptional(clazz: CardHolderIdentification.self, source: sourceDictionary["card_holder_identification"] as AnyObject?)
            instance.fraudDetection = Decoders.decodeOptional(clazz: FraudDetaction.self, source: sourceDictionary["fraud_detection"] as AnyObject?)
            return instance
        }
        
        // Decoder for [PaymentTokenInfoWithCardToken]
        Decoders.addDecoder(clazz: [PaymentTokenInfoWithCardToken].self) { (source: AnyObject) -> [PaymentTokenInfoWithCardToken] in
            return Decoders.decode(clazz: [PaymentTokenInfoWithCardToken].self, source: source)
        }
        // Decoder for PaymentTokenInfoWithCardToken
        Decoders.addDecoder(clazz: PaymentTokenInfoWithCardToken.self) { (source: AnyObject) -> PaymentTokenInfoWithCardToken in
            let sourceDictionary = source as! [AnyHashable: Any]
            
            let instance = PaymentTokenInfoWithCardToken()
            instance.token = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["token"] as AnyObject?)
            instance.securityCode = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["security_code"] as AnyObject?)
            instance.fraudDetection = Decoders.decodeOptional(clazz: FraudDetaction.self, source: sourceDictionary["fraud_detection"] as AnyObject?)
            return instance
        }


        // Decoder for [ValidationError]
        Decoders.addDecoder(clazz: [ValidationError].self) { (source: AnyObject) -> [ValidationError] in
            return Decoders.decode(clazz: [ValidationError].self, source: source)
        }
        // Decoder for ValidationError
        Decoders.addDecoder(clazz: ValidationError.self) { (source: AnyObject) -> ValidationError in
            let sourceDictionary = source as! [AnyHashable: Any]

            let instance = ValidationError()
            instance.code = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["code"] as AnyObject?)
            instance.param = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["param"] as AnyObject?)
            return instance
        }
    }()

    static fileprivate func initialize() {
        _ = Decoders.__once
    }
}
