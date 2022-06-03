//
//  NetworkProtocol.swift
//  Meanings
//
//  Created by 1964058 on 02/06/22.
//

import Foundation

protocol NetworkSession {
    typealias Handler = (Data?, URLResponse?, Error?) -> Void
    func loadData(from url:URL, completion: @escaping Handler)
}

extension URLSession:NetworkSession {
    typealias Handler = NetworkSession.Handler
    
    func loadData(from url: URL, completion: @escaping Handler) {
        let task = dataTask(with: url, completionHandler: completion)
        task.resume()
    }
}
