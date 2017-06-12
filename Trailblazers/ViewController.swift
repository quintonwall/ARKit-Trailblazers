//
//  ViewController.swift
//  Trailblazers
//
//  Created by QUINTON WALL on 6/9/17.
//  Copyright © 2017 me.quinton. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/BackpackTraveller.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
        sceneView.allowsCameraControl = true
        
        let buyButton = UIButton(type: UIButtonType.custom)
        //buyButton.titleLabel?.font = UIFont(name: "Trailhead Bold", size: 20)
        buyButton.titleLabel?.font = UIFont(name: buyButton.titleLabel!.font!.familyName, size: 20)
        buyButton.setTitle("Buy", for: UIControlState.normal)
        let borderAlpha : CGFloat = 1.0
        let cornerRadius : CGFloat = 5.0
        buyButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        
        buyButton.frame = CGRect(x:20, y:30, width:100, height:50)
        buyButton.layer.borderWidth = 2.0
        buyButton.layer.borderColor = UIColor(white: 1.0, alpha: borderAlpha).cgColor
        buyButton.layer.cornerRadius = cornerRadius
         sceneView.addSubview(buyButton)
        buyButton.addTarget(self, action:#selector(self.buyClicked), for: .touchUpInside)
        buyButton.adjustsImageWhenHighlighted = false
        
        let cancelButton = UIButton(type: UIButtonType.custom)
        cancelButton.titleLabel?.font = UIFont(name: cancelButton.titleLabel!.font!.familyName, size: 20)
        cancelButton.setTitle("Cancel", for: UIControlState.normal)
        cancelButton.setTitleColor(UIColor.red, for: UIControlState.normal)
        
        cancelButton.frame = CGRect(x:150, y:30, width:100, height:50)
        cancelButton.layer.borderWidth = 2.0
        cancelButton.layer.borderColor = UIColor.red.cgColor
        cancelButton.layer.cornerRadius = cornerRadius
        sceneView.addSubview(cancelButton)
        cancelButton.addTarget(self, action:#selector(self.cancelClicked), for: .touchUpInside)
        cancelButton.adjustsImageWhenHighlighted = false
        
        
        
    }
    
    @objc func buyClicked(sender : UIButton) {
        print("clicked")
    }
    
    @objc func cancelClicked(sender : UIButton) {
        print("cancel clicked")
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingSessionConfiguration()
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
