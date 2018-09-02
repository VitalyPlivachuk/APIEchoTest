//
//  Networking.swift
//  JatAppTest
//
//  Created by Vitaly Plivachuk on 9/1/18.
//  Copyright © 2018 Vitaly Plivachuk. All rights reserved.
//

import Foundation
import ApiECHO
import RxSwift

class Networking{
    private init() {
    }
    
    enum NetworkingError:Error{
        case unknown
    }
    
    static let shared = Networking()
    
    var loggedIn: Variable<Bool> = Variable(false)
    
    let aeNetworking = AENetworking(sessionConfiguration: URLSessionConfiguration.default)
    
    func getText() -> Observable<String>{
        return .create{[unowned self] observer in
            do{
                let url = try self.aeNetworking.createUrl(for: .text)
                self.aeNetworking
                    .get(String.self,
                         url: url) { result, error in
                            if let error  = error {
                                observer.onError(error)
                            } else if let result = result {
                                observer.onNext(result)
                                observer.onCompleted()
                            } else {
                                observer.onError(NetworkingError.unknown)
                            }
                }
            } catch let error{
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
    func signUp(email:String, password:String, name:String) -> Observable<AEUserModel>{
        return .create{[unowned self] observer in
            do{
                let model = AESignUpRequestModel(name: name, email: email, password: password)
                let url = try self.aeNetworking.createUrl(for: .signup)
                self.aeNetworking
                    .post(model,
                          respType: AEUserModel.self,
                          url: url,
                          completion: { result, error in
                            if let error = error {
                                observer.onError(error)
                            } else if let user = result{
                                self.aeNetworking.configureAuth(with: user)
                                self.loggedIn.value = true
                                observer.onNext(user)
                                observer.onCompleted()
                            } else {
                                observer.onError(NetworkingError.unknown)
                            }
                    })
            } catch let error {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
    func login(email:String, password:String) -> Observable<AEUserModel> {
        return .create{[unowned self] observer in
            do{
                let model = AELoginRequestModel(email: email, password: password)
                let url = try self.aeNetworking.createUrl(for: .login)
                self.aeNetworking
                    .post(model,
                          respType: AEUserModel.self,
                          url: url){response, error in
                            if let error = error {
                                observer.onError(error)
                            } else if let user = response{
                                self.aeNetworking.configureAuth(with: user)
                                self.loggedIn.value = true
                                observer.onNext(user)
                                observer.onCompleted()
                            } else {
                                observer.onError(NetworkingError.unknown)
                            }
                }
            } catch let error{
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
}
