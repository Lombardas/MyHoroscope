//
//  ViewController.swift
//  MyHoroscope
//
//  Created by Anastasio Del Toro Almansa on 05/05/2023.
//

import UIKit

class ViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
      //  self.performSegue(withIdentifier: "setup", sender: self)
        //UserDefaults.standard.string(forKey: "sign")
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if let sign = UserDefaults.standard.string(forKey: "sign") {
           print("SIGNO RECUPERADO FROM USERDEFAULTS: " + sign)
            
        } else {
            print("NO USER DEFAULTS")
            self.performSegue(withIdentifier: "setup", sender: self)
        }
        
    }
    
    
    @IBAction func clear(_ sender: Any) {
        
        UserDefaults.standard.removeObject(forKey: "sign")
    }
}

