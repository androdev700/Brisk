//
//  WindowController.swift
//  AndroBar
//
//  Created by Ayush Singh on 11/12/18.
//  Copyright © 2018 Ayush Singh. All rights reserved.
//

import Cocoa

@available(OSX 10.12.2, *)
fileprivate extension NSTouchBar.CustomizationIdentifier {
    static let touchBar = NSTouchBar.CustomizationIdentifier("com.AndroBar.touchBar")
}

@available(OSX 10.12.2, *)
fileprivate extension NSTouchBarItem.Identifier {
    static let workStyle = NSTouchBarItem.Identifier("com.AndroBar.TouchBarItem.workStyle")
}

class WindowController: NSWindowController {
    
    let defaults = UserDefaults.standard
    
    override func windowDidLoad() {
        super.windowDidLoad()
        window?.title = "Brisk"
    }
    
    @objc func changeWorkModeBySegment(_ sender: NSSegmentedControl) {
        changeWorkMode(index: sender.selectedSegment)
    }
    
    func changeWorkMode(index: Int) {
        switch index {
        case 0:
            let appsListString = defaults.object(forKey: "homeApps") as? [String] ?? [String]()
            let urlListString = defaults.object(forKey: "homeLinks") as? [String] ?? [String]()
            openApp(appsListString)
            openLink(urlListString)
        case 1:
            let appsListString = defaults.object(forKey: "workApps") as? [String] ?? [String]()
            let urlListString = defaults.object(forKey: "workLinks") as? [String] ?? [String]()
            openApp(appsListString)
            openLink(urlListString)
        case 2:
            let appsListString = defaults.object(forKey: "ludacrisApps") as? [String] ?? [String]()
            let urlListString = defaults.object(forKey: "ludacrisLinks") as? [String] ?? [String]()
            openApp(appsListString)
            openLink(urlListString)
        default:
            print("invalid selection")
        }
    }
    
    func openApp(_ names: [String]) {
        for name in names {
            NSWorkspace.shared.launchApplication(_:name)
        }
    }
    
    func openLink(_ links: [String]) {
        for link in links {
            if let url = URL(string: link),
                NSWorkspace.shared.open(url) {
            }
        }
    }
    
    @available(OSX 10.12.2, *)
    override func makeTouchBar() -> NSTouchBar? {
        let touchBar = NSTouchBar()
        touchBar.delegate = self
        touchBar.customizationIdentifier = .touchBar
        touchBar.defaultItemIdentifiers = [.workStyle, NSTouchBarItem.Identifier.otherItemsProxy]
        touchBar.customizationAllowedItemIdentifiers = [.workStyle]
        return touchBar
    }
}

extension WindowController: NSTouchBarDelegate {
    @available(OSX 10.12.2, *)
    func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItem.Identifier) -> NSTouchBarItem? {
        switch identifier {
        case NSTouchBarItem.Identifier.workStyle:
            let fontStyleItem = NSCustomTouchBarItem(identifier: identifier)
            fontStyleItem.customizationLabel = "Font Style"
            let fontStyleSegment = NSSegmentedControl(labels: ["Home 🏠", "Work 🏢", "Ludacris 😎"], trackingMode: .momentary, target: self, action: #selector(changeWorkModeBySegment))
            fontStyleItem.view = fontStyleSegment
            return fontStyleItem
        default: return nil
        }
    }
}
