//
//  AESignUpResponseModel.swift
//  ApiECHO
//
//  Created by Vitaly Plivachuk on 8/30/18.
//  Copyright © 2018 Vitaly Plivachuk. All rights reserved.
//

public class AEUserModel: AEResponseModel{
    let uid:Int
    let name:String
    let email:String
    let token:String
    let role:Int
    let status:Int
    let created:Int
    let updated:Int
    
    enum CodingKeys: String, CodingKey{
        case uid = "uid"
        case name = "name"
        case email = "email"
        case token = "access_token"
        case role = "role"
        case status = "status"
        case created = "created_at"
        case updated = "updated_at"
    }
}
