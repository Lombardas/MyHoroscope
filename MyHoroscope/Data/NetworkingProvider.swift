//
//  NetworkingProvider.swift
//  MyHoroscope
//
//  Created by Anastasio Del Toro Almansa on 07/05/2023.
//

import Foundation
import Alamofire
import UIKit

class NetworkingProvider {
    
    static let shared = NetworkingProvider()
    
    //CONEXION A RAPIDAPI/HOROSCOPE API
    let headers : HTTPHeaders = ["X-RapidAPI-Key": "74c7cd4a4fmshb095233f4a25564p19540bjsn4f9f4fe46316",
        "X-RapidAPI-Host": "horoscope34.p.rapidapi.com"]
    
    
    
    private let kBase = "https://horoscope34.p.rapidapi.com/api/horoscope/today"
    
    func getPrediction(sign: String, success: @escaping(_ prediction: Prediction) -> (), failure: @escaping (_ error: Error?) -> ())
    {
        
        var prediction : Prediction = Prediction(sign: "", image: UIImage(named: "pisces"), prediction: "")
        
        let url = "\(kBase)"
        AF.request(url, method: .get,headers: headers).validate(statusCode: 200...299).responseDecodable  (of: Predictions.self) {
            response in
            
            if let predictions = response.value {
                               
                //print(predictions)
                
                
                
                let predictionDescription = predictions.payload![sign]?.description
                print("Prediction recuperada del servidor para \(sign): \(String(describing: predictionDescription))")
                                
                
                
                prediction = Prediction(sign: sign, image: UIImage.init(named: sign.lowercased()), prediction: predictionDescription)
                success(prediction)
              
                
            } else {
                print(response.error?.responseCode ?? "No Error handled")
                failure(response.error)
            }
        }
        
        
        
    }
    
    
}
