//
//  ViewController.swift
//  Demo
//
//  Created by Jie Zhang on 17/9/17.
//  Copyright © 2017 Jie Zhang. All rights reserved.
//

import UIKit
import fpingx

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        fpingx.ping(hosts: ["google.com", "baidu.com", "apple.com", "abc.a"], backoff: 1, count: 5) { (result) in
            print(result)
        }
    }

    @IBAction func test(_ sender: Any) {
        fpingx.ping(hosts: ["google.com", "baidu.com", "apple.com", "abc.a"], backoff: 1, count: 5) { (result) in
            print(result)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

