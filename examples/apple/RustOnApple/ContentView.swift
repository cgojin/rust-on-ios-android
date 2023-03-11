//
//  ContentView.swift
//  RustOnApple
//
//  Created by Jin on 2023/3/11.
//

import SwiftUI

struct ContentView: View {
    @State private var sum: Int32 = 0

    var body: some View {
        VStack {
            Text(String(sum))

            Button(action: {
                sum = add(sum, 1)
            }, label: {
                Text("Call Rust")
            })
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
