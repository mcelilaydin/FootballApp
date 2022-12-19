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
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "home") as? HomeVC
        vc?.selectedCountryId = countryId ?? 0
        vc?.countryName = countryButtonTitle
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}

extension CountryVC {
    //MARK: - SET BUTTON
    
    func setButtonAtt(){
        countryButton.layer.masksToBounds = true
        countryButton.layer.cornerRadius = countryButton.frame.height/2
        countryButton.layer.borderWidth = 1
        countryButton.layer.borderColor = UIColor.red.cgColor
        countryButton.setTitle(countryButtonTitle, for: .normal)
    }
    
    //MARK: - ALERT
    
    private func showAlert(AlertTitle:String,AlertMessage:String) {
        let alert = UIAlertController(title: AlertTitle, message: AlertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
            print("click")
        }))
        present(alert, animated: true)
    }
    
}
