//
//  ListRow.swift
//  Fooance
//
//  Created by Andreas on 3/26/21.
//

import SwiftUI

struct ListRow: View {
    @Binding var list: ItemsList
    @State var open = false
    var body: some View {
        Button(action: {
            open = true
        }) {
            
        ZStack {
           RoundedRectangle(cornerRadius: 25.0)
            .frame(height: 100)
            .foregroundColor(Color("AccentColor"))
            HStack {
            Text(list.title ?? "No title")
                .font(.custom("Poppins-Bold", size: 14, relativeTo: .headline))
                .foregroundColor(.white)
            Spacer()
            } .padding()
        } .padding()
        ///.rotation3DEffect(.degrees(10), axis: (x: 0, y: 1, z: 0))
        //.shadow(radius: 25)
        .fullScreenCover(isPresented: $open, content: {
            VStack {
                HStack {
                    Button(action: {
                        open = false
                    }) {
                        Image(systemName: "xmark")
                            .font(.title)
                            .padding()
                    }
                    Spacer()
                }
            ShoppingListView(list: $list)
                
            }
        })
    }
    }
}

