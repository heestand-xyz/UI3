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
