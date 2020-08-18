//
//  MusicService.swift
//  MusicApp
//
//  Created by Prabhdeep Singh on 17/08/20.
//  Copyright © 2020 Prabh. All rights reserved.
//

import Foundation

enum MusicServicErrors: Error {
    case noData
    case noResponse
    case invalidResponse
    case failedRequest
    case invalidData
    
}

class MusicService {
   static private let url = "https://run.mocky.io/v3/4b4ef6d4-3242-4b82-ab34-d9200f716a48"
    
    static func retrieveMusicData(completion: @escaping (MusicModel?,MusicServicErrors?) -> Void) {
        
        let serviceUrl = URL(string: url)
        let serviceRequest = URLRequest(url: serviceUrl!)
        
        URLSession.shared.dataTask(with: serviceRequest) { (data, response, error)
            in
            guard error == nil else {
                print("Some error occured in retrieving music data \(String(describing: error))")
                completion(nil, .failedRequest)
                return
            }
            
            guard let data = data else {
                print("No data retrieved from server")
                completion(nil, .noData)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Unable to process response")
                completion(nil,.invalidResponse)
                return
            }
            
            guard response.statusCode == 200 else {
                print("Failure response from server \(response.statusCode)")
                completion(nil, .failedRequest)
                return
            }
            
            do {
                let music = try JSONDecoder().decode(MusicModel.self, from: data)
                completion(music,nil)
            } catch {
                print("Error in decoding")
                completion(nil, .invalidData)
            }
            
        }.resume()
        
        
        
    }
}
