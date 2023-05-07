//
//  NetworkingProvider.swift
//  MyHoroscope
//
//  Created by Anastasio Del Toro Almansa on 07/05/2023.
//

import Foundation
import Alamofire

class NetworkingProvider {
    
    static let shared = NetworkingProvider()
    private let kBase = "https://gorest.co.in/public/v2/users/"
    
    func getPrediction(id: Int)
    {
        
        let url = "\(kBase)\(id)"
        AF.request(url, method: .get).validate(statusCode: 200...299).responseDecodable  (of: Prediction.self) {
            response in
            
            if let prediction = response.value {
                print(prediction)
            } else {
                print(response.error?.responseCode ?? "No Error handled")
            }
        }
        
        
        
    }
    
    
}
