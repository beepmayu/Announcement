//
//  WebviewController.swift
//  Announcement
//
//  Created by Mayu on 16/11/17.
//  Copyright © 2017 Mayu. All rights reserved.
//

import Foundation
import UIKit

class WebviewController: UIViewController {
    
    @IBOutlet weak var webview1: UIWebView!
    
    override func viewDidLoad() {
        self.webview1.loadHTMLString(DataManager.shared.selectedAnnoucement!.html ?? "", baseURL: nil)
    }
}
