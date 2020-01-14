//
//  HomePage.swift
//  MusicApp
//
//  Created by 林博堯 on 2020/1/14.
//  Copyright © 2020 SHIH-YING PAN. All rights reserved.
//

import SwiftUI

struct HomePage: View {
    @State private var scale : CGFloat = 1
    @State private var newScale : CGFloat = 1
    @State private var moveDistance : CGFloat = 0
    @State private var opacity : Double = 1
    var body: some View {
        NavigationView {
        VStack{
        Image("張惠妹")
        .resizable()
        .scaledToFill()
        .frame(width:200, height:200)
        .clipped()
        .scaleEffect(scale)
        .gesture(MagnificationGesture()
            .onChanged{ value in self.scale = self.newScale * value.magnitude
            }.onEnded{ value in self.newScale = self.scale
        })
            NavigationLink(destination:traindetail()){
                Text("火車")
            }
            NavigationLink(destination:ContentView()){
                Text("音樂")
            }
            Image("傑諾斯")
            .resizable()
            .frame(width:200, height:200)
            .offset(x:moveDistance, y:0)
            .opacity(opacity)
            Spacer()
            }
            .onAppear{
            self.moveDistance+=500
            self.opacity-=0.3
            }.animation(.default)
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
