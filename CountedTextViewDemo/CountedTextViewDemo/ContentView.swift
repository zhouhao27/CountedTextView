//
//  ContentView.swift
//  CountedTextViewDemo
//
//  Created by Hao Zhou on 12/9/19.
//  Copyright © 2019 Hao Zhou. All rights reserved.
//

import SwiftUI
import CountedTextView

struct ContentView: View {
  @State var name = ""
  
  var body: some View {
    VStack {
      CountedTextView(text: $name, placeHolder: "Please input your name")
      TextField("Test", text: $name)
    }.frame(minHeight: 50, maxHeight: 200, alignment: .center)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
