//
//  HomeVC.swift
//  World Culture Deck
//
//  Created by Audrey Ha on 12/30/19.
//  Copyright © 2019 AudreyHa. All rights reserved.
//

import UIKit
import FirebaseDatabase
import SwiftyJSON

class HomeVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var allDeckCollectionView: UICollectionView!
    @IBOutlet weak var completedCollectionView: UICollectionView!
    @IBOutlet weak var starLabel: UILabel!
    
    var collectionViewFlowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
        StarService.displayStars(myLabel: starLabel)
        InfoService.insertAllCountryInfo()
        
        var myArray=returnTextCategoryDict()
        print(myArray)
    }

    func returnAllInfo(completionHandler: @escaping ([String:[String:[String:[String:[String:String]]]]]) -> Void) {
        var tempAllInfo: [String:[String:[String:[String:[String:String]]]]]=[:]
        
        let allCountriesRef=Database.database().reference().child("countryInfo")
        
        allCountriesRef.observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            print("doing this")
            print(snapshot.value)
//            tempAllInfo = (snapshot.value as? [String:[String:[String:[String:[String:String]]]]])!
            tempAllInfo = (snapshot.value as? [String:[String:[String:[String:[String:String]]]]])!
            completionHandler(tempAllInfo)
        })
    }
    
    func returnTextCategoryDict() -> [String:[String:String]]{
        var textCategoryArray: [String:[String:String]]=[:]
        
        self.returnAllInfo{tempAllInfo in
            var countryName: String=UserDefaults.standard.string(forKey: "countryName")!
            var infoType: String=UserDefaults.standard.string(forKey: "infoType")!
            var countryTextArray: [String:[String:[String:String]]]=tempAllInfo[countryName]!["Text"]!
            textCategoryArray=countryTextArray[infoType]!
            
        }

        return textCategoryArray
    }
    
    func returnImageNameDict() -> [String:[String:String]]{
        var infoImageArray: [String:[String:String]]=[:]
        
        self.returnAllInfo{tempAllInfo in
            var countryName: String=UserDefaults.standard.string(forKey: "countryName")!
            var infoType: String=UserDefaults.standard.string(forKey: "infoType")!
            var countryImageNameArray: [String:[String:[String:String]]]=tempAllInfo[countryName]!["ImageNames"]!
            infoImageArray=countryImageNameArray[infoType]!
            
        }

        return infoImageArray
    }
    
    override func viewDidAppear(_ animated: Bool) {
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "countryController", sender: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        if(collectionView==allDeckCollectionView){
            let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "AllDecksCell", for: indexPath) as! AllDecksCell
                cell.layer.cornerRadius=10
                cell.regionLabel.adjustsFontSizeToFitWidth=true
                cell.regionImage.layer.cornerRadius=10
                return cell
        }else{
            let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "CompletedDecksCell", for: indexPath) as! CompletedDecksCell
                cell.layer.cornerRadius=10
                cell.regionLabel.adjustsFontSizeToFitWidth=true
                cell.regionImage.layer.cornerRadius=10
            
                return cell
        }
        
    }

}
