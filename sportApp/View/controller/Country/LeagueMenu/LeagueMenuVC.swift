//
//  LeagueMenuVC.swift
//  sportApp
//
//  Created by Celil Aydın on 19.12.2022.
//

import UIKit

class LeagueMenuVC: UIViewController {

    @IBOutlet weak var leagueTableVİew: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let vm = LeagueMenuVM()
    var leagueItem = [League]()
    
    var selectedCountryID: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        leagueTableVİew.delegate = self
        leagueTableVİew.dataSource = self
       // activityIndicatorStart()
        vmParseLeague()
        // Do any additional setup after loading the view.
    }

}

extension LeagueMenuVC: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leagueItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = leagueItem[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "country") as? CountryVC
        vc?.countryButtonTitle = leagueItem[indexPath.row].name
        vc?.countryId = leagueItem[indexPath.row].leagueID
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}

//MARK: -NETWORK

extension LeagueMenuVC {
    
    func vmParseLeague() {
        vm.parseLeague(countryID: selectedCountryID) { data, error in
            if error == nil {
                self.leagueItem = data ?? self.leagueItem
                DispatchQueue.main.async {
                    self.leagueTableVİew.reloadData()
                }
            }else {
                if let error = self.vm.error {
                    self.vm.showAlertClosure = {
                        print(error.localizedDescription)
                    }
                }
            }
            self.vm.updateLoadingStatus = {
            //        let _ = self.vm.isLoading ? self.activityIndicatorStart() : self.activityIndicatorStop()
            }
        }
    }
}

extension LeagueMenuVC {
    
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
