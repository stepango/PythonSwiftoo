//
//  ContentView.swift
//  PythonSwiftoo
//
//  Created by Arjun Ram on 9/5/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var embeddedPython: EmbeddedPython
    
    var body: some View {
        VStack(spacing: 20) {
            // Existing content
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            
            // Python information
            PythonInfoView(pythonInfo: embeddedPython.pythonInfo)
        }
        .padding()
    }
}

struct PythonInfoView: View {
    let pythonInfo: PythonInfo
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Python Information")
                .font(.headline)
            
            Group {
                Text("Version: \(pythonInfo.version)")
                Text("Encoding: \(pythonInfo.encoding)")
                Text("Path: \(pythonInfo.path)")
            }
            .font(.subheadline)
        }
    }
}

// Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(embeddedPython: EmbeddedPython())
    }
}
