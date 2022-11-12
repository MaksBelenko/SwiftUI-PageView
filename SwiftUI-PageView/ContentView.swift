//
//  ContentView.swift
//  SwiftUI-PageView
//
//  Created by Maksim on 12/11/2022.
//

import SwiftUI

struct TestData: Identifiable {
    let id: Int
    let text: String
}

struct ContentView: View {
    
    var screenSize: CGSize
    @State var offset: CGFloat = 100
    
    let intro = [TestData(id: 1, text: "Page 1"),
                 TestData(id: 2, text: "Page 2"),
                 TestData(id: 3, text: "Page 3")]
    
    var body: some View {
        VStack {
            
            PageView(offset: $offset) {
                    
                HStack(spacing: 0) {
                    ForEach(intro) { intro in
                        VStack {
                            Text(intro.text)
                                .foregroundColor(.yellow)
                        }
                        .padding()
                        .frame(width: screenSize.width)
                        .background(.green)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        
    }
}
