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
            self.selectedSign = value
            self.signImage.image = UIImage(named: self.selectedSign.lowercased())
            self.signLabel.text = self.selectedSign
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
            self.selectedSign = sign
            self.signImage.image = UIImage(named: self.selectedSign.lowercased())
            self.signLabel.text = self.selectedSign
            
            
            //NETWORKING LAYER
            NetworkingProvider.shared.getPrediction(id: 1440233)
            
            
            
            
            
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
    
    
}

protocol SetUpDelegate {
    
    func onSignReady(sign: String?) 
}


