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
                print("Prediction recuperada del servidor para Aries: \(String(describing: predictionDescription))")
                /*
                switch sign {
                case "ARIES":
                    
                    let predictionDescription = predictions.payload!["Aries"]?.description
                    print("Prediction recuperada del servidor para Aries: \(predictionDescription)")
               /* case "TAURUS":
                case "GEMINI":
                case "CANCER":
                case "LEO":
                case "VIRGO":
                case "LIBRA":
                case "SCORPIO":
                case "SAGITTARIUS":
                case "CAPRICORN":
                case "AQUARIUS":
                case "PISCES":*/
                default:
                    break
                }*/
                
                
                
                prediction = Prediction(sign: "Pisces", image: UIImage.init(named: "pisces"), prediction: "Predigo que vas a conseguir trabajo de programador")
                success(prediction)
              //
                
            } else {
                print(response.error?.responseCode ?? "No Error handled")
                failure(response.error)
            }
        }
        
        
        
    }
    
    
}
