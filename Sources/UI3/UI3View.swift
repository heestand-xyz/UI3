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
    
    init(object: UI3Object) {
        
        view = SCNView()
        scene = SCNScene()
        
        super.init(frame: .zero)
        
        view.scene = scene
        view.backgroundColor = .clear
        view.autoenablesDefaultLighting = true
        view.allowsCameraControl = true
        addSubview(view)

        let frame = UI3Frame(origin: .zero, size: UI3Scale(x: 1.0, y: 1.0, z: 1.0))

        if UI3Defaults.debug {
            
//            view.debugOptions.insert(.showWireframe)
            view.showsStatistics = true
            
            let box = SCNBox(width: frame.size.x, height: frame.size.y, length: frame.size.z, chamferRadius: 0.0)
            if #available(iOS 11.0, *) {
                box.firstMaterial!.fillMode = .lines
            }
            box.firstMaterial!.isDoubleSided = true
            let boxNode = SCNNode(geometry: box)
            boxNode.position = frame.position.scnVector3
            scene.rootNode.addChildNode(boxNode)
            
        }
        
        let paddingFrame = frame.innerPadding(edges: object.paddingEdges, length: object.paddingLength)
        var framedSize = frame.size
        var framed = false
        if let w = object.width {
            framedSize.x = w
            framed = true
        }
        if let h = object.height {
            framedSize.y = h
            framed = true
        }
        if let l = object.length {
            framedSize.z = l
            framed = true
        }
        let finalFrame = framed ? UI3Frame(position: frame.position, size: framedSize) : paddingFrame
        scene.rootNode.addChildNode(object.node(frame: finalFrame))
        
        if UI3Defaults.boundingBox {
            let boundingBox = BoundingBox()
            let boundingBoxNode = boundingBox.node(frame: frame)
            scene.rootNode.addChildNode(boundingBoxNode)
        }
        
        let camera = SCNCamera()
        camera.zNear = 0.001
        camera.zFar = 10.0
        camera.usesOrthographicProjection = UI3Defaults.orthoCamera
        let cameraNode = SCNNode()
        cameraNode.camera = camera
        cameraNode.position = SCNVector3(frame.position.x, frame.position.y, 3.0)
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
