//
//  APIManager.swift
//  Meanings
//
//  Created by 1964058 on 02/06/22.
//

import Foundation

enum Result {
    case data(Data)
    case error(Error)
}

class APIManager {
    
    private let session:NetworkSession
    
    init(session:NetworkSession = URLSession.shared) {
        self.session = session
    }
    
    func loadData(from url:URL, completionHandler: @escaping (Result)->Void) {
        session.loadData(from: url) { data, _, error in
            if let error = error {
                completionHandler(.error(error))
            }
            completionHandler(.data(data ?? Data()))
        }
    }
}
