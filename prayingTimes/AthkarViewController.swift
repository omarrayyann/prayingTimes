

import UIKit
import CoreLocation
import Adhan
import Firebase
import FirebaseAnalytics
import GoogleMobileAds

class AthkarViewController: UIViewController, GADFullScreenContentDelegate {

    @IBOutlet weak var morningButton: UIButton!
    @IBOutlet weak var nightButton: UIButton!
    
    private var interstitial: GADInterstitialAd!

    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        if sender.currentTitle == "Morning Prayers" {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let launchingscreen = storyBoard.instantiateViewController(withIdentifier: "morning")
            launchingscreen.modalPresentationStyle = .fullScreen
            self.present(launchingscreen, animated: true, completion: nil)        }
        if sender.currentTitle == "Night Prayers" {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let launchingscreen = storyBoard.instantiateViewController(withIdentifier: "night")
            launchingscreen.modalPresentationStyle = .fullScreen
            self.present(launchingscreen, animated: true, completion: nil)        }
        
        
        
     
    }
    
    var opened = 0
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        morningButton.layer.cornerRadius = morningButton.frame.height / 5
        nightButton.layer.cornerRadius = nightButton
            .frame.height / 5
       
        

    }
    
    
  


        

        
        
        
      

    

}
