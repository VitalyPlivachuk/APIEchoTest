//
//  String+SeparatedBy.swift
//  ApiECHO
//
//  Created by Vitaly Plivachuk on 8/30/18.
//  Copyright © 2018 Vitaly Plivachuk. All rights reserved.
//

extension String{
    static func separatedBy(separator:String, elements:String...) ->String {
        return elements.joined(separator: separator)
    }
}
