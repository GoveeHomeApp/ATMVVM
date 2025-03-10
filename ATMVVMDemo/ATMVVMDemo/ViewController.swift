//
//  ViewController.swift
//  ATMVVMDemo
//
//  Created by abiaoyo on 2025/1/16.
//

import UIKit

public class Geometry {
    
    static var screenRate: CGFloat {
        return min(screenWidth, screenHeight) / 375.0
    }
    
    static var maxScreenRate: CGFloat {
        return max(screenRate, 1.0)
    }
    
    public static var screenHeight: CGFloat {
        return UIScreen.main.bounds.size.height
    }
    
    public static var screenWidth: CGFloat {
        return UIScreen.main.bounds.size.width
    }
}

public extension CGFloat {
    var rate: CGFloat { self * Geometry.screenRate }
    
    func roundTo(places:Int) -> CGFloat {
        
        let divisor = pow(10.0, Double(places))
        
        return (self * divisor).rounded() / divisor
        
    }
}

public extension Double {
    var rate: CGFloat { CGFloat(self) * Geometry.screenRate }
    
    /// Rounds the double to decimal places value
    
    func roundTo(places:Int) -> Double {
        
        let divisor = pow(10.0, Double(places))
        
        return (self * divisor).rounded() / divisor
        
    }
}


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isTranslucent = false
    }
    @IBAction func clickCollection(_ sender: Any) {
        let vctl = Demo3ViewControlelr()
        self.navigationController?.pushViewController(vctl, animated: true)
    }
    
    @IBAction func clickTable(_ sender: Any) {
        let vctl = Demo2ViewController()
        self.navigationController?.pushViewController(vctl, animated: true)
    }
    
}

