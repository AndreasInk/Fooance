//
//  WidgetPreview.swift
//  Fooance
//
//  Created by Andreas on 3/13/21.
//

import SwiftUI

struct WidgetPreview: View {
    @Binding var color1: Color
    @Binding var color2: Color
    @Binding var textColor: Color
    @Binding var course: String
    @Binding var font: String
    
    var body: some View {
        ZStack {
        LinearGradient(gradient: Gradient(colors: [(color1), (color2)]), startPoint: .leading, endPoint: .bottomTrailing)
            VStack {
                HStack {
                Text(course)
                    .font(.custom(font, size: 24, relativeTo: .headline))
                    .foregroundColor((textColor))
                    Spacer()
                }
                HStack {
                Text("A")
                    .font(.custom(font, size: 36, relativeTo: .title))
                    .bold()
                    .foregroundColor((textColor))
                    Spacer()
                }
                Spacer()
                HStack {
                    VStack {
                        HStack {
                    Text("Unit Test 1")
                        .foregroundColor((textColor))
                        .font(.custom(font, size: 12, relativeTo: .subheadline))
                            Spacer()
                        }
                        HStack {
                    Text("A")
                        .font(.custom(font, size: 12, relativeTo: .subheadline))
                        .foregroundColor((textColor))
                        
                            Spacer()
                        }
                    }
                    Spacer()
                    Image(systemName: "doc")
                        .font(.headline)
                        .foregroundColor((textColor))
                    
                }
            } .padding()
            
        }
    }
}
