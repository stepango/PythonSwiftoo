//
//  PythonSwiftooApp.swift
//  PythonSwiftoo
//
//  Created by Arjun Ram on 9/5/24.
//

import SwiftUI
import Python
import PythonKit
/*
class EmbeddedPython: ObservableObject {
    init() {
                // Initialize the Python runtime early in the app
        if  let stdLibPath = Bundle.main.path(forResource: "python-stdlib", ofType: nil),
            let libDynloadPath = Bundle.main.path(forResource: "python-stdlib/lib-dynload", ofType: nil)
        {
            setenv("PYTHONHOME", stdLibPath, 1)
            setenv("PYTHONPATH", "\(stdLibPath):\(libDynloadPath)", 1)
            Py_Initialize()
        }
    }
        
        // Simple example of loading Python modules into the runtime
        // and accessing Python object members in Swift
        func printPythonInfo() {
        let sys = Python.import("sys")
                
        print("Python Version: \(sys.version_info.major).\(sys.version_info.minor)")
        print("Python Encoding: \(sys.getdefaultencoding().upper())")
        print("Python Path: \(sys.path)")

        _ = Python.import("math") // verifies `lib-dynload` is found and signed successfully
        }
}

@main
struct PythonSwiftooApp: App {
    @StateObject var embeddedPython = EmbeddedPython()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear() {
                    embeddedPython.printPythonInfo()
                }
        }
    }
} */


import SwiftUI
import PythonKit

struct PythonInfo {
    var version: String = ""
    var encoding: String = ""
    var path: String = ""
}

class EmbeddedPython: ObservableObject {
    @Published var pythonInfo = PythonInfo()
    
    init() {
        if let stdLibPath = Bundle.main.path(forResource: "python-stdlib", ofType: nil),
           let libDynloadPath = Bundle.main.path(forResource: "python-stdlib/lib-dynload", ofType: nil)
        {
            setenv("PYTHONHOME", stdLibPath, 1)
            setenv("PYTHONPATH", "\(stdLibPath):\(libDynloadPath)", 1)
            Py_Initialize()
        }
        updatePythonInfo()
    }
    
    func updatePythonInfo() {
        let sys = Python.import("sys")
        
        pythonInfo.version = "\(sys.version_info.major).\(sys.version_info.minor)"
        pythonInfo.encoding = "\(sys.getdefaultencoding().upper())"
        pythonInfo.path = "\(sys.path)"
        
        _ = Python.import("math") // verifies `lib-dynload` is found and signed successfully
    }
}

@main
struct PythonSwiftooApp: App {
    @StateObject var embeddedPython = EmbeddedPython()

    var body: some Scene {
        WindowGroup {
            ContentView(embeddedPython: embeddedPython)
        }
    }
}
