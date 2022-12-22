//
//  PlayerVM.swift
//  sportApp
//
//  Created by Celil Aydın on 22.12.2022.
//

import Foundation
import Alamofire

class PlayerVM {
    
    weak var vc : PlayerVC?
    var arrPlayers = [Player]()
    
    var error: Error? {
        didSet { self.showAlertClosure?() }
    }
    var isLoading: Bool = true {
        didSet { self.updateLoadingStatus?() }
    }
    
    var showAlertClosure: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    
    func parse(countryId:Int,minAge:Int,comp: @escaping ([Player]?,Error?)->()){
        
        let api = "https://app.sportdataapi.com/api/v1/soccer/players?apikey=156160a0-7c83-11ed-81d1-9175154fc401&country_id=\(countryId)&min_age=\(minAge)"
        
        AF.request(api).response { response in
            if let data = response.data {
                do{
                    let result = try JSONDecoder().decode(Players.self,from: data)
                    self.arrPlayers = result.data
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
