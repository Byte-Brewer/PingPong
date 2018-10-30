//
//  GameViewController.swift
//  Pong
//
//  Created by Nazar Prysiazhnyi on 10/26/18.
//  Copyright © 2018 Nazar Prysiazhnyi. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import ReplayKit

class GameViewController: UIViewController {
    
    let cameraController = CameraController()
    let recorder = RPScreenRecorder.shared()
    
    @IBOutlet weak var cameraView: UIView!
    
    @IBOutlet weak var gameView: SKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let view = self.gameView {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                scene.backgroundColor = UIColor.clear
        
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
        }
        
        // turn on Microphone
        recorder.isMicrophoneEnabled = true
    }

    
    @IBAction func openCamera(_ sender: UIButton) {
        DispatchQueue.global().async {
            self.configureCameraController()
        }
    }
    
    @IBAction func rec(_ sender: UIButton) {
        if !recorder.isRecording {
            recorder.startRecording { (error) in
                guard error != nil else { return }
                self.alert(message: error.debugDescription)
            }
        } else { alert(message: "ScreenRecord is active") }
    }
    
    @IBAction func stop(_ sender: UIButton) {
        if recorder.isRecording {
            recorder.stopRecording { (previewVC, error) in
                if let previewVC = previewVC {
                    previewVC.previewControllerDelegate = self
                    self.present(previewVC, animated: true, completion: nil)
                }
                
                if let error = error  {
                    print("Error", error.localizedDescription)
                    self.alert(message: error.localizedDescription)
                }
            }
        }
    }
    
    
    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    private func configureCameraController() {
        cameraController.prepare {(error) in
            if let error = error {
                print(error)
                self.alert(message: error.localizedDescription)
            }
            try? self.cameraController.displayPreview(on: self.cameraView)
        }
    }
    
    func alert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
        let actionOk = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(actionOk)
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK:- RPPreviewViewControllerDelegate
extension GameViewController: RPPreviewViewControllerDelegate {
    func previewControllerDidFinish(_ previewController: RPPreviewViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    func previewController(_ previewController: RPPreviewViewController, didFinishWithActivityTypes activityTypes: Set<String>) {
        self.dismiss(animated: true, completion: nil)
    }
}
