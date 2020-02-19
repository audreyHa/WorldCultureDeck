//
//  NLI_SourceVC.swift
//  World Culture Deck
//
//  Created by Audrey Ha on 2/18/20.
//  Copyright © 2020 AudreyHa. All rights reserved.
//

import UIKit

class NLI_SourceVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var WCDLabel: UILabel!
    @IBOutlet weak var linksTableView: UITableView!
    @IBOutlet weak var linksHeaderLabel: UILabel!
    @IBOutlet weak var starCountLabel: UILabel!
    @IBOutlet weak var blueBackground: UIView!
    
    var countrySources:[String:[String:String]]=[:]
    var shortenedTitleArray: [String]! = []
    var linksArray: [String]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        WCDLabel.adjustsFontSizeToFitWidth=true
        
        linksTableView.layer.cornerRadius=15
        
        var countryName=UserDefaults.standard.string(forKey: "NLI_countryName")!
        
       linksHeaderLabel.adjustsFontSizeToFitWidth=true
        linksHeaderLabel.text="\(countryName): Links/Sources"
        
        UIGraphicsBeginImageContext(blueBackground.frame.size)
        UIImage(named: "\(countryName)Background")?.draw(in: blueBackground.bounds)
        
        if let image = UIGraphicsGetImageFromCurrentImageContext(){
            UIGraphicsEndImageContext()
            blueBackground.backgroundColor = UIColor(patternImage: image.alpha(0.2))
        }
        
        let allSources:[String:[String:[String:String]]]=InfoService.returnSources()
        countrySources=allSources[countryName]!

        var numberWords=["zero","one","two","three","four","five","six","seven","eight","nine","ten","eleven","twelve","thirteen"]

        for i in 0...numberWords.count-1{
            if(countrySources[numberWords[i]] != nil){
                var oneItemArray=Array(countrySources[numberWords[i]]!.keys)
                var shortenedTitle: String=Array(countrySources[numberWords[i]]!.keys)[0]
                var longLink: String=countrySources[numberWords[i]]![shortenedTitle]!
                
                self.shortenedTitleArray.append(shortenedTitle)
                self.linksArray.append(longLink)
            }
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        linksTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return countrySources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = linksTableView.dequeueReusableCell(withIdentifier: "LinksCell", for: indexPath) as! LinksCell

        cell.websiteLabel.text=self.shortenedTitleArray[indexPath.row]
        
        linksTableView.reloadRows(at: [indexPath], with: .automatic)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var myLink=linksArray[indexPath.row]
        guard let url = URL(string: myLink) else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction func xPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
}
