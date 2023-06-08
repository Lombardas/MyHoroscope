//
//  ViewController.swift
//  MyHoroscope
//  Predictions: Horoscope Widget
//  Created by Anastasio Del Toro Almansa on 05/05/2023.
//

import UIKit
import WidgetKit

class ViewController: UIViewController, SetUpDelegate {
    
    
    
    var selectedSign : String = ""
    
    @IBOutlet weak var signLabel: UILabel!
    @IBOutlet weak var signImage: UIImageView!
    @IBOutlet weak var labelPrediction: UILabel!
    
    @IBOutlet weak var signbutton: UIButton!
    
    func onSignReady(sign: String?) {
        
        //print("ENTRANDO EN onSignReady")
        if let value = sign
        {
            self.presentSign(sign:value)
            self.GetPrediction(sign: value)
            WidgetCenter.shared.reloadAllTimelines()
        }
        
        
    }
    
    
    public var hola : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //  self.performSegue(withIdentifier: "setup", sender: self)
        //UserDefaults.standard.string(forKey: "sign")
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
       // print("ACCION DE VIEW DID APPEAR")
        if let sign = UserDefaults.standard.string(forKey: "sign") {
           // print("SIGNO RECUPERADO FROM USERDEFAULTS: " + sign)
            presentSign(sign: sign)
            //NETWORKING LAYER
            GetPrediction(sign: sign)
            
            
        } else {
          //  print("NO USER DEFAULTS")
            
            
             self.performSegue(withIdentifier: "setup", sender: self)
             
            
        }
        
        WidgetCenter.shared.reloadAllTimelines()
        
    }
    
    
    
    
    @IBAction func clear(_ sender: Any) {
        
        UserDefaults.standard.removeObject(forKey: "sign")
        self.performSegue(withIdentifier: "setup", sender: self)
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "setup" {
            let vc2 = segue.destination as! SetUpViewController
            vc2.delegate = self
            
        }
    }
    
    
    func presentSign(sign: String)
    {
        self.selectedSign = sign
        self.signImage.image = UIImage(named: self.selectedSign.lowercased())
        self.signLabel.text = self.selectedSign
        self.labelPrediction.text = "loading your daily prediction..."
    }
    
    func presentPrediction(prediction: Prediction){
        
        self.selectedSign = prediction.sign!
        self.signImage.image = UIImage(named: self.selectedSign.lowercased())
        self.signLabel.text = self.selectedSign
        self.labelPrediction.text = prediction.prediction
        print("PresentPrediction: \(prediction.prediction)")
    }
    
    func GetPrediction(sign: String) {
        
        
        NetworkingProvider.shared.getPrediction(sign: sign) { (prediction) in
            
            self.presentPrediction(prediction: prediction)
            
        } failure: { (error) in
            
        }
        
        
    }
    
    
    
    
}

protocol SetUpDelegate {
    
    func onSignReady(sign: String?) 
}


