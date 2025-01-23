//
//  ViewController.swift
//  ATMVVMDemo
//
//  Created by abiaoyo on 2025/1/16.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isTranslucent = false
    }
    @IBAction func clickCollection(_ sender: Any) {
        let vctl = Demo1ViewControlelr()
        self.navigationController?.pushViewController(vctl, animated: true)
    }
    
    @IBAction func clickTable(_ sender: Any) {
        let vctl = Demo2ViewController()
        self.navigationController?.pushViewController(vctl, animated: true)
    }
    
}

