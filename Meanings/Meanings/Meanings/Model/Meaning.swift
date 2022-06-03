//
//  Meaning.swift
//  Meanings
//
//  Created by 1964058 on 02/06/22.
//

import Foundation

/*
 
 "sf":"HMM",
       "lfs":[
          {
             "lf":"heavy meromyosin",
             "freq":267,
             "since":1971,
             "vars":[
                {
                   "lf":"heavy meromyosin",
                   "freq":244,
                   "since":1971
 */

struct Meaning : Decodable {
    let sf:String
    let lfs:[lfs]?
    
    /*enum CodingKeys : String, CodingKey {
            case sf = "sf"
            case lfs
        
        }*/
}

struct lfs:Decodable {
    let lf:String
    let freq:Int64
    let since:Int64
    
    /*enum CodingKeys : String, CodingKey {
        case lf = "lf"
        case freq = "freq"
        case since = "since"
    }*/
    
}


