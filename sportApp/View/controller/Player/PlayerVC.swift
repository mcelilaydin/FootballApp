//
//  PlayerVC.swift
//  sportApp
//
//  Created by Celil Aydın on 28.12.2022.
//

import UIKit
import SDWebImage

class PlayerVC: UIViewController {
    
    @IBOutlet weak var playerImageView: UIImageView!
    @IBOutlet weak var firstnameLabel: UILabel!
    @IBOutlet weak var lastnameLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    
    
    var item = Player(playerID: 0, firstname: "", lastname: "", birthday: "", age: 0, weight: 0, height: 0, img: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        // Do any additional setup after loading the view.
    }
    
    func setView(){
        if item.img == "" {
            playerImageView.image = UIImage(systemName: "person.fill")            
        }else {
            playerImageView.sd_setImage(with: URL(string: item.img))
        }
        firstnameLabel.text = item.firstname
        lastnameLabel.text = item.lastname
        birthdayLabel.text = item.birthday
        ageLabel.text = "\(item.age)"
        weightLabel.text = "\(item.weight ?? 0)"
        heightLabel.text = "\(item.height ?? 0)"
    }

}
