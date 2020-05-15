//
//  SourcesVC.swift
//  World Culture Deck
//
//  Created by Audrey Ha on 2/16/20.
//  Copyright © 2020 AudreyHa. All rights reserved.
//

import UIKit
import FirebaseDatabase

class SourcesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var WCDLabel: UILabel!
    @IBOutlet weak var linksTableView: UITableView!
    @IBOutlet weak var linksHeaderLabel: UILabel!
    @IBOutlet weak var starCountLabel: UILabel!
    @IBOutlet weak var blueBackground: UIView!
    @IBOutlet weak var xButton: UIButton!
    @IBOutlet weak var starButton: UIButton!
    
    var countrySources:[String:[String:String]]=[:]
    var shortenedTitleArray: [String]! = []
    var linksArray: [String]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        WCDLabel.adjustsFontSizeToFitWidth=true
        
        StarService.displayStars(myLabel: starCountLabel)

        linksTableView.layer.cornerRadius=15
        
        var countryName=UserDefaults.standard.string(forKey: "countryName")!
        
        linksHeaderLabel.adjustsFontSizeToFitWidth=true
        linksHeaderLabel.text="\(countryName): Links/Sources"
        
        UIGraphicsBeginImageContext(blueBackground.frame.size)
        UIImage(named: "\(countryName)Background")?.draw(in: blueBackground.bounds)
        
        if let image = UIGraphicsGetImageFromCurrentImageContext(){
            UIGraphicsEndImageContext()
            blueBackground.backgroundColor = UIColor(patternImage: image.alpha(0.2))
        }
        
        self.returnAllSources{allSources in
            self.countrySources=allSources[countryName]!
        }
        
        xButton.accessibilityLabel="Close links page"
        xButton.accessibilityHint="Tap to go back to \(countryName) page"
        
        var myLabels=[WCDLabel, linksHeaderLabel, starCountLabel]
        
        for myLabel in myLabels{
            makeLabelAccessible(myLabel: myLabel!)
        }
        
        starButton.isAccessibilityElement=false
        starCountLabel.accessibilityLabel="\(UserDefaults.standard.integer(forKey: "numberStars")) stars"
    }
    
    func makeLabelAccessible(myLabel: UILabel){
        myLabel.adjustsFontForContentSizeCategory=true
        myLabel.adjustsFontSizeToFitWidth=true
        myLabel.font=UIFontMetrics.default.scaledFont(for: myLabel.font)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkNetwork()
        linksTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return countrySources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = linksTableView.dequeueReusableCell(withIdentifier: "LinksCell", for: indexPath) as! LinksCell
        
        cell.websiteLabel.adjustsFontForContentSizeCategory=true
        
        var numberWords=["zero","one","two","three","four","five","six","seven","eight","nine","ten","eleven","twelve","thirteen"]
        
        print("This is actually running")
        
        self.returnAllSources{allSources in
            var countryName=UserDefaults.standard.string(forKey: "countryName")!
            var countrySources=allSources[countryName]!
            
            
            
            for i in 0...numberWords.count-1{
                if(countrySources[numberWords[i]] != nil){
                    var oneItemArray=Array(countrySources[numberWords[i]]!.keys)
                    var shortenedTitle: String=Array(countrySources[numberWords[i]]!.keys)[0]
                    var longLink: String=countrySources[numberWords[i]]![shortenedTitle]!
                    
                    self.shortenedTitleArray.append(shortenedTitle)
                    self.linksArray.append(longLink)
                }
            }
            
            cell.websiteLabel.text=self.shortenedTitleArray[indexPath.row]
            
            cell.isAccessibilityElement=true
            cell.accessibilityTraits = .button
            cell.accessibilityLabel="\(self.shortenedTitleArray[indexPath.row]) Website"
            cell.accessibilityHint="Tap to go to webpage"
        }
        
        linksTableView.reloadRows(at: [indexPath], with: .automatic)
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var myLink=linksArray[indexPath.row]
        guard let url = URL(string: myLink) else { return }
        UIApplication.shared.open(url)
    }
    
    func returnAllSources(completionHandler: @escaping ([String:[String:[String:String]]]) -> Void) {
        print("Running return all sources")

        let sourcesRef=Database.database().reference().child("Sources")
        
        sourcesRef.observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as! NSDictionary
            let allSources=value as! [String:[String:[String:String]]]
            completionHandler(allSources)
        })
    }
    
    @IBAction func xPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
}
