//
//  LeagueMenuVM.swift
//  sportApp
//
//  Created by Celil Aydın on 19.12.2022.
//

import Foundation
import Alamofire


class LeagueMenuVM {
    
    weak var vc : LeagueMenuVC?
    var arrLeague = [String:League]()
    
    var error: Error? {
        didSet { self.showAlertClosure?() }
    }
    var isLoading: Bool = true {
        didSet { self.updateLoadingStatus?() }
    }
    
    var showAlertClosure: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    
    func parseLeague(countryID:Int,comp:@escaping ([League]?,Error?)->()){
        let api = "https://app.sportdataapi.com/api/v1/soccer/leagues?apikey=156160a0-7c83-11ed-81d1-9175154fc401&country_id=\(countryID)"
        
        AF.request(api).response { response in
            if let data = response.data {
                do{
                    let result = try JSONDecoder().decode(Leagues.self,from: data)
                    self.arrLeague = result.data
                    let mc = Array(result.data.values)
                    comp(mc, nil)
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
