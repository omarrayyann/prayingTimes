//
//  ViewController.swift
//  prayer
//
//  Created by Omar Rayyan on 14/03/2021.
//

import UIKit
import CoreLocation
import Adhan
import Firebase
import FirebaseAnalytics
import GoogleMobileAds


class ViewController: UIViewController, GADFullScreenContentDelegate {
    @IBOutlet weak var tillNext: UILabel!
    @IBOutlet weak var locationServiceError: UILabel!
    @IBOutlet weak var prayersTimes: UIStackView!
    @IBOutlet weak var turnOnLocation: UIButton!
    
    private var interstitial: GADInterstitialAd!

    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        
 
    }
    @IBOutlet weak var turnOnLocationButton: UIButton!
    @IBOutlet weak var turnOnLocationLabel: UILabel!
    

    

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        var todayDaters = todayDate?.dayBefore
        

        if defaults.string(forKey: "noto") == nil {
            defaults.setValue("car", forKey: "noto")
        }
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            if Manager.shared.change == true {
                Manager.shared.change = false
                self.loadTimes(todayDates: self.currentTodayDate!, date: self.currentDatess!)
            }
        }
        
    
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            if self.defaults.string(forKey: "\(self.todayDate!)\(UserDefaults.standard.string(forKey: "calcMethod")!)\(UserDefaults.standard.string(forKey: "madhab")!)") != nil {
                
                // forKey: "\(todayDates)\(UserDefaults.standard.string(forKey: "calcMethod")!)\(UserDefaults.standard.string(forKey: "madhab")!)"
                
            
                let tillFajir = self.convertTo24AndDifference(date: self.defaults.string(forKey: "fajir\(self.todayDate!)\(UserDefaults.standard.string(forKey: "calcMethod")!)\(UserDefaults.standard.string(forKey: "madhab")!)")!)
                
                let tillSunrise = self.convertTo24AndDifference(date: self.defaults.string(forKey: "sunrise\(self.todayDate!)\(UserDefaults.standard.string(forKey: "calcMethod")!)\(UserDefaults.standard.string(forKey: "madhab")!)")!)
                
            let tillDhuhr = self.convertTo24AndDifference(date: self.defaults.string(forKey: "dhur\(self.todayDate!)\(UserDefaults.standard.string(forKey: "calcMethod")!)\(UserDefaults.standard.string(forKey: "madhab")!)")!)
                
            let tillAsr = self.convertTo24AndDifference(date: self.defaults.string(forKey: "asr\(self.todayDate!)\(UserDefaults.standard.string(forKey: "calcMethod")!)\(UserDefaults.standard.string(forKey: "madhab")!)")!)
                
            let tillMaghrib = self.convertTo24AndDifference(date: self.defaults.string(forKey: "maghrib\(self.todayDate!)\(UserDefaults.standard.string(forKey: "calcMethod")!)\(UserDefaults.standard.string(forKey: "madhab")!)")!)
                
            let tillIsha = self.convertTo24AndDifference(date: self.defaults.string(forKey: "isha\(self.todayDate!)\(UserDefaults.standard.string(forKey: "calcMethod")!)\(UserDefaults.standard.string(forKey: "madhab")!)")!)
            
//                print("tillFajir\(tillFajir)")
//                print("tillDhuhr\(tillDhuhr)")
//                print("tillAsr\(tillAsr)")
//                print("tillMaghrib\(tillMaghrib)")
//                print("tillIsha\(tillIsha)")
               
              let dayel = [tillFajir, tillSunrise, tillDhuhr, tillAsr, tillMaghrib, tillIsha]
                
                if dayel.min() != 99.0 {
                    var doubled = dayel.min()!
                    var current = Array(String(doubled))
                    if current[1] == "." {
                        let hours = "0\(current[0])"
                        doubled = doubled - Double(Int(hours)!)
                        let minutes = "\(doubled*60)"
                        
                        if doubled*60 >= 10{
                        let showedTime = "\(hours):\(minutes.prefix(2))"
                            self.tillNext.text = "Time until next prayer: \(showedTime)"}

                        else{
                            let showedTime = "\(hours):0\(minutes.prefix(1))"
                            self.tillNext.text = "Time until next prayer: \(showedTime)"

                        }


                    }
                }
               
                
                
            }
        
        
        }
    }
    
    
    func convertTo24AndDifference(date: String) -> Double{
        let daterNow = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let dateNow = dateFormatter.string(from: daterNow)
//        print("NOW\(dateNow)")
        
        let dateAsString = date
        dateFormatter.dateFormat = "h:mm a"

        let dater = dateFormatter.date(from: dateAsString)
        dateFormatter.dateFormat = "HH:mm"

        let DateSalah = dateFormatter.string(from: dater!)
       
//        print("SALAH\(DateSalah)")
        
        let arrayNow = Array(dateNow)
        let arraySalah = Array(DateSalah)
        
        let hours = Int("\(arraySalah[0])\(arraySalah[1])")! - Int("\(arrayNow[0])\(arrayNow[1])")!
        
        let minutes = Int("\(arraySalah[3])\(arraySalah[4])")! - Int("\(arrayNow[3])\(arrayNow[4])")!
            
        let total: Double = Double(hours) + (Double(minutes)/60)
        
        if total>0
        {
            return total
        }
        else{
            return 99.0
        }

        
        
    }
    
    
    
    @IBOutlet weak var leftWidth: NSLayoutConstraint!
    @IBOutlet weak var rightWidth: NSLayoutConstraint!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var fajirTime: UILabel!
    @IBOutlet weak var dhuhrTime: UILabel!
    @IBOutlet weak var asrTime: UILabel!
    @IBOutlet weak var maghribTime: UILabel!
    @IBOutlet weak var ishaTime: UILabel!
    @IBOutlet weak var sunRiseTime: UILabel!
    
    let defaults = UserDefaults.standard
    
    var locationManager = CLLocationManager()

    func getCoordinateFrom(address: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> () ) {
        CLGeocoder().geocodeAddressString(address) { completion($0?.first?.location?.coordinate, $1) }
    }
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBAction func turnLocationButton(_ sender: Any) {
        locationManager.requestWhenInUseAuthorization()

        
    }
    
    @IBAction func buttonRightPressed(_ sender: Any) {
        currentTodayDate = currentTodayDate!.dayAfter
        currentDatess = calss!.dateComponents([.year, .month, .day], from: currentTodayDate!)
        loadTimes(todayDates: currentTodayDate!, date: currentDatess!)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM d"
        //OR dateFormatter.dateFormat = "EEEE, MMMM dd, yyyy"
        let currentDateString: String = dateFormatter.string(from: currentTodayDate!)

        

        
    }
    @IBAction func buttonLeftPressed(_ sender: Any) {
        currentTodayDate = currentTodayDate!.dayBefore
        currentDatess = calss!.dateComponents([.year, .month, .day], from: currentTodayDate!)
        loadTimes(todayDates: currentTodayDate!, date: currentDatess!)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM d"
        //OR dateFormatter.dateFormat = "EEEE, MMMM dd, yyyy"
        let currentDateString: String = dateFormatter.string(from: currentTodayDate!)

    }
    var currentLoc: CLLocation!

    
    
    
    
    func loadTimes(todayDates: Date, date: DateComponents){
//                             self.defaults.setValue(currentDay, forKey: "\(city)\(dateOther)")

        if UserDefaults.standard.string(forKey: "madhab") == nil {
            UserDefaults.standard.setValue("Shafi", forKey: "madhab")
        }
        if UserDefaults.standard.string(forKey: "calcMethod") == nil {
            UserDefaults.standard.setValue("Karachi", forKey: "calcMethod")
        }
        done = false
        if currentLoc != nil || (defaults.object(forKey: "currentLocLong") != nil && defaults.object(forKey: "currentLocLat") != nil )
        {   turnOnLocationLabel.isHidden = true
            turnOnLocationButton.isHidden = true
            locationServiceError.isHidden = true
            prayersTimes.isHidden = false
            
            
            bobo = true
            if defaults.string(forKey: "currentLocLong") != nil && defaults.string(forKey: "currentLocLat") != nil {
                currentLoc = CLLocation(latitude: defaults.double(forKey: "currentLocLat"), longitude: defaults.double(forKey: "currentLocLong"))
            }
            else{
                defaults.setValue(currentLoc.coordinate.longitude, forKey: "currentLocLong")
                defaults.setValue(currentLoc.coordinate.latitude, forKey: "currentLocLat")
            }
            
            
            loaded = 1
            if defaults.string(forKey: "\(todayDates)\(UserDefaults.standard.string(forKey: "calcMethod")!)\(UserDefaults.standard.string(forKey: "madhab")!)") == nil{
//        {if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
//        CLLocationManager.authorizationStatus() == .authorizedAlways) {
            
              
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE, MMMM d"
            //OR dateFormatter.dateFormat = "EEEE, MMMM dd, yyyy"
            let currentDateString: String = dateFormatter.string(from: todayDates)

                
                if todayDates == todayDate {
                    dateLabel.text = "Today"

                }
                else{
                    dateLabel.text = currentDateString}
                
                var params: CalculationParameters?
                
                if UserDefaults.standard.string(forKey: "calcMethod") == nil {
                    params = CalculationMethod.karachi.params
                }
                else{
                    switch UserDefaults.standard.string(forKey: "calcMethod") {
                    case "Karachi":
                        params = CalculationMethod.karachi.params
                        print("WOOKarachi")
                    case "Muslim World League":
                        params = CalculationMethod.muslimWorldLeague.params
                        print("WOOMuslim")
                    case "Dubai Committee":
                        params = CalculationMethod.dubai.params
                    case "Kuwait Committee":
                        params = CalculationMethod.kuwait.params
                        print("WOOMuslim")
                  

                    case "Moon Sighting Committee":
                        params = CalculationMethod.moonsightingCommittee.params
                        print("WOOMoon")

                    case "Um Al Qura":
                        params = CalculationMethod.ummAlQura.params
                        print("WOOUm")
                        
                    case "Egyption Method":
                        params = CalculationMethod.egyptian.params
                        print("egypt")

                    default:
                        params = CalculationMethod.karachi.params
                        print("WOOKOO")

                    }
                }
                
                
                if UserDefaults.standard.string(forKey: "madhab") == nil {
                    params = CalculationMethod.karachi.params
                }
                else{
                    switch UserDefaults.standard.string(forKey: "madhab") {
                    case "Shafi":
                        params?.madhab = .shafi
                    case "Hanafi":
                        params?.madhab = .hanafi
                    default:
                        params?.madhab = .shafi
                        print("WOOKOO")

                    }
                }
                    
                
             
            let location = CLLocation(latitude: currentLoc.coordinate.latitude, longitude: currentLoc.coordinate.longitude)
            location.fetchCityAndCountry { city, country, error in
                guard let city = city, let country = country, error == nil else { return }
                let address = "\(city)"
                self.addressLabel.text = address
                
                self.getCoordinateFrom(address: address) { coordinate, error in
                    guard let coordinate = coordinate, error == nil else { return }
                    // don't forget to update the UI from the main thread
                    DispatchQueue.main.async {
                        print(address, "Location:", coordinate)
                        let coordinates = Coordinates(latitude: coordinate.latitude, longitude: coordinate.longitude)
                        if let prayers = PrayerTimes(coordinates: coordinates, date: date, calculationParameters: params!) {
                            let formatter = DateFormatter()
                            formatter.timeStyle = .medium
                            let timeZone = TimeZone.current.identifier
                            formatter.timeZone = TimeZone(identifier: timeZone)

                            
                            var fajir = "\(formatter.string(from: prayers.fajr))".replacingOccurrences(of:":00 ", with: " ")
                            var sunrise = "\(formatter.string(from: prayers.sunrise))".replacingOccurrences(of:":00 ", with: " ")
                            var dhur = "\(formatter.string(from: prayers.dhuhr))".replacingOccurrences(of:":00 ", with: " ")
                            var asr = "\(formatter.string(from: prayers.asr))".replacingOccurrences(of:":00 ", with: " ")
                            var maghrib = "\(formatter.string(from: prayers.maghrib))".replacingOccurrences(of:":00 ", with: " ")
                            var isha = "\(formatter.string(from: prayers.isha))".replacingOccurrences(of:":00 ", with: " ")
                        

                            DispatchQueue.main.async {
                                self.fajirTime.text = fajir
                                self.sunRiseTime.text = sunrise
                                self.dhuhrTime.text = dhur
                                self.asrTime.text = asr
                                self.maghribTime.text = maghrib
                                self.ishaTime.text = isha
                            }
                            
               
                            self.defaults.setValue("\(city)", forKey: "\(todayDates)\(UserDefaults.standard.string(forKey: "calcMethod")!)\(UserDefaults.standard.string(forKey: "madhab")!)")
                            self.defaults.setValue(fajir, forKey: "fajir\(todayDates)\(UserDefaults.standard.string(forKey: "calcMethod")!)\(UserDefaults.standard.string(forKey: "madhab")!)")
                            self.defaults.setValue(sunrise, forKey: "sunrise\(todayDates)\(UserDefaults.standard.string(forKey: "calcMethod")!)\(UserDefaults.standard.string(forKey: "madhab")!)")

                            self.defaults.setValue(dhur, forKey: "dhur\(todayDates)\(UserDefaults.standard.string(forKey: "calcMethod")!)\(UserDefaults.standard.string(forKey: "madhab")!)")
                            self.defaults.setValue(asr, forKey: "asr\(todayDates)\(UserDefaults.standard.string(forKey: "calcMethod")!)\(UserDefaults.standard.string(forKey: "madhab")!)")
                            self.defaults.setValue(maghrib, forKey: "maghrib\(todayDates)\(UserDefaults.standard.string(forKey: "calcMethod")!)\(UserDefaults.standard.string(forKey: "madhab")!)")
                            self.defaults.setValue(isha, forKey: "isha\(todayDates)\(UserDefaults.standard.string(forKey: "calcMethod")!)\(UserDefaults.standard.string(forKey: "madhab")!)")
                   
                            

                    }
                    }

                }
            }
                
            
            
           
        
            


        }
        else{
            addressLabel.text = defaults.string(forKey: "\(todayDates)\(UserDefaults.standard.string(forKey: "calcMethod")!)\(UserDefaults.standard.string(forKey: "madhab")!)")
            if date == datess {
                dateLabel.text = "Today"
                print("first\(date)kaka\(datess)lol")

            }
            else{
                print("first\(date)kaka\(datess)lolz")

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE, MMMM d"
            //OR dateFormatter.dateFormat = "EEEE, MMMM dd, yyyy"
            let currentDateString: String = dateFormatter.string(from: todayDates)

            dateLabel.text = currentDateString
            }
            
            self.fajirTime.text = defaults.string(forKey: "fajir\(todayDates)\(UserDefaults.standard.string(forKey: "calcMethod")!)\(UserDefaults.standard.string(forKey: "madhab")!)")
            self.sunRiseTime.text = defaults.string(forKey: "sunrise\(todayDates)\(UserDefaults.standard.string(forKey: "calcMethod")!)\(UserDefaults.standard.string(forKey: "madhab")!)")
            self.dhuhrTime.text = defaults.string(forKey: "dhur\(todayDates)\(UserDefaults.standard.string(forKey: "calcMethod")!)\(UserDefaults.standard.string(forKey: "madhab")!)")
            self.asrTime.text = defaults.string(forKey: "asr\(todayDates)\(UserDefaults.standard.string(forKey: "calcMethod")!)\(UserDefaults.standard.string(forKey: "madhab")!)")
            self.maghribTime.text = defaults.string(forKey: "maghrib\(todayDates)\(UserDefaults.standard.string(forKey: "calcMethod")!)\(UserDefaults.standard.string(forKey: "madhab")!)")
            self.ishaTime.text = defaults.string(forKey: "isha\(todayDates)\(UserDefaults.standard.string(forKey: "calcMethod")!)\(UserDefaults.standard.string(forKey: "madhab")!)")
        
        }}
        else{
            done = true

            
            
            print("lol")
            
            
            if CLLocationManager.authorizationStatus() == .denied {
                locationServiceError.isHidden = false
                prayersTimes.isHidden = true
                turnOnLocationLabel.isHidden = true
                turnOnLocationButton.isHidden = true
            }
            else{
                locationServiceError.isHidden = true
                turnOnLocationLabel.isHidden = false
                turnOnLocationButton.isHidden = false
                prayersTimes.isHidden = true
            }
            currentLoc = locationManager.location
 
            
            
            
            
            
        }

    }
    var calss: Calendar?
    var datess: DateComponents?
    var todayDate: Date?
    
    var currentDatess: DateComponents?
    var currentTodayDate: Date?
    
    
    
   
    
    var loaded = 0
    var done = true
    var timer2 = Timer()
    
    
    
    
    
    func getAd(){
        var request2 = GADRequest()
        GADInterstitialAd.load(withAdUnitID: "ca-app-pub-3000572088432917/6972571417",
                                    request: request2,
                          completionHandler: { [self] ad, error in
                            if let error = error {
                              print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                              return
                            }
                            self.interstitial = ad
                            self.interstitial.fullScreenContentDelegate = self

                          }
        )
    }
    var bobo = false
    override func viewDidLoad() {
        super.viewDidLoad()
        getAd()
        
        
      
        
        Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { [self] timer in
            if interstitial != nil {
               interstitial.present(fromRootViewController: self)

             } else {
                print("Ad wasn't ready")
                getAd()

                Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { [self] timer in
                    if interstitial != nil {
                       interstitial.present(fromRootViewController: self)

                     } else {
                        print("Ad wasn't ready")
                        
                     }
                }
                
             }
        }
        
  

        
        currentLoc = locationManager.location

        Analytics.logEvent("WOAH_OPENED", parameters: nil)

        turnOnLocationLabel.attributedText = NSAttributedString(string: "turn on location services", attributes:
            [.underlineStyle: NSUnderlineStyle.single.rawValue])

        
        

                    
        leftWidth.constant = windowWidth()/5
        rightWidth.constant = windowWidth()/5

        calss = Calendar(identifier: Calendar.Identifier.gregorian)
        datess = calss!.dateComponents([.year, .month, .day], from: Date())
        todayDate = NSCalendar.current.date(from: datess!)!
        currentDatess = calss!.dateComponents([.year, .month, .day], from: Date())
        currentTodayDate = NSCalendar.current.date(from: currentDatess!)!
        
        print("TODAYS\(datess)")
        
        
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
           
            if self.done == true {
                self.loadTimes(todayDates: self.currentTodayDate!, date: self.currentDatess!)
            }
        
        
        }
    
        
    
        var wowAmazing: Bool?
        
    
    

}
    
    var timer4 = Timer()
    
    func windowHeight() -> CGFloat {
        return UIScreen.main.bounds.size.height
    }

    func windowWidth() -> CGFloat {
        return UIScreen.main.bounds.size.width
    }

}
