//
//  Horoscope_Widget.swift
//  Horoscope Widget
//
//  Created by Anastasio Del Toro Almansa on 08/05/2023.
//

import WidgetKit
import SwiftUI
import Alamofire


struct Provider: TimelineProvider {
      
   
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<PredictionEntry>) -> Void) {
       
        var sign: String = "pisces" //PLACEHOLDER
        var signImage : UIImage = UIImage(named: "pisces")! //PLACEHOLDER
        var predictionDesc : String = "Click here to select your sign and start getting predictions."
        var entries: [PredictionEntry] = []
        
      if let UD = UserDefaults(suiteName: "group.com.tasioalmansa.horoscope")
    {
          if let signus = UD.string(forKey: "sign")
          {
             print("Signo recogido en el widget: \(signus)")
            sign = signus
            signImage = UIImage(named: sign.lowercased())!
            // predictionDesc = "Prediction placeholder for testing before API connect."
           
              getPrediction(sign: sign) { prediction in
                  predictionDesc = prediction.prediction!
                  
                  entries.append(PredictionEntry(date: Date().addingTimeInterval(10), image: signImage, sign: sign, prediction: predictionDesc))
                  completion(Timeline(entries: entries, policy: .atEnd))
                  print("Prediction recogida de API: \(predictionDesc)")
              } failure: { error in
                  print("ERROR ON LINE 41")
              }
            
              
          } else {
              print("No captura el UD")
              entries.append(PredictionEntry(date: Date().addingTimeInterval(10), image: signImage, sign: sign, prediction: predictionDesc))
              completion(Timeline(entries: entries, policy: .atEnd))
          }
      } else {
          entries.append(PredictionEntry(date: Date().addingTimeInterval(10), image: signImage, sign: sign, prediction: predictionDesc))
          completion(Timeline(entries: entries, policy: .atEnd))
      }
        
        
       
    }


    
   
    func placeholder(in context: Context) -> PredictionEntry {
        PredictionEntry(date: Date(), image: UIImage(named: "libra")!, sign: "Libra", prediction: "It seems Luck is on your side.")
    }
    
    func getSnapshot(in context: Context, completion: @escaping (PredictionEntry) -> Void) {
        
        let entry = PredictionEntry(date: Date(), image: UIImage(named: "libra")!, sign: "Libra", prediction: "It seems Luck is on your side.")
        completion(entry)
    }
}

struct PredictionEntry: TimelineEntry {
    let date: Date
    
    let image: UIImage
    let sign: String
    let prediction: String
    
}

struct Horoscope_WidgetEntryView : View {
    var entry: Provider.Entry

    
    
    var body: some View {
        
        VStack{
            HStack{
                Image(uiImage: entry.image)
                    .resizable()
                    .frame(width: 60,height: 60)
                    .clipShape(Circle())
                    //.padding()
            
                Text(entry.sign).font(.title).bold()
                    .padding()
            }
            HStack{
                Text(entry.prediction)
                    .font(.title3)
                    .padding([.leading,.trailing,.bottom], 5)
            }
        }
        
        
    }
}

struct Horoscope_Widget: Widget {
    let kind: String = "Horoscope_Widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            Horoscope_WidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Horoscope Widget")
        .description("Get your daily horoscope predictions.")
        .supportedFamilies([.systemMedium,.systemLarge])
    }
}

struct Horoscope_Widget_Previews: PreviewProvider {
    static var previews: some View {
        
        if let image = UIImage(named: "libra")
        {
            Horoscope_WidgetEntryView(entry: PredictionEntry(date: Date(),image: image,sign: "Libra", prediction:  "la suerte esta de tu lado"))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
        }
    }
}




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


func getPrediction(sign: String, success: @escaping(_ prediction: Prediction) -> (), failure: @escaping (_ error: Error?) -> ())
{
    
    
    /**********CONSTANTES DE CONEXION********************/
    
    let headers : HTTPHeaders = ["X-RapidAPI-Key": "74c7cd4a4fmshb095233f4a25564p19540bjsn4f9f4fe46316",
        "X-RapidAPI-Host": "horoscope34.p.rapidapi.com"]
    
    let kBase = "https://horoscope34.p.rapidapi.com/api/horoscope/today"
    /**********************************************************************/
    
    var prediction : Prediction = Prediction(sign: "", image: UIImage(named: "pisces"), prediction: "")
    
    let url = "\(kBase)"
    AF.request(url, method: .get,headers: headers).validate(statusCode: 200...299).responseDecodable  (of: Predictions.self) {
        response in
        
        if let predictions = response.value {
                           
            let predictionDescription = predictions.payload![sign]?.description
            
            prediction = Prediction(sign: sign, image: UIImage.init(named: sign.lowercased()), prediction: predictionDescription)
            success(prediction)
          
        } else {
            print(response.error?.responseCode ?? "No Error handled")
            failure(response.error)
        }
    }
    
    
    
}
