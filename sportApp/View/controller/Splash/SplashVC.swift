//
//  ViewController.swift
//  sportApp
//
//  Created by Celil Aydın on 16.12.2022.
//

import UIKit

class SplashVC: UIViewController {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        imageView.image = UIImage(named: "ball")
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.center = view.center
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
           self.animate()
        }
    }
    
    private func animate() {
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
                    let controller = self.storyboard?.instantiateViewController(withIdentifier: "onboarding") as! OnboardingVC
                    controller.modalPresentationStyle = .fullScreen
                    controller.modalTransitionStyle = .partialCurl
                    self.present(controller, animated: true, completion: nil)
                }
            }
        }


}

