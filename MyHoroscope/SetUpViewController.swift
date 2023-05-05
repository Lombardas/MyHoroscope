//
//  SetUpViewController.swift
//  MyHoroscope
//
//  Created by Anastasio Del Toro Almansa on 05/05/2023.
//

import UIKit

class SetUpViewController: UIViewController {

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
        
        
        switch tag {
        case 1:
                print("ARIES")
            UserDefaults.standard.setValue("ARIES", forKey: "sign")
        case 2:
                print("TAURUS")
            UserDefaults.standard.setValue("TAURUS", forKey: "sign")
        case 3:
                print("GEMINI")
            UserDefaults.standard.setValue("GEMINI", forKey: "sign")
        case 4:
                print("CANCER")
            UserDefaults.standard.setValue("CANCER", forKey: "sign")
        case 5:
                print("LEO")
            UserDefaults.standard.setValue("LEO", forKey: "sign")
        case 6:
                print("VIRGO")
            UserDefaults.standard.setValue("VIRGO", forKey: "sign")
        case 7:
                print("LIBRA")
            UserDefaults.standard.setValue("LIBRA", forKey: "sign")
        case 8:
                print("SCORPIO")
            UserDefaults.standard.setValue("SCORPIO", forKey: "sign")
        case 9:
                print("SAGITTARIUS")
            UserDefaults.standard.setValue("SAGITTARIUS", forKey: "sign")
        case 10:
                print("CAPRICORN")
            UserDefaults.standard.setValue("CAPRICORN", forKey: "sign")
        case 11:
                print("AQUARIUS")
            UserDefaults.standard.setValue("AQUARIUS", forKey: "sign")
        case 12:
                print("PISCES")
            UserDefaults.standard.setValue("PISCES", forKey: "sign")
        default:
            break
        }
        
    }
}
