//
//  Prediction.swift
//  MyHoroscope
//
//  Created by Anastasio Del Toro Almansa on 07/05/2023.
//

import Foundation
import UIKit
import SwiftUI

struct Prediction{
    
    let sign: String?
    //let date: Date?
   let image: UIImage?
   let prediction: String?
    
}


struct Predictions : Decodable {
    let success: Bool?
    let payload : [String:String]?
}

//{
//   "id":1440233,
//   "name":"Amaresh Gowda",
//   "email":"gowda_amaresh@satterfield.test",
//   "gender":"male",
//   "status":"active"
//}
