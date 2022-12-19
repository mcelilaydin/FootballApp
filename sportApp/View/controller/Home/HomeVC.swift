//
//  HomeVC.swift
//  sportApp
//
//  Created by Celil Aydın on 16.12.2022.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    let vm = HomeVM()
    var item = [Team]()
    
    var selectedCountryId: Int = 0
    var countryName:String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicatorStart()
        vmParse()
        tableView.delegate = self
        tableView.dataSource = self
       
        // Do any additional setup after loading the view.
    }

}

extension HomeVC : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = item[indexPath.row].name
        return cell
    }
}

extension HomeVC {
    
    func vmParse() {
        vm.parse(countryId: selectedCountryId) { data,error  in
            if error == nil {
                self.item = data ?? self.item
                DispatchQueue.main.async {
                    self.tableView.reloadData()
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
      //  activityIndicator.hidesWhenStopped = false
    }
    
    private func activityIndicatorStop() {
        print("stop")
        activityIndicator.stopAnimating()
        activityIndicator.hidesWhenStopped = true
    }


}
