//
//  MorningPrayersViewController.swift
//  prayingTimes
//
//  Created by Omar Rayyan on 15/03/2021.
//

import UIKit
import CoreLocation
import Adhan
import Firebase
import FirebaseAnalytics
import GoogleMobileAds

class NightPrayersViewController: UIViewController, GADFullScreenContentDelegate {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var completed: UILabel!
    
    private var interstitial: GADInterstitialAd!

    let nightPrayers: [[String]] = [["1 time", "الحمد لله وحده، والصلاة والسلام على من لا نبي بعده"], ["1 time", "الله لا إله إلا هو الحي القيوم لا تأخذه سنة ولا نوم له ما في السموات وما في الأرض من ذا الذي يشفع عنده إلا بإذنه يعلم ما بين أيديهم وما خلفهم ولا يحيطون بشيء من علمه إلا بما شاء وسع كرسيه السموات والأرض ولا يؤوده حفظهما وهو العلي العظيم"], ["3 times", "بسم الله الرحمن الرحيم ﴿قل هو الله أحد* الله الصمد* لم يلد ولم يولد* ولم يكن له كفوا أحد﴾. بسم الله الرحمن الرحيم ﴿قل أعوذ برب الفلق* من شر ما خلق* ومن شر غاسق إذا وقب* ومن شر النفاثات في العقد* ومن شر حاسد إذا حسد﴾. بسم الله الرحمن الرحيم ﴿قل أعوذ برب الناس* ملك الناس* إله الناس* من شر الوسواس الخناس* الذي يوسوس في صدور الناس* من الجنة و الناس﴾"], ["1 time", "أمسينا وأمسى الملك لله، والحمد لله، لا إله إلا الله وحده لا شريك له، له الملك وله الحمد وهو على كل شيء قدير، رب أسألك خير ما في هذه الليلة وخير ما بعدها، وأعوذ بك من شر ما في هذه الليلة وشر ما بعدها، رب أعوذ بك من الكسل وسوء الكبر، رب أعوذ بك من عذاب في النار وعذاب في القبر"], ["1 time", "اللهم بك أمسينا، وبك أصبحنا، وبك نحيا، وبك نموت وإليك المصير"], ["1 time", "اللهم أنت ربي لا إله إلا أنت، خلقتني وأنا عبدك، وأنا على عهدك ووعدك ما استطعت، أعوذ بك من شر ما صنعت، أبوء لك بنعمتك علي، وأبوء بذنبي فاغفر لي فإنه لا يغفر الذنوب إلا أنت"], ["4 times", "اللهم إني أصبحت أشهدك، وأشهد حملة عرشك، وملائكتك، وجميع خلقك، أنك أنت الله لا إله إلا أنت وحدك لا شريك لك، وأن محمدا عبدك ورسولك"], ["1 time", "اللهم ما أمسى بي من نعمة أو بأحد من خلقك فمنك وحدك لا شريك لك، فلك الحمد ولك الشكر"], ["3 times", "اللهم عافني في بدني، اللهم عافني في سمعي، اللهم عافني في بصري، لا إله إلا أنت. اللهم إني أعوذ بك من الكفر، والفقر، وأعوذ بك من عذاب القبر، لا إله إلا أنت"], ["7 times", "حسبي الله لا إله إلا هو عليه توكلت وهو رب العرش العظيم"], ["1 time", "اللهم إني أسألك العفو والعافية في الدنيا والآخرة، اللهم إني أسألك العفو والعافية: في ديني ودنياي وأهلي، ومالي، اللهم استر عوراتي، وآمن روعاتي، اللهم احفظني من بين يدي، ومن خلفي، وعن يميني، وعن شمالي، ومن فوقي، وأعوذ بعظمتك أن أغتال من تحتي"], ["1 time", "اللهم عالم الغيب والشهادة فاطر السموات والأرض، رب كل شيء ومليكه، أشهد أن لا إله إلا أنت، أعوذ بك من شر نفسي، ومن شر الشيطان وشركه، وأن أقترف على نفسي سوءا، أو أجره إلى مسلم"], ["3 times", "بسم الله الذي لا يضر مع اسمه شيء في الأرض ولا في السماء وهو السميع العليم"], ["3 times", "رضيت بالله ربا، وبالإسلام دينا، وبمحمد صلى الله عليه وسلم نبيا"], ["1 time", "يا حي يا قيوم برحمتك أستغيث أصلح لي شأني كله ولا تكلني إلى نفسي طرفة عين"], ["1 time", "أمسينا وأمسى الملك لله رب العالمين، اللهم إني أسألك خير هذه الليلة:فتحها، ونصرها، ونورها، وبركتها، وهداها، وأعوذ بك من شر ما فيها وشر ما بعدها"] , ["1 time", "أمسينا على فطرة الإسلام، وعلى كلمة الإخلاص، وعلى دين نبينا محمد صلى الله عليه وسلم، وعلى ملة أبينا إبراهيم، حنيفا مسلما وما كان من المشركين"], ["100 times", "سبحان الله وبحمده"], ["10 times", "لا إله إلا الله وحده لا شريك له، له الملك وله الحمد، وهو على كل شيء قدير"], ["100 times", "أستغفر الله وأتوب إليه"], ["3 times", "أعوذ بكلمات الله التامات من شر ما خلق"], ["10 times", "اللهم صل وسلم على نبينا محمد"]]
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var timesLabel: UILabel!
    
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAd()
        
     
        nextButton.layer.cornerRadius = nextButton.frame.height / 5
        doneButton.layer.cornerRadius = doneButton.frame.height / 5
        backButton.layer.cornerRadius = backButton.frame.height / 5
        textLabel.text = nightPrayers[current][1]
        timesLabel.text = nightPrayers[current][0]
        completed.text = "\(current+1)/\(nightPrayers.count)"

        // Do any additional setup after loading the view.
    }
    var current = 0
    
    
    var done = false
    var donetwo = false
    
    
    var done2 = false
    var done2two = false
    

    
    @IBAction func nextButtonPressed(_ sender: Any) {
        if current<nightPrayers.count-1{
        current += 1
//
//            if current == 2 && done == false{
//                getAd()
//                done = true
//            }
            if current > 1 && donetwo == false {

                if interstitial != nil {
                   interstitial.present(fromRootViewController: self)
                donetwo = true
                    getAd()

                 } else {
                    print("Ad wasn't ready")
                    
                 }
                
            }
           
    
            if current > 10 && done2two == false {

                if interstitial != nil {
                   interstitial.present(fromRootViewController: self)
                done2two = true

                 } else {
                    print("Ad wasn't ready")}
                
            }
            
            
        completed.text = "\(current+1)/\(nightPrayers.count)"
        textLabel.text = nightPrayers[current][1]
        timesLabel.text = nightPrayers[current][0]}
    }
    
    
    @IBAction func backButtonPressed(_ sender: Any) {
        if current>0{
        current -= 1
        completed.text = "\(current+1)/\(nightPrayers.count)"
        textLabel.text = nightPrayers[current][1]
        timesLabel.text = nightPrayers[current][0]}
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {

   
        self.dismiss(animated: true, completion: nil)

    }
    
  
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
