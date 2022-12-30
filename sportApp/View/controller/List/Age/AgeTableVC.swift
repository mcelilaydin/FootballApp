//
//  AgeTableVC.swift
//  sportApp
//
//  Created by Celil Aydın on 29.12.2022.
//

import Foundation
import UIKit
import PanModal

class AgeTableVC: UITableViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension AgeTableVC: PanModalPresentable {
    
    var panScrollable: UIScrollView? {
        return tableView
    }
    
}
