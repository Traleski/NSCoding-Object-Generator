//
//  AppDelegate.swift
//  NSCodingObjectGeneratorOSX
//
//  Created by Pablo Henemann on 09/12/15.
//  Copyright (c) 2015 Pablo Henemann. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!


    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Swap in our view controller in the window's content view
        let generator = Generator()
        // Resize view controller to content view's current size
        generator.view.frame = self.window.contentView.frame
        // Add resizing flags to make the view controller resize with the window
//        generator.view.autoresizingMask = (.ViewWidthSizable|.ViewHeightSizable)
        // Add in the core graphics view controller as subview
        self.window.contentView.addSubview(generator.view)
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

