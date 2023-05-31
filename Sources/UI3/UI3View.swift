//
//  UI3View.swift
//  UI3
//
//  Created by Hexagons on 2019-09-27.
//

import SceneKit

@available(iOS 9.0, *)
public class UI3View: _View {
    
    let view: SCNView
    let scene: SCNScene
    
    let object: UI3Object
    
    let globalFrame: UI3Frame
    var objectFrame: UI3Frame!
    
    // MARK - Life Cycle
    
    init(object: UI3Object) {
        
        view = SCNView()
        scene = SCNScene()
        
        self.object = object
        
        globalFrame = UI3Frame(origin: .zero, size: .one)

        super.init(frame: .zero)
        
        view.scene = scene
        view.backgroundColor = .clear
        view.autoenablesDefaultLighting = true
        view.allowsCameraControl = true
        addSubview(view)

        if UI3Defaults.debug {
            
//            view.debugOptions.insert(.showWireframe)
            view.showsStatistics = true
            
            let box = SCNBox(width: globalFrame.size.x, height: globalFrame.size.y, length: globalFrame.size.z, chamferRadius: 0.0)
            box.firstMaterial!.fillMode = .lines
            box.firstMaterial!.isDoubleSided = true
            let boxNode = SCNNode(geometry: box)
            boxNode.position = globalFrame.position.scnVector3
            scene.rootNode.addChildNode(boxNode)
            
        }
                
        let paddingFrame = globalFrame.innerPadding(edges: object.paddingEdges, length: object.paddingLength)
        var framedSize = globalFrame.size
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
        let preFrame = framed ? UI3Frame(position: globalFrame.position, size: framedSize) : paddingFrame
        let postSize = UI3Size(x: Box.getSize(on: .x, for: object, in: preFrame.size) ?? preFrame.size.x,
                               y: Box.getSize(on: .y, for: object, in: preFrame.size) ?? preFrame.size.y,
                               z: Box.getSize(on: .z, for: object, in: preFrame.size) ?? preFrame.size.z)
        let postFrame = UI3Frame(position: preFrame.position, size: postSize)
        objectFrame = postFrame
        scene.rootNode.addChildNode(object.node(frame: objectFrame))
        
        if UI3Defaults.boundingBox {
            let boundingBox = BoundingBox()
            let boundingBoxNode = boundingBox.node(frame: globalFrame)
            scene.rootNode.addChildNode(boundingBoxNode)
        }
        
        let camera = SCNCamera()
        camera.zNear = 0.001
        camera.zFar = 10.0
        camera.usesOrthographicProjection = UI3Defaults.orthoCamera
        let cameraNode = SCNNode()
        cameraNode.camera = camera
        cameraNode.position = SCNVector3(globalFrame.position.x, globalFrame.position.y, 3.0)
        scene.rootNode.addChildNode(cameraNode)
        
        setupLayout()
        
    }
    
    // MARK - Layout
    
    func setupLayout() {
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        view.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        view.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        view.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        
    }
    
    // MARK: - Objects
    
    func allObjects() -> [any UI3Object] {
        var objects: [any UI3Object] = []
        func traverse(_ object: UI3Object) {
            objects.append(object)
            if let modifier = object as? UI3Modifier {
                for childObject in modifier.objects {
                    traverse(childObject)
                }
            }
        }
        traverse(object)
        return objects
    }
    
    func allFrames() -> [UI3Frame] {
        var frames: [UI3Frame] = []
        func traverse(_ object: UI3Object, in frame: UI3Frame) {
            frames.append(frame)
            if let modifier = frame as? UI3Modifier {
                let childFrames = modifier.frames(in: frame)
                for (i, childObject) in modifier.objects.enumerated() {
                    traverse(childObject, in: childFrames[i])
                }
            }
        }
        traverse(object, in: objectFrame)
        return frames
    }
    
    // MARK: - Touch
    
//    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let location = touches.first!.location(in: self)
//        let uv = CGPoint(x: location.x / bounds.width, y: (location.y - (bounds.height - bounds.width) / 2) / bounds.width)
//        let position = UI3Position(x: uv.x, y: uv.y, z: 0.5)
//        let frames = allFrames()
//        for (i, object) in allObjects().enumerated() {
//            if let control = object as? UI3Control {
//                if frames[i].contains(position) {
//                    control.interact()
//                }
//            }
//        }
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
