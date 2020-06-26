//
//  ConnectServer.swift
//  BBCBooks
//
//  Created by FreeBird on 3/17/20.
//  Copyright © 2020 BBCLearning. All rights reserved.
//

import Foundation

struct Wrapper<T: Decodable>: Decodable {
    let items: [T]
}
class ConnectServer {
    func load(url: URLRequest, withCompletion completion: @escaping (Data?)->()){
        let session = URLSession(configuration: .ephemeral, delegate: nil, delegateQueue: .main)
        let task = session.dataTask(with: url, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            guard let data = data else {
                completion(nil)
                return
            }
            completion(data)
        })
        task.resume()
    }
}
