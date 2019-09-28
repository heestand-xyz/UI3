import XCTest
@testable import UI3

final class UI3Tests: XCTestCase {
    
    func testVector() {
        
        let vectorA = UI3Vector(x: 1.0, y: 2.0, z: 3.0)
        let vectorB = UI3Vector(x: 2.0, y: 4.0, z: 6.0)
        
        XCTAssertEqual(vectorA * 2, vectorB)
        
    }
    
    func testFrame() {
        
        let frameA = UI3Frame(origin: .zero, size: .one)
        let frameB = UI3Frame(origin: .one, size: .one)

        XCTAssertEqual(frameA +* frameB, frameB)
        
        let frameC = UI3Frame(position: .zero, size: UI3Scale(x: 1.5, y: 1.5, z: 1.5))
        let frameD = UI3Frame(origin: .one, size: UI3Scale(x: 2.0, y: 2.0, z: 2.0))

        XCTAssertEqual(frameC +* frameD,
                       UI3Frame(origin: UI3Position(x: 0.25, y: 0.25, z: 0.25),
                                size: UI3Scale(x: 3.0, y: 3.0, z: 3.0)))
        
    }

    static var allTests = [
        ("testVector", testVector),
        ("testFrame", testFrame),
    ]
}
