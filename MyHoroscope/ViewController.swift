//
//  ViewController.swift
//  MyHoroscope
//  Predictions: Horoscope Widget
//  Created by Anastasio Del Toro Almansa on 05/05/2023.
//

import UIKit
import WidgetKit
import GoogleMobileAds

class ViewController: UIViewController, SetUpDelegate, GADBannerViewDelegate, GADFullScreenContentDelegate {
    // *****GOOGLE ADS********
    var bannerView: GADBannerView!
    private var interstitial: GADInterstitialAd?
    //*************************
    
    
    var selectedSign : String = ""
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
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
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        //  self.performSegue(withIdentifier: "setup", sender: self)
        //UserDefaults.standard.string(forKey: "sign")
        if let sign = UserDefaults.standard.string(forKey: "sign") {
            // print("SIGNO RECUPERADO FROM USERDEFAULTS: " + sign)
            presentSign(sign: sign)
            //NETWORKING LAYER
            GetPrediction(sign: sign)
        }
        
        signImage.layer.cornerRadius = 42
        signImage.clipsToBounds = true
        
        
        // GOOGLE ADS
        // In this case, we instantiate the banner with desired ad size.
       // bannerView.delegate = self
           bannerView = GADBannerView(adSize: GADAdSizeBanner)

           addBannerViewToView(bannerView)
            bannerView.adUnitID = "ca-app-pub-2455578915080406/6666022993"
            bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
        
        
       loadInterstitial()
        
        
    }
    
    
    func loadInterstitial() {
        
        //Interstatial
        let request = GADRequest()
            GADInterstitialAd.load(withAdUnitID: "ca-app-pub-2455578915080406/7787532979",
                                        request: request,
                              completionHandler: { [self] ad, error in
                                if let error = error {
                                  print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                                  return
                                }
                                interstitial = ad
                                interstitial?.fullScreenContentDelegate = self
                              }
            )
        
        
        
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
        
        if interstitial != nil {
            interstitial!.present(fromRootViewController: self)
          } else {
            print("Ad wasn't ready")
          }
        
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
        activityIndicator.stopAnimating()
    }
    
    func GetPrediction(sign: String) {
        
        
        NetworkingProvider.shared.getPrediction(sign: sign) { (prediction) in
            
            self.presentPrediction(prediction: prediction)
            
        } failure: { (error) in
            
        }
        
        
    }
    
    
    // TAG: GOOGLE ADS
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
          [NSLayoutConstraint(item: bannerView,
                              attribute: .bottom,
                              relatedBy: .equal,
                              toItem: view.safeAreaLayoutGuide,
                              attribute: .bottom,
                              multiplier: 1,
                              constant: 0),
           NSLayoutConstraint(item: bannerView,
                              attribute: .centerX,
                              relatedBy: .equal,
                              toItem: view,
                              attribute: .centerX,
                              multiplier: 1,
                              constant: 0)
          ])
       }//END addBannerViewToView
       
    
    
    
    
    
}

protocol SetUpDelegate {
    
    func onSignReady(sign: String?) 
}


