//
//  ShoppingTypeView.swift
//  Fooance
//
//  Created by Andreas on 3/31/21.
//

import SwiftUI

struct ShoppingTypeView: View {
    @State var types = ["Fruit", "Vegetable", "Dairy", "Other"]
   
    @Binding var type: String
    var body: some View {
        ScrollView(.horizontal) {
        HStack {
            ForEach(types, id: \.self) { type in
                ZStack {
                    
                    LinearGradient(gradient: Gradient(colors: [Color("blue"), Color("lightBlue")]), startPoint: .leading, endPoint: .bottomTrailing)
                        .clipShape(RoundedRectangle(cornerRadius: 25.0))
                        .frame(height: 60)
                    Text(type)
                        .font(.custom("Poppins-Bold", size: 12, relativeTo: .subheadline))
                        .foregroundColor(Color(.white))
                        .padding()
                } .padding(.leading)
                .scaleEffect(self.type == type ? 0.8 : 1.0 )
                
                .onTapGesture {
                    withAnimation(.easeInOut) {
                    self.type = type
                    }
                }
            }
        }
        }
    }
}
