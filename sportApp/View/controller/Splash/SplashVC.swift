//
//  ViewController.swift
//  sportApp
//
//  Created by Celil Aydın on 16.12.2022.
//

import UIKit
import Network

class SplashVC: UIViewController {
    
    var isConnected : Bool = false
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        imageView.image = UIImage(named: "ball")
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        monitorNetwork()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.center = view.center
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
           self.animate()
        }
    }
    
    private func animate() {
        if isConnected == true {
            UIView.animate(withDuration: 1.5) {
                let size = self.view.frame.size.width * 3
                let diffX = size - self.view.frame.size.width
                let diffY = self.view.frame.size.height - size
                self.imageView.frame = CGRect(x: -(diffX/2),
                                              y: diffY/2,
                                              width: size,
                                              height: size)
            }
            UIView.animate(withDuration: 1.5) {
                self.imageView.alpha = 0
            } completion: { done in
                if done {
                    if (UserDefaults.standard.bool(forKey: "openApp") == true) {
                        let controller = self.storyboard?.instantiateViewController(withIdentifier: "country") as! CountryVC
                        controller.modalPresentationStyle = .fullScreen
                        controller.modalTransitionStyle = .partialCurl
                        self.present(controller, animated: true,completion: nil)
                    }else {
                        let controller = self.storyboard?.instantiateViewController(withIdentifier: "onboarding") as! OnboardingVC
                        controller.modalPresentationStyle = .fullScreen
                        controller.modalTransitionStyle = .partialCurl
                        self.present(controller, animated: true, completion: nil)
                    }
                }
            }
        }
    }
}

extension SplashVC {
    
    //MARK: -NETWORK CONTROL
    func monitorNetwork() {
        let monitor = NWPathMonitor()
        let queue = DispatchQueue.global()
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                print("internet connected")
                self.isConnected = true
            }else {
                DispatchQueue.main.async {
                    self.callAlert(title: "Internet", message: "Internet not connected")
                }
            }
        }
        monitor.start(queue: queue)
    }

    //MARK: - ALERT
    func callAlert(title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (alert: UIAlertAction!) in
            self.monitorNetwork()
            if self.isConnected == true {
                print("başarılı")
                self.animate()
            }
        }
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
}

