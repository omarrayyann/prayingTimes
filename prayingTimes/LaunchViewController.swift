//
//  LaunchViewController.swift
//  prayingTimes
//
//  Created by Omar Rayyan on 14/03/2021.
//

import UIKit
import CoreLocation
import Adhan

class LaunchViewController: UIViewController {

    @IBOutlet weak var skipLabel: UILabel!
    
    
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var getLocationButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        getLocationButton.layer.cornerRadius = getLocationButton.frame.height / 5

        skipLabel.attributedText = NSAttributedString(string: "skip for now", attributes:
            [.underlineStyle: NSUnderlineStyle.single.rawValue])
    }
    var locationManager = CLLocationManager()

    @IBAction func locationButton(_ sender: Any) {
        locationManager.requestWhenInUseAuthorization()

    }
    
    var timer = Timer()
    
    @IBAction func continuePressed(_ sender: Any) {
        UserDefaults.standard.setValue(true, forKey: "got")
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let launchingscreen = storyBoard.instantiateViewController(withIdentifier: "tabs")
        launchingscreen.modalPresentationStyle = .fullScreen
        self.present(launchingscreen,animated: false, completion: nil)
    }
    

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            
            
            if((CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
                CLLocationManager.authorizationStatus() == .authorizedAlways || CLLocationManager.authorizationStatus() == .authorized) || UserDefaults.standard.object(forKey: "currentLocLat") != nil) || UserDefaults.standard.bool(forKey: "got") == true{
                timer.invalidate()
                UserDefaults.standard.setValue(true, forKey: "got")
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let launchingscreen = storyBoard.instantiateViewController(withIdentifier: "tabs")
                launchingscreen.modalPresentationStyle = .fullScreen
                self.present(launchingscreen,animated: false, completion: nil)

            }
            
            if CLLocationManager.authorizationStatus() == .denied {
                self.errorLabel.isHidden = false
                
            }
            
        }
        
        
        
    }
        }
    
   
