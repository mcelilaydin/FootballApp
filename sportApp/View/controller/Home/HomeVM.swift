//
//  HomeVM.swift
//  sportApp
//
//  Created by Celil Aydın on 16.12.2022.
//

import UIKit
import Alamofire

class HomeVM {
    
    weak var vc : HomeVC?
    var arrTeams = [Team]()
    
    var error: Error? {
        didSet { self.showAlertClosure?() }
    }
    var isLoading: Bool = true {
        didSet { self.updateLoadingStatus?() }
    }
    
    var showAlertClosure: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    
    func parse(countryId:Int,comp: @escaping ([Team]?,Error?)->()){
        
//        static var header: HTTPHeaders = [
//            "apikey": "156160a0-7c83-11ed-81d1-9175154fc401"
//        ]
        
        //120 -Süperlig
        
        let api = "https://app.sportdataapi.com/api/v1/soccer/teams?apikey=156160a0-7c83-11ed-81d1-9175154fc401&country_id=\(countryId)"
        
        AF.request(api).response { response in
            if let data = response.data {
                do{
                    let result = try JSONDecoder().decode(Welcome.self,from: data)
                    self.arrTeams = result.data
                    comp(result.data, nil)
                    self.isLoading = false
                }catch {
                    print(error.localizedDescription)
                    comp(nil, error)
                    self.isLoading = true
                }
            }
        }
    }
    
   

}
