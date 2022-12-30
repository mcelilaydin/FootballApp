//
//  CountryVC.swift
//  sportApp
//
//  Created by Celil Aydın on 17.12.2022.
//

import UIKit

class CountryVC: UIViewController {

    @IBOutlet weak var countryButton: UIButton!
    
    var countryButtonTitle : String = "Country Name"
    var countryId : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        setButtonAtt()
    }

    @IBAction func countryButtonClicked(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "countrymenu") as? CountryMenuVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func continueClicked(_ sender: Any) {
        if countryButtonTitle == "Country Name" {
            DuplicateFuncs.alertMessage(title: "Error", message: "Please click world And select country.", vc: self)
        }else {
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "home") as? HomeVC
//            vc?.selectedCountryId = countryId ?? 0
//            vc?.countryName = countryButtonTitle
//            self.navigationController?.pushViewController(vc!, animated: true)
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "list") as? ListVC
                        vc?.selectedCountryId = countryId ?? 0
                        vc?.countryName = countryButtonTitle
                        self.navigationController?.pushViewController(vc!, animated: true)
            
        }
    }
}

extension CountryVC {
    //MARK: - SET BUTTON
    
    func setButtonAtt(){
        countryButton.setTitle(countryButtonTitle, for: .normal)
    }
    
}
