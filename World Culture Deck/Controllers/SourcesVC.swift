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

    @IBOutlet weak var linksTableView: UITableView!
    @IBOutlet weak var linksHeaderLabel: UILabel!
    @IBOutlet weak var starCountLabel: UILabel!
    
    var countrySources:[String:[String:String]]=[:]
    var shortenedTitleArray: [String]! = []
    var linksArray: [String]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        StarService.displayStars(myLabel: starCountLabel)

        linksTableView.layer.cornerRadius=15
        
        var countryName=UserDefaults.standard.string(forKey: "countryName")!
        linksHeaderLabel.text="\(countryName): Links/Sources"
        
        self.returnAllSources{allSources in
            self.countrySources=allSources[countryName]!
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        linksTableView.estimatedRowHeight = 100
        linksTableView.rowHeight = UITableView.automaticDimension
        linksTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return countrySources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = linksTableView.dequeueReusableCell(withIdentifier: "LinksCell", for: indexPath) as! LinksCell
        
        var numberWords=["zero","one","two","three","four","five","six","seven","eight","nine","ten","eleven","twelve","thirteen"]
        
        print("This is actually running")
        
        self.returnAllSources{allSources in
            var countryName=UserDefaults.standard.string(forKey: "countryName")!
            var countrySources=allSources[countryName]!
            
            
            
            for i in 0...numberWords.count-1{
                if(countrySources[numberWords[i]] != nil){
                    var oneItemArray=Array(countrySources[numberWords[i]]!.keys)
                    print(oneItemArray)
                    var shortenedTitle: String=Array(countrySources[numberWords[i]]!.keys)[0]
                    var longLink: String=countrySources[numberWords[i]]![shortenedTitle]!
                    
                    self.shortenedTitleArray.append(shortenedTitle)
                    self.linksArray.append(longLink)
                }
            }
            
            cell.websiteLabel.text=self.shortenedTitleArray[indexPath.row]
        }
        
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
