//
//  SettingsViewController.swift
//  prayingTimes
//
//  Created by Omar Rayyan on 13/04/2021.
//

import UIKit
import DropDown

class SettingsViewController: UIViewController {

    @IBOutlet weak var calcWhole: UIView!
    @IBOutlet weak var madhabWhole: UIView!
    @IBOutlet weak var madhabButton: UIButton!
    @IBOutlet weak var calcButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        calcWhole.layer.cornerRadius = calcWhole.frame.height / 8
        madhabWhole.layer.cornerRadius = madhabWhole.frame.height / 8
        calcWhole.layer.masksToBounds = true
        madhabWhole.layer.masksToBounds = true


        if let bobo = UserDefaults.standard.string(forKey: "madhab"){
            madhabButton.setTitle(bobo, for: .normal)}
        else{
            madhabButton.setTitle("Shafi", for: .normal)
        }
        
        if let momo = UserDefaults.standard.string(forKey: "calcMethod"){
            calcButton.setTitle(momo, for: .normal)}
        else
        {
            calcButton.setTitle("Karachi", for: .normal)

        }
        

        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func calcArrow(_ sender: Any) {
        cllickedCalc(calcButton)
    }
    
    @IBAction func madhabArrow(_ sender: Any) {
        clickedMadhab(madhabButton)
    }
    let arrayMadhab = ["Shafi", "Hanafi"]
    var calcMethods = ["Karachi", "Muslim World League", "Moon Sighting Committee", "Um Al Qura", "Egyption Method", "Dubai Committee", "Kuwait Committee"]

    
    let dropDown = DropDown() //2

    @IBAction func clickedMadhab(_ sender: Any) {

        dropDown.dataSource = arrayMadhab
        
        dropDown.anchorView = sender as! AnchorView //5
        dropDown.bottomOffset = CGPoint(x: 0, y: (sender as AnyObject).frame.size.height) //6
          dropDown.show() //7
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in //8
            guard let _ = self else { return }
            self!.madhabButton.setTitle(item, for: .normal)
      
            UserDefaults.standard.setValue(item, forKey: "madhab")
            Manager.shared.change = true

    }
    
        
    }
    
     @IBAction func cllickedCalc(_ sender: Any) {

        dropDown.dataSource = calcMethods
        
        dropDown.anchorView = sender as! AnchorView //5
        dropDown.bottomOffset = CGPoint(x: 0, y: (sender as AnyObject).frame.size.height) //6
          dropDown.show() //7
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in //8
            guard let _ = self else { return }
            self!.calcButton.setTitle(item, for: .normal)
        
            UserDefaults.standard.setValue(item, forKey: "calcMethod")
            
            Manager.shared.change = true



        
     }


}





}
