//
//  ViewController.swift
//  MyHoroscope
//
//  Created by Anastasio Del Toro Almansa on 05/05/2023.
//

import UIKit

class ViewController: UIViewController, SetUpDelegate {
    
    
    
    var selectedSign : String = ""
    
    @IBOutlet weak var signLabel: UILabel!
    @IBOutlet weak var signImage: UIImageView!
    
    
    
    func onSignReady(sign: String?) {
        
        //print("ENTRANDO EN onSignReady")
        if let value = sign
        {
            self.presentSign(sign:sign!)
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
            NetworkingProvider.shared.getPrediction(sign: sign) { (prediction) in
               
                self.presentPrediction(prediction: prediction)
                
            } failure: { (error) in
                    
            }
            
            
        } else {
          //  print("NO USER DEFAULTS")
            
            
             self.performSegue(withIdentifier: "setup", sender: self)
             
            
        }
        
    }
    
    
    
    
    @IBAction func clear(_ sender: Any) {
        
        UserDefaults.standard.removeObject(forKey: "sign")
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
    }
    
    func presentPrediction(prediction: Prediction){
        
        self.selectedSign = prediction.sign!
        self.signImage.image = UIImage(named: self.selectedSign.lowercased())
        self.signLabel.text = self.selectedSign
        
    }
    
    
    
    
    
    
    
}

protocol SetUpDelegate {
    
    func onSignReady(sign: String?) 
}


