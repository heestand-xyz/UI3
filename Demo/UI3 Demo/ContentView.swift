//
//  ContentView.swift
//  UI3 Demo
//
//  Created by Heestand, Anton Norman | Anton | GSSD on 2023/05/31.
//

import SwiftUI
import UI3

struct ContentView: View {
    var body: some View {
        UI3.Scene {
            UI3.HStack {
                UI3.Box()
                    .cornerRadius(0.1)
                UI3.Box()
                    .cornerRadius(0.1)
                    .frame(width: 0.25)
                UI3.VStack {
                    UI3.Box()
                        .cornerRadius(0.1)
                    UI3.Box()
                        .cornerRadius(0.1)
                        .frame(height: 0.25)
                    UI3.ZStack {
                        UI3.Box()
                            .cornerRadius(0.1)
                        UI3.Box()
                            .cornerRadius(0.1)
                            .frame(length: 0.25)
                        UI3.Box()
                            .cornerRadius(0.1)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
