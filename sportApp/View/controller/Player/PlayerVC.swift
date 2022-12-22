//
//  PlayerVC.swift
//  sportApp
//
//  Created by Celil Aydın on 22.12.2022.
//

import UIKit

class PlayerVC: UIViewController {
    
    @IBOutlet weak var playerTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    let vm = PlayerVM()
    var item = [Player]()
    
    var countryId: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicatorStart()
        vmParse()
        playerTableView.delegate = self
        playerTableView.dataSource = self
        // Do any additional setup after loading the view.
        if item.count == 0 {
            self.showAlert(AlertTitle: "Error", AlertMessage: "Players count is equal zero from Api")
        }
    }

}

//MARK: - TABLEVİEW

extension PlayerVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = item[indexPath.row].firstname
        return cell
    }
    
    
}

//MARK: - ACTİVİTYINDICATOR

extension PlayerVC {
    
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

//MARK: - NETWORK
extension PlayerVC {
    
    func vmParse(){
        vm.parse(countryId: countryId, minAge: 19) { data,error in
            if error == nil {
                self.item = data ?? self.item
                DispatchQueue.main.async {
                    self.playerTableView.reloadData()
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
    
}

//MARK: -HELPER
extension PlayerVC {
    
    private func showAlert(AlertTitle:String,AlertMessage:String) {
        let alert = UIAlertController(title: AlertTitle, message: AlertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
            
        }))
        present(alert, animated: true)
    }
    
}
