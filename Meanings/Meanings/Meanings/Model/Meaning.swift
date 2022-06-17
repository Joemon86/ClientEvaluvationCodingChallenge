//
//  Meaning.swift
//  Meanings
//
//  Created by 1964058 on 02/06/22.
//

import Foundation

struct Meaning : Decodable {
    let sf:String
    let lfs:[lfs]?
}

struct lfs:Decodable {
    let lf:String
    let freq:Int64
    let since:Int64
    
}


