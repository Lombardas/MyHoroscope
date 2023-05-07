//
//  SetUpViewController.swift
//  MyHoroscope
//
//  Created by Anastasio Del Toro Almansa on 05/05/2023.
//

import UIKit

class SetUpViewController: UIViewController {

    
    var delegate : SetUpDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func signSelection(_ sender: Any) {
        
        guard let tag = (sender as? UIButton)?.tag else { return }
        var sign: String = ""
        
        switch tag {
        case 1:
               sign = "ARIES"
            UserDefaults.standard.setValue("ARIES", forKey: "sign")
        case 2:
            sign = "TAURUS"
            UserDefaults.standard.setValue("TAURUS", forKey: "sign")
        case 3:
            sign = "GEMINI"
            UserDefaults.standard.setValue("GEMINI", forKey: "sign")
        case 4:
            sign = "CANCER"
            UserDefaults.standard.setValue("CANCER", forKey: "sign")
        case 5:
            sign = "LEO"
            UserDefaults.standard.setValue("LEO", forKey: "sign")
        case 6:
            sign = "VIRGO"
            UserDefaults.standard.setValue("VIRGO", forKey: "sign")
        case 7:
            sign = "LIBRA"
            UserDefaults.standard.setValue("LIBRA", forKey: "sign")
        case 8:
            sign = "SCORPIO"
            UserDefaults.standard.setValue("SCORPIO", forKey: "sign")
        case 9:
            sign = "SAGITTARIUS"
            UserDefaults.standard.setValue("SAGITTARIUS", forKey: "sign")
        case 10:
            sign = "CAPRICORN"
            UserDefaults.standard.setValue("CAPRICORN", forKey: "sign")
        case 11:
            sign = "AQUARIUS"
            UserDefaults.standard.setValue("AQUARIUS", forKey: "sign")
        case 12:
            sign = "PISCES"
            UserDefaults.standard.setValue("PISCES", forKey: "sign")
        default:
            break
        }
       // print("ENTRANDO DESPUES SIGN SELECTION: \(sign)")
        self.delegate?.onSignReady(sign: sign)
        self.dismiss(animated: true)
        
        
        
    }
}
