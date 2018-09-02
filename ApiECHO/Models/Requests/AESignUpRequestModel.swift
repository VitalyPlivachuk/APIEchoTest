//
//  AESignUpRequestModel.swift
//  ApiECHO
//
//  Created by Vitaly Plivachuk on 8/30/18.
//  Copyright © 2018 Vitaly Plivachuk. All rights reserved.
//

public class AESignUpRequestModel: Codable, AERequestModel{
    
    public init(name:String, email:String, password:String) {
        self.name = name
        self.email = email
        self.password = password
    }
    
    let name:String
    public let email:String
    public let password:String
}
