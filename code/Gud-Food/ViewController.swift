//
//  ViewController.swift
//  Gud-Food
//
//  Created by Amauri Lopez on 11/29/17.
//  Copyright © 2017 Amauri Lopez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var OpenNavTab: UIBarButtonItem!
    //var varView = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        OpenNavTab.target = self.revealViewController()
        OpenNavTab.action = #selector(SWRevealViewController.revealToggle(_:))
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

