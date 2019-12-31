//
//  HomeVC.swift
//  World Culture Deck
//
//  Created by Audrey Ha on 12/30/19.
//  Copyright © 2019 AudreyHa. All rights reserved.
//

import UIKit

class HomeVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var allDeckCollectionView: UICollectionView!
    @IBOutlet weak var completedCollectionView: UICollectionView!
    
    var collectionViewFlowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupAllDecksLayout()
        setUpCompletedDecksLayout()
    }
    
    private func setupCollectionView(){
        allDeckCollectionView.delegate=self
        allDeckCollectionView.dataSource=self
        
        completedCollectionView.delegate=self
        completedCollectionView.dataSource=self
    }

    private func setupAllDecksLayout(){
        let lineSpacing:CGFloat=15
        let interItemSpacing:CGFloat=15
        
        
        let height=allDeckCollectionView.frame.height
        let width=height*0.8
        collectionViewFlowLayout=UICollectionViewFlowLayout()
        collectionViewFlowLayout.itemSize=CGSize(width: width, height: height)
        collectionViewFlowLayout.sectionInset=UIEdgeInsets.zero
        collectionViewFlowLayout.scrollDirection = .horizontal
        collectionViewFlowLayout.minimumLineSpacing=lineSpacing
        collectionViewFlowLayout.minimumInteritemSpacing=interItemSpacing
        
        allDeckCollectionView.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
    }
    
    private func setUpCompletedDecksLayout(){
        let lineSpacing:CGFloat=15
        let interItemSpacing:CGFloat=15
        
        
        let height=allDeckCollectionView.frame.height
        let width=height*0.8
        collectionViewFlowLayout=UICollectionViewFlowLayout()
        collectionViewFlowLayout.itemSize=CGSize(width: width, height: height)
        collectionViewFlowLayout.sectionInset=UIEdgeInsets.zero
        collectionViewFlowLayout.scrollDirection = .horizontal
        collectionViewFlowLayout.minimumLineSpacing=lineSpacing
        collectionViewFlowLayout.minimumInteritemSpacing=interItemSpacing
        
        completedCollectionView.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        if(collectionView==allDeckCollectionView){
            return 3
        }else{
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        if(collectionView==allDeckCollectionView){
            let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "AllDecksCell", for: indexPath) as! AllDecksCell
                cell.layer.cornerRadius=10
                cell.regionLabel.adjustsFontSizeToFitWidth=true
            
                return cell
        }else{
            let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "CompletedDecksCell", for: indexPath) as! CompletedDecksCell
                cell.layer.cornerRadius=10
                cell.regionLabel.adjustsFontSizeToFitWidth=true
            
                return cell
        }
        
    }

}
