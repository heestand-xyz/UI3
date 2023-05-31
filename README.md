# UI3

3D layout package for SwiftUI

<img src="https://github.com/hexagons/UI3/blob/master/Images/ui3_stacks_frame.png?raw=true" height="256"/>

~~~~swift
import SwiftUI
import UI3

struct ContentView: View {
    var body: some View {
        UI3.Scene {
            UI3.HStack {
                UI3.Box()
                UI3.Box()
                    .frame(width: 0.25)
                UI3.VStack {
                    UI3.Box()
                    UI3.Box()
                        .frame(height: 0.25)
                    UI3.ZStack {
                        UI3.Box()
                        UI3.Box()
                            .frame(length: 0.25)
                        UI3.Box()
                    }
                }
            }
        }
    }
}
~~~~

------

<img src="https://github.com/hexagons/UI3/blob/master/Images/ui3_stacks_sphere.jpg?raw=true" height="256"/>

~~~~swift
import SwiftUI
import UI3

struct ContentView: View {
    var body: some View {
        UI3.Scene {
            UI3.WStack {
                UI3.Sphere()
                    .padding(edges: .all, length: 0.15)
                UI3.Grid(x: 0..<3, y: 0..<3, z: 0..<3) {
                    UI3.Box()
                        .cornerRadius(0.025)
                        .padding(edges: .all, length: 0.1)
                }
            }
        }
    }
}
~~~~

------

<img src="https://github.com/hexagons/UI3/blob/master/Images/ui3_model.png?raw=true" height="256"/>

~~~~swift
import SwiftUI
import UI3

struct ContentView: View {
    var body: some View {
        UI3.Scene {
            UI3.HStack {
                UI3.Box().cornerRadius(0.1)
                UI3.VStack {
                    UI3.ZStack {
                        UI3.Box().cornerRadius(0.1)
                        UI3.Model("suzanne.obj")
                    }
                    UI3.Box().cornerRadius(0.1)
                }
            }
        }
    }
}
~~~~
