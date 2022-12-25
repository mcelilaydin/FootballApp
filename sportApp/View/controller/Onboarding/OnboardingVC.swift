//
//  OnboardingVC.swift
//  sportApp
//
//  Created by Celil Aydın on 23.12.2022.
//

import UIKit

// MARK: ÇÖZ - Next Button tıklandıgında scrollama yapmıyor.

class OnboardingVC: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var slides: [OnboardingSlide] = []
    
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                nextBtn.layer.opacity = 1
                nextBtn.setTitle("Get Started", for: .normal)
            }else {
                nextBtn.layer.opacity = 0.5
                nextBtn.setTitle("Next", for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        nextBtn.layer.opacity = 0.5
        slides = [
            OnboardingSlide(title: "Avrupa Ülkeleri", description: "Avrupa ülkeleri listenelenir ve seçilir.", image:UIImage(named: "earth")!),
            OnboardingSlide(title: "Ülkelerin Ligleri", description: "Ülkelerin sahip oldugu ligler sıralanır.", image:UIImage(named: "ball")!),
            OnboardingSlide(title: "Ülkelin Yerli Oyuncuları ", description: "Ülkelerin yerli oyuncuları sıralanır ve detayları verilir", image:UIImage(named: "ball")!)
        ]

        // Do any additional setup after loading the view.
    }

    @IBAction func nextBtnClicked(_ sender: Any) {
        if currentPage == slides.count - 1 {
            UserDefaults.standard.set(true, forKey: "openApp")
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "country") as? CountryVC
            self.navigationController?.pushViewController(vc!, animated: true)
        }else {
//            currentPage += 1
//            let indexPath = IndexPath(item: currentPage, section: 0)
//            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
}


extension OnboardingVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
        cell.setup(slides[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
        //pageControl.currentPage = currentPage
    }
}
