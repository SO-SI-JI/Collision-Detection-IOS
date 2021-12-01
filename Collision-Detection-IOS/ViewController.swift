//
//  ViewController.swift
//  Collision-Detection-IOS
//
//  Created by YJSAIR on 2021/12/01.
//

import UIKit
import CoreMotion
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet var lblxVal: UILabel!
    @IBOutlet var lblyVal: UILabel!
    @IBOutlet var lblzVal: UILabel!
    @IBOutlet var lblRecentx: UILabel!
    @IBOutlet var lblRecenty: UILabel!
    @IBOutlet var lblRecentz: UILabel!
    
    let motion = CMMotionManager()
    var audioPlayer : AVAudioPlayer!
    var audioFile : URL!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioFile = Bundle.main.url(forResource: "Blop Sound", withExtension: "mp3")
        initPlay()
        
        lblRecentx.text = "0"
        lblRecenty.text = "0"
        lblRecentz.text = "0"
        
        if self.motion.isAccelerometerAvailable{
            self.motion.accelerometerUpdateInterval = 1.0 / 60.0
            self.motion.startAccelerometerUpdates()
            
            let timer = Timer(fire: Date(), interval: (1.0/60.0), repeats: true, block: { (timer) in
                if let data = self.motion.accelerometerData {
                    let val_x = data.acceleration.x
                    let val_y = data.acceleration.y
                    let val_z = data.acceleration.z
                    
                    if val_x > 8 || val_y > 8 || val_z > 8{
                        print("충돌 감지")
                        print("X : \(val_x) Y : \(val_y) Z : \(val_z)")
                        
                        self.lblRecentx.text = String(format: "%.2f",val_x)
                        self.lblRecenty.text = String(format: "%.2f",val_y)
                        self.lblRecentz.text = String(format: "%.2f",val_z)
                        
                        self.audioPlayer.play()
                    }
                    
                    self.lblxVal.text = String(format: "%.2f", val_x)
                    self.lblyVal.text = String(format: "%.2f", val_y)
                    self.lblzVal.text = String(format: "%.2f", val_z)
                }
            })
            RunLoop.current.add(timer, forMode: RunLoop.Mode.default)
        }
    }
    func initPlay(){
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: audioFile)
        } catch let error as NSError{
            print("Error Initial Play")
        }
        audioPlayer.prepareToPlay()
    }

}

