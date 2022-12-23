//
//  PlayerDetailVC.swift
//  sportApp
//
//  Created by Celil Aydın on 23.12.2022.
//

import UIKit
import SDWebImage

class PlayerDetailVC: UIViewController {

    @IBOutlet weak var playerImageView: UIImageView!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    
    var detail = Player(playerID: 0, firstname: "", lastname: "", birthday: "", age: 0, weight: 0, height: 0, img: "")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setView()
    }
}

extension PlayerDetailVC {
    
    //MARK: - SET VIEW
    func setView(){
        if detail.img == "" {
            playerImageView.image = UIImage(systemName: "figure.soccer")
        }else {
            playerImageView.sd_setImage(with: URL(string: detail.img))
        }
        firstNameLabel.text = detail.firstname
        lastNameLabel.text = detail.lastname
        birthdayLabel.text = detail.birthday
        ageLabel.text = "\(detail.age)"
        if detail.weight == 0  {
            weightLabel.text = "unknown"
        }else{
            weightLabel.text = "\(detail.weight ?? 0)"
        }
        if detail.height == 0{
            heightLabel.text = "unknown"
        }else {
            heightLabel.text = "\(detail.height ?? 0)"
        }
    }
    
}
