//
//  Collection+Safe.swift
//  ApiECHO
//
//  Created by Vitaly Plivachuk on 8/31/18.
//  Copyright © 2018 Vitaly Plivachuk. All rights reserved.
//

extension Collection{
    public subscript (safe index: Index) -> Element?{
        return indices.contains(index) ? self[index] : nil
    }
}
