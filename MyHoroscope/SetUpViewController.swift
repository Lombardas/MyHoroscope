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
               sign = "Aries"
            UserDefaults.standard.setValue("Aries", forKey: "sign")
        case 2:
            sign = "Taurus"
            UserDefaults.standard.setValue("Taurus", forKey: "sign")
        case 3:
            sign = "Gemini"
            UserDefaults.standard.setValue("Gemini", forKey: "sign")
        case 4:
            sign = "Cancer"
            UserDefaults.standard.setValue("Cancer", forKey: "sign")
        case 5:
            sign = "Leo"
            UserDefaults.standard.setValue("Leo", forKey: "sign")
        case 6:
            sign = "Virgo"
            UserDefaults.standard.setValue("Virgo", forKey: "sign")
        case 7:
            sign = "Libra"
            UserDefaults.standard.setValue("Libra", forKey: "sign")
        case 8:
            sign = "Scorpio"
            UserDefaults.standard.setValue("Scorpio", forKey: "sign")
        case 9:
            sign = "Sagittarius"
            UserDefaults.standard.setValue("Sagittarius", forKey: "sign")
        case 10:
            sign = "Capricorn"
            UserDefaults.standard.setValue("Capricorn", forKey: "sign")
        case 11:
            sign = "Aquarius"
            UserDefaults.standard.setValue("Aquarius", forKey: "sign")
        case 12:
            sign = "Pisces"
            UserDefaults.standard.setValue("Pisces", forKey: "sign")
        default:
            break
        }
       // print("ENTRANDO DESPUES SIGN SELECTION: \(sign)")
        self.delegate?.onSignReady(sign: sign)
        self.dismiss(animated: true)
        
        
        
    }
}
