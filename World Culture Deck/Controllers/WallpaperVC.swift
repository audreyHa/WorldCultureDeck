//
//  WallpaperVC.swift
//  World Culture Deck
//
//  Created by Audrey Ha on 12/30/19.
//  Copyright © 2019 AudreyHa. All rights reserved.
//

import UIKit
import FirebaseDatabase

class WallpaperVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{

    @IBOutlet weak var blueBackground: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var WCDLabel: UILabel!
    @IBOutlet weak var starCountLabel: UILabel!
    @IBOutlet weak var starButton: UIButton!
    
    var collectionViewFlowLayout: UICollectionViewFlowLayout!
    
    var badgeNames: [String]=[]
    var badgesNamesLocked: [String]=[]
    var badgeTitles: [String]=[]
    var lockedStatus: [Bool]=[]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        
        WCDLabel.adjustsFontSizeToFitWidth=true
        UIGraphicsBeginImageContext(blueBackground.frame.size)
        UIImage(named: "0_FlagCollage")?.draw(in: blueBackground.bounds)
        
        if let image = UIGraphicsGetImageFromCurrentImageContext(){
            UIGraphicsEndImageContext()
            blueBackground.backgroundColor = UIColor(patternImage: image.alpha(0.2))
        }
        
        badgeNames=["100_badge","200_badge","300_badge"]
        badgesNamesLocked=["100_badge_lock","200_badge_lock","300_badge_lock"]
        badgeTitles=["100 Stars","200 Stars","300 Stars"]
        lockedStatus=[true, true, true]
        
        StarService.displayStars(myLabel: starCountLabel)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateBadgeCollectionView(notification:)), name: Notification.Name("updateBadgeCollectionView"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.saveBadgeImage(notification:)), name: Notification.Name("saveBadgeImage"), object: nil)
        
        starButton.isAccessibilityElement=false
        starCountLabel.accessibilityLabel="\(UserDefaults.standard.integer(forKey: "numberStars")) stars"
    }
    
    @objc func saveBadgeImage(notification: Notification) {
        var badgeImageIndex=UserDefaults.standard.integer(forKey: "badgeImageIndex")
        if(lockedStatus[badgeImageIndex]==false){
            let badgeBackground=["100_badge_background","200_badge_background","300_badge_background"]
            UIImageWriteToSavedPhotosAlbum(UIImage(named:badgeBackground[badgeImageIndex])!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        }else{
            UserDefaults.standard.set("needToUnlock",forKey: "typeShortAlert")
            makeShortAlert()
        }
    }
    
    @objc func updateBadgeCollectionView(notification: Notification) {
        collectionView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkNetwork()
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
        let height=width*1.2
        
        collectionViewFlowLayout=UICollectionViewFlowLayout()
        collectionViewFlowLayout.itemSize=CGSize(width: width, height: height)
        collectionViewFlowLayout.sectionInset=UIEdgeInsets.zero
        collectionViewFlowLayout.scrollDirection = .vertical
        collectionViewFlowLayout.minimumLineSpacing=lineSpacing
        collectionViewFlowLayout.minimumInteritemSpacing=interItemSpacing
        
        collectionView.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "WallpaperCell", for: indexPath) as! WallpaperCell
        cell.layer.cornerRadius=10
        cell.regionLabel.adjustsFontSizeToFitWidth=true
        cell.wallpaperImageView.layer.cornerRadius=10
        cell.regionLabel.text=badgeTitles[indexPath.row]
        
        self.returnBadgesDict{badgesDict in
            if(badgesDict[self.badgeTitles[indexPath.row]] != nil && badgesDict[self.badgeTitles[indexPath.row]]==true){
                cell.wallpaperImageView.image=UIImage(named: self.badgeNames[indexPath.row])
                self.lockedStatus[indexPath.row]=false
            }else{
                cell.wallpaperImageView.image=UIImage(named: self.badgesNamesLocked[indexPath.row])
                self.lockedStatus[indexPath.row]=true
            }
            
        }
        
        cell.downloadButton.accessibilityLabel="Download \(cell.regionLabel.text!) Badge"
        cell.downloadButton.accessibilityHint="You currently have \(UserDefaults.standard.integer(forKey: "numberStars")) stars."
        
        cell.wallpaperImageView.isAccessibilityElement=false
        
        return cell
    }
    
    //saving badge image to user's photo library
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(lockedStatus[indexPath.row]==false){
            let badgeBackground=["100_badge_background","200_badge_background","300_badge_background"]
            UIImageWriteToSavedPhotosAlbum(UIImage(named:badgeBackground[indexPath.row])!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        }else{
            UserDefaults.standard.set("needToUnlock",forKey: "typeShortAlert")
            makeShortAlert()
        }
        
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            UserDefaults.standard.set("errorSaving",forKey: "typeShortAlert")
            makeShortAlert()
        } else {
            UserDefaults.standard.set("savedSuccess",forKey: "typeShortAlert")
            makeShortAlert()
        }
    }
    
    func returnBadgesDict(completionHandler: @escaping ([String:Bool]) -> Void) {
        print("Running return badges")
        var badgesDict: [String:Bool]=[:]
        
        let badgesRef=Database.database().reference().child("users").child(User.current.uid).child("Badges")
        let userRef=Database.database().reference().child("users").child(User.current.uid)
        
        userRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.hasChild("Badges"){
                badgesRef.observeSingleEvent(of: .value, with: { (snapshot) in
                        badgesDict=snapshot.value as! [String:Bool]
                        completionHandler(badgesDict)
                })
            }else{
                print("Need to add badges")
                badgesRef.setValue(["Some Badge":false]){(error, _) in
                    badgesDict=["Some Badge":false]
                    completionHandler(badgesDict)
                    if let error=error{
                        assertionFailure(error.localizedDescription)
                    }
                }
            }
        })
    }
    
}

