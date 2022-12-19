//
//  CountryMenuVC.swift
//  sportApp
//
//  Created by Celil Aydın on 17.12.2022.
//

import UIKit

class CountryMenuVC: UIViewController {
    
    let vm = CountryMenuVM()
    var countryItem = [Country]()
    
    @IBOutlet weak var countryTableView: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countryTableView.delegate = self
        countryTableView.dataSource = self
        activityIndicatorStart()
        vmParseCountry()
        // Do any additional setup after loading the view.
    }

}

//MARK: -TABLEVİEW

extension CountryMenuVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = countryItem[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "country") as? CountryVC
        vc?.countryButtonTitle = countryItem[indexPath.row].name
        vc?.countryId = countryItem[indexPath.row].countryID
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}

//MARK: -NETWORK

extension CountryMenuVC {
    
    func vmParseCountry() {
        vm.parseCountry { data,error  in
            if error == nil {
                self.countryItem = data ?? self.countryItem
                DispatchQueue.main.async {
                    self.countryTableView.reloadData()
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

extension CountryMenuVC {
    
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
