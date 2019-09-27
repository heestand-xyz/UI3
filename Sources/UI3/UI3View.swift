//
//  UI3View.swift
//  UI3
//
//  Created by Hexagons on 2019-09-27.
//

import SceneKit

@available(iOS 9.0, *)
public class UI3View: UIView {
    
    let view: SCNView
    let scene: SCNScene
    
    // MARK - Life Cycle
    
    init(objects: [UI3Object]) {
        
        view = SCNView()
        scene = SCNScene()
        
        super.init(frame: .zero)
        
        view.scene = scene
        view.backgroundColor = .clear
        view.autoenablesDefaultLighting = true
        view.allowsCameraControl = true
        addSubview(view)
        
        // DEBUG
//        view.debugOptions.insert(.showWireframe)
//        view.showsStatistics = true
        
        for object in objects {
            scene.rootNode.addChildNode(object.node)
        }
        scene.rootNode.addChildNode(BoundingBox().node)
        
        let camera = SCNCamera()
        camera.zNear = 0.001
        camera.zFar = 10.0
        let cameraNode = SCNNode()
        cameraNode.camera = camera
        cameraNode.position = SCNVector3(0.0, 0.0, 2.5)
        scene.rootNode.addChildNode(cameraNode)
        
        layout()
        
    }
    
    // MARK - Layout
    
    func layout() {
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        view.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        view.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        view.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
