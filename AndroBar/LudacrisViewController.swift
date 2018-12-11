//
//  LudacrisViewController.swift
//  AndroBar
//
//  Created by Ayush Singh on 11/12/18.
//  Copyright © 2018 Ayush Singh. All rights reserved.
//

import Cocoa

class LudacrisViewController: NSViewController {
    
    @IBOutlet var appsText: NSTextView!
    @IBOutlet var linksText: NSTextView!
    @IBOutlet weak var saveButton: NSButton!
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButton.action = #selector(saveChanges)
        
        let appsListString = defaults.object(forKey: "ludacrisApps") as? [String] ?? [String]()
        var apps = ""
        for app in appsListString {
            apps.append(contentsOf: app)
            apps.append(contentsOf: ",")
        }
        apps = String(apps.dropLast())
        
        appsText.string = apps
        
        let urlListString = defaults.object(forKey: "ludacrisLinks") as? [String] ?? [String]()
        var urls = ""
        for url in urlListString {
            urls.append(contentsOf: url)
            urls.append(contentsOf: ",")
        }
        urls = String(urls.dropLast())
        
        linksText.string = urls
    }
    
    @objc func saveChanges(_ sender: NSButton) {
        var appsList = appsText.string.split(separator: ",")
        var appsListString = [String]()
        
        for i in 0..<appsList.count {
            appsListString.append(String(appsList[i]).trimmingCharacters(in: .whitespacesAndNewlines))
        }
        
        var urlList = linksText.string.split(separator: ",")
        var urlListString = [String]()
        
        for i in 0..<urlList.count {
            urlListString.append(String(urlList[i]).trimmingCharacters(in: .whitespacesAndNewlines))
        }
        
        defaults.set(appsListString, forKey: "ludacrisApps")
        defaults.set(urlListString, forKey: "ludacrisLinks")
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
}
