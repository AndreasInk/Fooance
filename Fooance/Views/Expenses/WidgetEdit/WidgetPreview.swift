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
    @State var list = ItemsList(items: [Item(name: "Strawberries", type: "Fruit", price: "1.25", expirationDate: Date(), check: false, noti: true, notiSet: false), Item(name: "Strawberries", type: "Fruit", price: "1.80", expirationDate: Date(), check: false, noti: true, notiSet: false), Item(name: "Strawberries", type: "Fruit", price: "1.00", expirationDate: Date(), check: false, noti: true, notiSet: false)], date: Date(), title: "")
    @State var item = Item(name: "Strawberries", type: "Fruit", price: "1.25", expirationDate: Date(), check: false, noti: true, notiSet: false)
    @State var timeTillString = ""
    var body: some View {
        ZStack {
        LinearGradient(gradient: Gradient(colors: [(color1), (color2)]), startPoint: .leading, endPoint: .bottomTrailing)
            .onAppear() {
                let dateFormatterGet = DateFormatter()
                dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"

                let dateFormatterPrint = DateFormatter()
                dateFormatterPrint.dateFormat = "MMM dd,yyyy"
                
               // dateString = dateFormatterGet.string(from: item.expirationDate)
                #warning("Disable for launch")
                let calendar = Calendar.current
                let date = calendar.date(byAdding: .day, value: 14, to: item.expirationDate)
                item.expirationDate = date ?? Date()
                let timeTill = Date().distance(to: item.expirationDate)
                timeTillString = String(Int((timeTill / 86400).rounded())) + " days"
                
            }
            VStack {
                HStack {
                Text(course)
                    .font(.custom(font, size: 20, relativeTo: .headline))
                    .foregroundColor((textColor))
                    Spacer()
                }
                HStack {
                    Text(item.name)
                    .font(.custom(font, size: 22, relativeTo: .title))
                    .bold()
                    .foregroundColor((textColor))
                    Spacer()
                }
                Spacer()
                HStack {
                    VStack {
                        HStack {
                    Text("Expires in")
                        .foregroundColor((textColor))
                        .font(.custom(font, size: 16, relativeTo: .subheadline))
                            Spacer()
                        }
                        HStack {
                    Text(timeTillString)
                        .font(.custom(font, size: 16, relativeTo: .subheadline))
                        .foregroundColor((textColor))
                        
                            Spacer()
                        }
                    }
                    Spacer()
                    Text("🍓")
                        .font(.custom(font, size: 16, relativeTo: .subheadline))
//                        .foregroundColor((textColor))
                    
                }
            } .padding()
            
        }
    }
}
