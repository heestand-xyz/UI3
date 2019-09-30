# UI3

3D UI layout lib for SwiftUI

<img src="https://github.com/hexagons/UI3/blob/master/Images/ui3_stacks_frame.png?raw=true" height="256"/>

~~~~swift
import SwiftUI
import UI3

struct ContentView: View {
    var body: some View {
        UI3 {
            HStack {
                Box()
                Box().frame(width: 0.25)
                VStack {
                    Box()
                    Box().frame(height: 0.25)
                    ZStack {
                        Box()
                        Box().frame(length: 0.25)
                        Box()
                    }
                }
            }
        }
    }
}
~~~~

------

<img src="https://github.com/hexagons/UI3/blob/master/Images/ui3_stacks_wstack.png?raw=true" height="256"/>

~~~~swift
import SwiftUI
import UI3

struct ContentView: View {
    var body: some View {
        UI3 {
            WStack {
                Box()
                    .cornerRadius(0.05)
                    .padding(edges: .all, length: 0.1)
                HStack {
                    ForEach(0..<3) { _ in
                        VStack {
                            ForEach(0..<3) { _ in
                                ZStack {
                                    ForEach(0..<3) { _ in
                                        Box()
                                            .cornerRadius(0.05)
                                            .padding(edges: .all, length: 0.05)
                                    }
                                }
                            }
                        }
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
        UI3 {
            WStack {
                Sphere()
                    .padding(edges: .all, length: 0.15)
                Grid(x: 0..<3, y: 0..<3, z: 0..<3) {
                    Box()
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
        UI3 {
            HStack {
                Box().cornerRadius(0.1)
                VStack {
                    ZStack {
                        Box().cornerRadius(0.1)
                        Model("suzanne.obj")
                    }
                    Box().cornerRadius(0.1)
                }
            }
        }
    }
}
~~~~
