//
//  ContentView.swift
//  Views And Modifiers
//
//  Created by Clément Villanueva on 21/09/2022.
//

/*  Create a custom ViewModifier (and accompanying View extension) that makes a view have a large, blue font suitable for prominent titles in a view. */

import SwiftUI

struct BlueTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

extension View {
    func blueTitle() -> some View {
        modifier(BlueTitle())
    }
}

struct ContentView: View {
    var body: some View {
        Text("Hello World!")
            .blueTitle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
