//
//  NLI_HomeVC.swift
//  World Culture Deck
//
//  Created by Audrey Ha on 2/18/20.
//  Copyright © 2020 AudreyHa. All rights reserved.
//

import UIKit

class NLI_HomeVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var xButton: UIButton!
    @IBOutlet weak var blueBackground: UIView!
    @IBOutlet weak var allDeckCollectionView: UICollectionView!
    @IBOutlet weak var WCDLabel: UILabel!
    
    var collectionViewFlowLayout: UICollectionViewFlowLayout!
    var allNames: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        WCDLabel.adjustsFontSizeToFitWidth=true
        
        UIGraphicsBeginImageContext(blueBackground.frame.size)
        UIImage(named: "0_FlagCollage")?.draw(in: blueBackground.bounds)
        
        if let image = UIGraphicsGetImageFromCurrentImageContext(){
            UIGraphicsEndImageContext()
            blueBackground.backgroundColor = UIColor(patternImage: image.alpha(0.2))
        }
        
        allNames=["Ghana","Lebanon","Mexico","Navajo Nation","Norway","Peru","Roma","South Africa","South Korea","Tonga"]
        
        self.setupCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupAllDecksLayout()
    }
    
    private func setupCollectionView(){
        allDeckCollectionView.delegate=self
        allDeckCollectionView.dataSource=self
    }

    private func setupAllDecksLayout(){
        let lineSpacing:CGFloat=15
        let interItemSpacing:CGFloat=15
        
        let width=(self.view.frame.width-45)/2
        let height=width*1.25
        
        collectionViewFlowLayout=UICollectionViewFlowLayout()
        collectionViewFlowLayout.itemSize=CGSize(width: width, height: height)
        collectionViewFlowLayout.sectionInset=UIEdgeInsets.zero
        collectionViewFlowLayout.scrollDirection = .vertical
        collectionViewFlowLayout.minimumLineSpacing=lineSpacing
        collectionViewFlowLayout.minimumInteritemSpacing=interItemSpacing
        
        allDeckCollectionView.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return allNames.count
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var countryName=allNames[indexPath.row]
        print(countryName)
        UserDefaults.standard.set(countryName, forKey:"NLI_countryName")
        performSegue(withIdentifier: "countryController", sender: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "AllDecksCell", for: indexPath) as! AllDecksCell
        cell.layer.cornerRadius=10
    
        cell.regionLabel.adjustsFontSizeToFitWidth=true
        cell.regionLabel.text=allNames[indexPath.row]
    
        cell.regionImage.layer.cornerRadius=10
        cell.regionImage.image=UIImage(named: "\(allNames[indexPath.row])Cover")
    
        return cell
    }

    @IBAction func xPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
}
