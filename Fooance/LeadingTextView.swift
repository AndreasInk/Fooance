//
//  LeadingTextView.swift
//  Fooance
//
//  Created by Andreas on 3/13/21.
//

import SwiftUI

struct LeadingTextView2: View {
    @Binding var text: String
    @State var size: CGFloat
    var body: some View {
        HStack {
        Text(text)
            .font(.custom("Poppins-Bold", size: size, relativeTo: .headline))
            .foregroundColor(Color("text"))
            Spacer()
        } //.padding(.horizontal)
    }
}
struct LeadingTextView: View {
    @State var text: String
    @State var size: CGFloat
    var body: some View {
        HStack {
        Text(text)
            .font(.custom("Poppins-Bold", size: size, relativeTo: .headline))
            .foregroundColor(Color("text"))
            Spacer()
        } .padding(.horizontal)
    }
}

