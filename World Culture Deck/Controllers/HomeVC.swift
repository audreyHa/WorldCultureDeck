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
    var countryNames: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countryNames=["Ghana","Lebanon","Mexico","Navajo Nation","Norway","Roma","South Africa","South Korea","Tonga"]
        
        setupCollectionView()
        StarService.displayStars(myLabel: starLabel)
        InfoService.insertAllCountryInfo()
        
        var someArray=returnTextCategoryDict()
        print(someArray)
    }
    
    func returnAllInfo(completionHandler: @escaping ([String:Any]) -> Void) {
        print("I am running returnAllInfo")
        var tempAllInfo: [String:Any]=[:]
        
        let allCountriesRef=Database.database().reference().child("countryInfo")
        
        allCountriesRef.observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as! NSDictionary
            tempAllInfo=value as! [String:Any]
            
            completionHandler(tempAllInfo)
        })
    }
    
    func returnTextCategoryDict() -> [String:[String:String]]{
        print("I am running returnTextCategoryDict")
        var textCategoryArray: [String:[String:String]]=[:]
        
        self.returnAllInfo{tempAllInfo in
            var countryName: String=UserDefaults.standard.string(forKey: "countryName")!
            var infoType: String=UserDefaults.standard.string(forKey: "infoType")!
            var countryArray: [String:Any]=tempAllInfo[countryName]! as! [String : Any]
            var countryTextArray: [String:Any]=countryArray["Text"]! as! [String : Any]
            textCategoryArray=countryTextArray[infoType]! as! [String : [String : String]]
        }

        return textCategoryArray
    }
    
    func returnImageNameDict() -> [String:[String:String]]{
        print("I am running returnImageNameDict")
        var infoImageArray: [String:[String:String]]=[:]
        
        self.returnAllInfo{tempAllInfo in
            var countryName: String=UserDefaults.standard.string(forKey: "countryName")!
            var infoType: String=UserDefaults.standard.string(forKey: "infoType")!
            var countryArray: [String:Any]=tempAllInfo[countryName]! as! [String : Any]
            var countryImageNameArray: [String:Any]=countryArray["ImageNames"]! as! [String : Any]
            infoImageArray=countryImageNameArray[infoType]! as! [String : [String : String]]
            
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
            return 9
        }else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var countryName=countryNames[indexPath.row]
        UserDefaults.standard.set(countryName, forKey:"countryName")
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
