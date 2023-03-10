//
//  ListVC.swift
//  sportApp
//
//  Created by Celil Aydın on 27.12.2022.
//

import UIKit
import SDWebImage
import PanModal

class ListVC: UIViewController {

    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let vm = ListVM()
    var itemTeam = [Team]()
    var itemPlayer = [Player]()
    
    var selectedCountryId: Int = 0
    var countryName:String = ""
    
    var showPlayer: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicatorStart()
        listTableView.register(UINib.init(nibName: PlayerCell.identifier, bundle: nil), forCellReuseIdentifier: PlayerCell.identifier)
        listTableView.delegate = self
        listTableView.dataSource = self
        vmTeamParse()
        setRightbarButton()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didChangeList(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            activityIndicatorStart()
            navigationItem.rightBarButtonItem?.isHidden = true
            showPlayer = false
            vmTeamParse()
        case 1:
            activityIndicatorStart()
            navigationItem.rightBarButtonItem?.isHidden = false
            showPlayer = true
            vmPlayerParse()
        default:
            return
        }
    }
    
}

extension ListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if showPlayer == false {
            return itemTeam.count
        }else {
            return itemPlayer.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlayerCell.identifier, for: indexPath) as! PlayerCell
        if showPlayer == false {
            if itemTeam[indexPath.row].logo == "" {
                cell.imageVİew.image = UIImage(systemName: "person.3.sequence.fill")?.withTintColor(.black)
            }else {
                cell.imageVİew.sd_setImage(with: URL(string: itemTeam[indexPath.row].logo))
            }
            cell.firstNameLabel.text = itemTeam[indexPath.row].name
            cell.secondNameLabel.text = itemTeam[indexPath.row].shortCode
        }else {
            if itemPlayer[indexPath.row].img == "" {
                cell.imageVİew.image = UIImage(systemName: "figure.soccer")
            }else {
                cell.imageVİew.sd_setImage(with: URL(string: itemPlayer[indexPath.row].img))
            }
            cell.firstNameLabel.text = itemPlayer[indexPath.row].firstname
            cell.secondNameLabel.text = itemPlayer[indexPath.row].lastname.uppercased()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if showPlayer == true {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "playervc") as? PlayerVC
            vc?.item = itemPlayer[indexPath.row]
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
}

extension ListVC {
    
    func vmTeamParse() {
        vm.parse(countryId: selectedCountryId) { data,error  in
            if error == nil {
                self.itemTeam = data ?? self.itemTeam
                DispatchQueue.main.async {
                    self.listTableView.reloadData()
                }
            }else {
                if let error = self.vm.error {
                    self.vm.showAlertClosure = {
                        print(error.localizedDescription)
                    }
                }
            }
            self.vm.updateLoadingStatus = {
                let _ = self.vm.isLoading ? self.activityIndicatorStart() : self.activityIndicatorStop()
            }
        }
    }
    
    func vmPlayerParse(){
        vm.parse(countryId: selectedCountryId, minAge: 19) { data,error in
            if error == nil {
                self.itemPlayer = data ?? self.itemPlayer
                if self.itemPlayer.count == 0 {
                    DuplicateFuncs.alertMessage(title: "Error", message: "The number of players in Api is zero.", vc: self)
                }
                DispatchQueue.main.async {
                    self.listTableView.reloadData()
                }
            }else {
                if let error = self.vm.error {
                    self.vm.showAlertClosure = {
                        print(error.localizedDescription)
                    }
                }
            }
            self.vm.updateLoadingStatus = {
                let _ = self.vm.isLoading ? self.activityIndicatorStart() : self.activityIndicatorStop()
            }
        }
    }
    
    private func activityIndicatorStart() {
        print("start")
        activityIndicator.startAnimating()
    }
    
    private func activityIndicatorStop() {
        print("stop")
        activityIndicator.stopAnimating()
        activityIndicator.hidesWhenStopped = true
    }
    
}

extension ListVC {
    
    func setRightbarButton(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "info.circle.fill"), style: .plain, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItem?.isHidden = true
        
    }
    
    @objc func addTapped(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "agetable") as! AgeTableVC
        presentPanModal(vc)
    }
    
}
