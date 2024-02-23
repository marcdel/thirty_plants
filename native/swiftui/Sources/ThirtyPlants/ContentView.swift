//
//  ContentView.swift
//  ThirtyPlants
//

import SwiftUI
import LiveViewNative

struct ContentView: View {
    var body: some View {
        LiveView(.automatic(
            development: .localhost(path: "/fake_login"),
            production: .custom(URL(string: "https://example.com/")!)
        ))
    }
}
