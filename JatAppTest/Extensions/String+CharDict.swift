//
//  String+CharDict.swift
//  JatAppTest
//
//  Created by Vitaly Plivachuk on 8/31/18.
//  Copyright © 2018 Vitaly Plivachuk. All rights reserved.
//

extension String{
    var charDict: [Character:Int]{
        var dict: [Character:Int] = [:]
        self.forEach{
            if let count = dict[$0]{
                dict[$0] = count + 1
            } else {
                dict[$0] = 0
            }
        }
        return dict
    }
}
