//
//  Horoscope_Widget.swift
//  Horoscope Widget
//
//  Created by Anastasio Del Toro Almansa on 08/05/2023.
//

import WidgetKit
import SwiftUI




struct Provider: TimelineProvider {
    
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<PredictionEntry>) -> Void) {
       
        var sign: String = "pisces"
        var signImage : UIImage = UIImage(named: "pisces")!
        var prediction : String = "Some error ocurred, please re-install app and try again."
        
      if let mySign = UserDefaults.standard.string(forKey: "sign")
        {
          sign = mySign
          print("Captura de userDefaults: \(sign)")
      }
        signImage = UIImage(named: sign.lowercased())!
          prediction = "Prediction placeholder for testing."
          
      
        var entries: [PredictionEntry] = []
        
        entries.append(PredictionEntry(date: Date().addingTimeInterval(10), image: signImage, sign: sign, prediction: prediction))
        
        
        completion(Timeline(entries: entries, policy: .atEnd))
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
                    //.padding()
            
                Text(entry.sign).font(.title).bold()
                    .padding()
            }
            HStack{
                Text(entry.prediction)
                    .font(.title2)
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