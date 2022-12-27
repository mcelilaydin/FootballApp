//
//  DuplicateFuncs.swift
//  sportApp
//
//  Created by Celil Aydın on 27.12.2022.
//

import Foundation
import UIKit

class DuplicateFuncs {
    
    static func alertMessage(title: String, message: String, vc: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(alertAction)
        vc.present(alert, animated: true)
        
    }
}
