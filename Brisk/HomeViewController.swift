//
//  HomeViewController.swift
//  AndroBar
//
//  Created by Ayush Singh on 11/12/18.
//  Copyright © 2018 Ayush Singh. All rights reserved.
//

import Cocoa

class HomeViewController: NSViewController {
    
    @IBOutlet var appsText: NSTextView!
    @IBOutlet var linksText: NSTextView!
    @IBOutlet weak var saveButton: NSButton!
    @IBOutlet weak var launchButton: NSButton!
    let defaults = UserDefaults.standard
    let controller = WindowController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButton.action = #selector(saveChanges)
        launchButton.action = #selector(launchAll)
        
        let appsListString = defaults.object(forKey: "homeApps") as? [String] ?? [String]()
        var apps = ""
        for app in appsListString {
            apps.append(contentsOf: app)
            apps.append(contentsOf: "\n")
        }
        apps = String(apps.dropLast())
        
        appsText.string = apps
        
        let urlListString = defaults.object(forKey: "homeLinks") as? [String] ?? [String]()
        var urls = ""
        for url in urlListString {
            urls.append(contentsOf: url)
            urls.append(contentsOf: "\n")
        }
        urls = String(urls.dropLast())
        
        linksText.string = urls
    }
    
    @objc func launchAll(_ sender: NSButton) {
        let appsListString = defaults.object(forKey: "homeApps") as? [String] ?? [String]()
        let urlListString = defaults.object(forKey: "homeLinks") as? [String] ?? [String]()
        controller.openApp(appsListString)
        controller.openLink(urlListString)
    }
    
    @objc func saveChanges(_ sender: NSButton) {
        var appsList = appsText.string.split(separator: "\n")
        var appsListString = [String]()
        
        for i in 0..<appsList.count {
            appsListString.append(String(appsList[i]).trimmingCharacters(in: .whitespacesAndNewlines))
        }
        
        var urlList = linksText.string.split(separator: "\n")
        var urlListString = [String]()
        
        for i in 0..<urlList.count {
            urlListString.append(String(urlList[i]).trimmingCharacters(in: .whitespacesAndNewlines))
        }
        
        defaults.set(appsListString, forKey: "homeApps")
        defaults.set(urlListString, forKey: "homeLinks")
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
}
