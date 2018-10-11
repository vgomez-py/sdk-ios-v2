//
//  sdkTests.swift
//  sdk_ios_v2
//
//  Created by Maxi on 4/28/17.
//  Copyright © 2017 Prisma Medios de Pago. All rights reserved.
//

import Foundation
import sdk_ios_v2
import Quick
import Nimble

class SDKTests: QuickSpec {
    override func spec() {
        describe("tests for decidir 2.0 API") {
            
            it("when payment data is ok") {
                
                let paymentTokenApi = PaymentsTokenAPI(publicKey: "e9cdb99fff374b5f91da4480c8dca741", isSandbox: true)
                
                let pti = PaymentToken()
                pti.cardNumber = "44213211231"
                pti.cardExpirationMonth = "12"
                pti.cardExpirationYear = "20"
                pti.cardHolderName = "OSCAR CAMPOS"
                pti.securityCode = "123"
                
                let holder = CardHolderIdentification()
                holder.type = "dni"
                holder.number = "123123123"
                
                pti.cardHolderIdentification = holder
                
                let fraudDetection = FraudDetection()
                fraudDetection.deviceUniqueIdentifier = "12345";
                pti.fraudDetection = fraudDetection
                
                paymentTokenApi.createPaymentToken(paymentToken: pti) { (paymentToken, error) in
                    
                    expect(error).to(beNil())
                    
                    if let paymentToken = paymentToken {
                        
                        expect(paymentToken.id) != ""
                    }
                }
                
                waitUntil { done in
                    Thread.sleep(forTimeInterval: 0.5)
                    done()
                }
                
                
            }
            
            
            it("when payment data is ok") {
                
                let paymentTokenApi = PaymentsTokenAPI(publicKey: "e9cdb99fff374b5f91da4480c8dca741", isSandbox: true)
                
                let pti = PaymentToken()
                pti.cardNumber = "44213211231"
                pti.cardExpirationMonth = "12"
                pti.cardExpirationYear = "20"
                pti.cardHolderName = "OSCAR CAMPOS"
                pti.securityCode = "123"
                
                let holder = CardHolderIdentification()
                holder.type = "dni"
                holder.number = "123123123"
                
                pti.cardHolderIdentification = holder
                
                let fraudDetection = FraudDetection()
                fraudDetection.deviceUniqueIdentifier = "12345";
                pti.fraudDetection = fraudDetection
                
                paymentTokenApi.createPaymentToken(paymentToken: pti) { (paymentToken, error) in
                    
                    expect(error).to(beNil())
                    
                    if let paymentToken = paymentToken {
                        
                        expect(paymentToken.id) != ""
                    }
                }
                
                waitUntil { done in
                    Thread.sleep(forTimeInterval: 0.5)
                    done()
                }
                
                
            }
            
            it("when apiKey is wrong") {
                
                let paymentTokenApi = PaymentsTokenAPI(publicKey: "e9cdb99fff374b5f91da4480c8dca741")
                
                let pti = PaymentToken()
                pti.cardNumber = "44213211231"
                pti.cardExpirationMonth = "12"
                pti.cardExpirationYear = "20"
                pti.cardHolderName = "OSCAR CAMPOS"
                pti.securityCode = "123"
                
                let holder = CardHolderIdentification()
                holder.type = "dni"
                holder.number = "123123123"
                
                pti.cardHolderIdentification = holder
                
                paymentTokenApi.createPaymentToken(paymentToken: pti) { (paymentToken, error) in
                    
                    expect(paymentToken).to(beNil())
                    
                    guard error == nil else {
                        
                        if case let ErrorResponse.Error(statusCode, _, _) = error! {
                            
                            expect(403) == statusCode
                            
                        }
                        
                        return
                    }
                }
                
                waitUntil { done in
                    Thread.sleep(forTimeInterval: 0.5)
                    done()
                }
                
            }
            
            it("when cardNumer is expired") {
                
                let paymentTokenApi = PaymentsTokenAPI(publicKey: "e9cdb99fff374b5f91da4480c8dca741", isSandbox: true)
                
                let pti = PaymentToken()
                pti.cardNumber = "44213211231"
                pti.cardExpirationMonth = "12"
                pti.cardExpirationYear = "12"
                pti.cardHolderName = "OSCAR CAMPOS"
                pti.securityCode = "123"
                
                let holder = CardHolderIdentification()
                holder.type = "dni"
                holder.number = "123123123"
                
                pti.cardHolderIdentification = holder
                
                let fraudDetection = FraudDetection()
                fraudDetection.deviceUniqueIdentifier = "12345";
                pti.fraudDetection = fraudDetection
                
                paymentTokenApi.createPaymentToken(paymentToken: pti) { (paymentToken, error) in
                    
                    expect(paymentToken).to(beNil())
                    
                    guard error == nil else {
                        
                        if case let ErrorResponse.Error(_, _, dec as ModelError) = error! {
                            
                            expect("invalid_request_error") == dec.errorType
                            
                            expect(dec.validationErrors?.count) == 1
                            
                            let validationError = dec.validationErrors?.popLast()
                            
                            expect(validationError?.code) == "CardData"
                            expect(validationError?.param) == "expired card"
                            
                        }
                        
                        return
                    }
                }
                
                waitUntil { done in
                    Thread.sleep(forTimeInterval: 0.5)
                    done()
                }
                
            }
            
            it("when create payment with wrong card token") {
                
                let paymentTokenApi = PaymentsTokenAPI(publicKey: "e9cdb99fff374b5f91da4480c8dca741", isSandbox: true)
                
                let pti = PaymentCardToken()
                pti.token = "someToken"
                pti.securityCode = "123"
                
                        let fraudDetection = FraudDetection()
                        fraudDetection.deviceUniqueIdentifier = "12345";
                       pti.fraudDetection = fraudDetection
                
                paymentTokenApi.createPaymentCardToken(paymentCardToken: pti) { (paymentToken, error) in
                    
                    expect(paymentToken).to(beNil())
                    
                    guard error == nil else {
                        
                        if case let ErrorResponse.Error(_, _, dec as ModelError) = error! {
                            
                            expect("invalid_request_error") == dec.errorType
                            
                            expect(dec.validationErrors?.count) == 1
                            
                            let validationError = dec.validationErrors?.popLast()
                            
                            expect(validationError?.code) == "invalid_param"
                            expect(validationError?.param) == "token"
                            
                        }
                        
                        return
                    }
                }
                
                waitUntil { done in
                    Thread.sleep(forTimeInterval: 0.5)
                    done()
                }
                
            }
            
        }
    }
}

