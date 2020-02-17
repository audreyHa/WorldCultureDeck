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
    @IBOutlet weak var completedDecksLabel: UILabel!
    
    var collectionViewFlowLayout: UICollectionViewFlowLayout!
    var completedNames: [String]!
    var incompletedNames: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        StarService.displayStars(myLabel: starLabel)
        InfoService.insertAllCountryInfo()
        
        var hasSetUpCompletedCountries=UserDefaults.standard.bool(forKey: "hasSetUpCompletedCountries")
        if(hasSetUpCompletedCountries==nil || hasSetUpCompletedCountries==false){
            InfoService.setUpCompletedCountries()
            UserDefaults.standard.set(true, forKey: "hasSetUpCompletedCountries")
        }
        
        var allNames=["Ghana","Lebanon","Mexico","Navajo Nation","Norway","Peru","Roma","South Africa","South Korea","Tonga"]
        
        self.incompletedNames=allNames
        self.completedNames=[]
        
        self.returnCompletedDict{completedCountries in
            print("getting completed decks on viewDidLoad")
            self.incompletedNames=[]
            for countryName in allNames{
                if(completedCountries[countryName] != nil && completedCountries[countryName]==true){
                    self.completedNames.append(countryName)
                }else{
                    self.incompletedNames.append(countryName)
                }
            }
            
            self.completedDecksLabel.text="Completed Decks: \(self.completedNames.count)/\(self.completedNames.count+self.incompletedNames.count)"
            self.setupCollectionView()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.newDeckCompleted(notification:)), name: Notification.Name("newDeckCompleted"), object: nil)
        
    }
    
    @objc func newDeckCompleted(notification: Notification) {
        print("objc func for new deck completed!")
        var allNames=["Ghana","Lebanon","Mexico","Navajo Nation","Norway","Peru","Roma","South Africa","South Korea","Tonga"]
        
        self.incompletedNames=allNames
        self.completedNames=[]
        
        self.returnCompletedDict{completedCountries in
            print("return completed dict")
            self.incompletedNames=[]
            
            for countryName in allNames{
                if(completedCountries[countryName] != nil && completedCountries[countryName]==true){
                    self.completedNames.append(countryName)
                }else{
                    self.incompletedNames.append(countryName)
                }
            }
            print("Completed names: \(self.completedNames)")
            print("Incompleted names: \(self.incompletedNames)")
            
            self.completedDecksLabel.text="Completed Decks: \(self.completedNames.count)/\(self.completedNames.count+self.incompletedNames.count)"
            
            self.allDeckCollectionView.reloadData()
            self.completedCollectionView.reloadData()
        }
    }
    
    func returnCompletedDict(completionHandler: @escaping ([String:Bool]) -> Void) {
        print("Running return completed names")
        var completedCountries: [String:Bool]=[:]
        
        let completedCountryRef=Database.database().reference().child("users").child(User.current.uid).child("Completed Countries")
        
        completedCountryRef.observeSingleEvent(of: .value, with: { (snapshot) in
                completedCountries=snapshot.value as! [String:Bool]
                completionHandler(completedCountries)
        })
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
        if(collectionView==allDeckCollectionView){ //incompleted
            return incompletedNames.count
        }else{ //completed
            return completedNames.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(collectionView==allDeckCollectionView){ //incompleted deck
            var countryName=incompletedNames[indexPath.row]
            UserDefaults.standard.set(countryName, forKey:"countryName")
            performSegue(withIdentifier: "countryController", sender: nil)
        }else{ //completed deck
            var countryName=completedNames[indexPath.row]
            UserDefaults.standard.set(countryName, forKey:"countryName")
            performSegue(withIdentifier: "countryController", sender: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        if(collectionView==allDeckCollectionView){ //incompleted deck
            let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "AllDecksCell", for: indexPath) as! AllDecksCell
                cell.layer.cornerRadius=10
            
                cell.regionLabel.adjustsFontSizeToFitWidth=true
                cell.regionLabel.text=incompletedNames[indexPath.row]
            
                cell.regionImage.layer.cornerRadius=10
                cell.regionImage.image=UIImage(named: "\(incompletedNames[indexPath.row])Cover")
            
                return cell
        }else{ //completed deck
            let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "CompletedDecksCell", for: indexPath) as! CompletedDecksCell
                cell.layer.cornerRadius=10
            
                cell.regionLabel.adjustsFontSizeToFitWidth=true
                cell.regionLabel.text=completedNames[indexPath.row]
            
            
                cell.regionImage.layer.cornerRadius=10
                cell.regionImage.image=UIImage(named: "\(completedNames[indexPath.row])Cover")
            
                return cell
        }
        
    }

}
