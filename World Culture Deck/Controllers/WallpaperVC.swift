//
//  WallpaperVC.swift
//  World Culture Deck
//
//  Created by Audrey Ha on 12/30/19.
//  Copyright © 2019 AudreyHa. All rights reserved.
//

import UIKit

class WallpaperVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{

    @IBOutlet weak var collectionView: UICollectionView!
    
    var collectionViewFlowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupLayout()
    }
    
    private func setupCollectionView(){
        collectionView.delegate=self
        collectionView.dataSource=self
        let nib=UINib(nibName: "WallpaperCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "WallpaperCell")
    }

    private func setupLayout(){
        let numberOfItemPerRow:CGFloat=2
        let lineSpacing:CGFloat=15
        let interItemSpacing:CGFloat=15
        
        let width=(collectionView.frame.width-(numberOfItemPerRow-1)*interItemSpacing)/numberOfItemPerRow
        let height=width*1.5
        
        collectionViewFlowLayout=UICollectionViewFlowLayout()
        collectionViewFlowLayout.itemSize=CGSize(width: width, height: height)
        collectionViewFlowLayout.sectionInset=UIEdgeInsets.zero
        collectionViewFlowLayout.scrollDirection = .vertical
        collectionViewFlowLayout.minimumLineSpacing=lineSpacing
        collectionViewFlowLayout.minimumInteritemSpacing=interItemSpacing
        
        collectionView.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "WallpaperCell", for: indexPath) as! WallpaperCell
        cell.layer.cornerRadius=10
        cell.starsButton.layer.cornerRadius=10
        cell.regionLabel.adjustsFontSizeToFitWidth=true
        return cell
    }
    
    
}

