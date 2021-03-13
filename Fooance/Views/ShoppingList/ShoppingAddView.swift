//
//  ShoppingAddView.swift
//  Fooance
//
//  Created by Andreas on 3/13/21.
//

import SwiftUI

struct ShoppingAddView: View {
    @Binding var item: Item
    @Binding var add: Bool
  
    var body: some View {
        VStack {
        LeadingTextView(text: "Item Name", size: 18)
        TextField("Item Name", text: $item.name)
            .font(.custom("Poppins-Bold", size: 14, relativeTo: .headline))
            .padding()
        LeadingTextView(text: "Item Price", size: 18)
        TextField("Item Name", text: $item.price)
            .font(.custom("Poppins-Bold", size: 14, relativeTo: .headline))
            .padding()
            Toggle(isOn: $item.noti) {
                Text("Expiration Notifications")
                    .font(.custom("Poppins-Bold", size: 18, relativeTo: .headline))
                    .foregroundColor(Color("text"))
            } .padding()
            Spacer()
            Button(action: {
                if item.name.lowercased().contains("straw") || item.name.lowercased().contains("blue") || item.name.lowercased().contains("ras") || item.name.lowercased().contains("ban") || item.name.lowercased().contains("orang") {
                    let calendar = Calendar.current
                    let date = calendar.date(byAdding: .day, value: 5, to: item.expirationDate)
                   
                    item.expirationDate = date!
                }
                if item.name.lowercased().contains("milk") || item.name.lowercased().contains("yo") {
                    let calendar = Calendar.current
                    let date = calendar.date(byAdding: .day, value: 14, to: item.expirationDate)
                   
                    item.expirationDate = date!
                }
                item.price =  item.price.replacingOccurrences(of: "$", with: "", options: NSString.CompareOptions.literal, range:nil)
                add = false
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .foregroundColor(Color(.systemBlue))
                        .padding()
                        .frame(height: 85)
               Text("Add")
                    .padding()
                .font(.custom("Poppins-Bold", size: 18, relativeTo: .headline))
                .foregroundColor(Color(.white))
                }
            }
           
           
        } .padding(.vertical)
}
}

