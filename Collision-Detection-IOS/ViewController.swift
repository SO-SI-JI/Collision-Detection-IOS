//
//  ViewController.swift
//  Collision-Detection-IOS
//
//  Created by YJSAIR on 2021/12/01.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    @IBOutlet var lblxVal: UILabel!
    @IBOutlet var lblyVal: UILabel!
    @IBOutlet var lblzVal: UILabel!
    
    let motion = CMMotionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.motion.isAccelerometerAvailable{
            self.motion.accelerometerUpdateInterval = 1.0 / 60.0
            self.motion.startAccelerometerUpdates()
            
            let timer = Timer(fire: Date(), interval: (1.0/60.0), repeats: true, block: { (timer) in
                if let data = self.motion.accelerometerData {
                    let val_x = data.acceleration.x
                    let val_y = data.acceleration.y
                    let val_z = data.acceleration.z
                    
                    if val_x > 8 {
                        print("충돌 감지 : X가 8 넘음")
                        print("X : \(val_x)")
                    }
                    else if val_y > 8 {
                        print("충돌 감지 : Y가 8 넘음")
                        print("Y : \(val_y)")
                    }
                    else if val_z > 8 {
                        print("충돌 감지 : Z가 8 넘음")
                        print("Z : \(val_z)")
                    }
                    
                    self.lblxVal.text = String(format: "%.2f", val_x)
                    self.lblyVal.text = String(format: "%.2f", val_y)
                    self.lblzVal.text = String(format: "%.2f", val_z)
                }
            })
            RunLoop.current.add(timer, forMode: RunLoop.Mode.default)
        }
    }


}

