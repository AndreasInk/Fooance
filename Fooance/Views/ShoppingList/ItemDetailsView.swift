//
//  ItemDetailsView.swift
//  Fooance
//
//  Created by Andreas on 3/13/21.
//

import SwiftUI

struct ItemDetailsView: View {
    @Binding var item: Item
    @State var dateString = ""
    @State var timeTillString = ""
    @State var ready = false
    @State var edit = false
    @State var img = "icon"
    var body: some View {
        ZStack {
            Color.clear
                .onAppear() {
                    if item.name.lowercased().contains("berr") {
                        img = "berries"
                    }
                }
        VStack {
            Image(img)
                .resizable()
                .scaledToFit()
                .ignoresSafeArea()
                .padding(.top, 75)
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
                    ready = true
                }
                .padding(.bottom)
                
            if ready {
            LeadingTextView2(text: $item.name, size: 36)
                .padding(.horizontal)
            LeadingTextView(text: "$" +  item.price, size: 24)
                if item.name.last?.lowercased() == "s" {
                    LeadingTextView(text: item.name + " expire in " + timeTillString, size: 14)
                } else {
                    LeadingTextView(text: item.name + " expires in " + timeTillString, size: 14)
                }
            
            Toggle(isOn: $item.noti) {
                Text("Expiration Notifications")
                    .font(.custom("Poppins-Bold", size: 18, relativeTo: .headline))
                    .foregroundColor(Color("text"))
            } .padding()
            .onChange(of: item.noti, perform: { value in
                if value {
                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                        if success {
                            print("All set!")
                           
                        } else if let error = error {
                            print(error.localizedDescription)
                        }
                        let content = UNMutableNotificationContent()
                        content.title = "🍓"
                        if item.name.last?.lowercased() == "s" {
                        content.subtitle = "Your " + item.name + " are expiring soon!"
                        } else {
                            content.subtitle = "Your " + item.name + " is expiring soon!"
                        }
                        content.sound = UNNotificationSound.default

                        // show this notification five seconds from now
                        let trigger = UNTimeIntervalNotificationTrigger(timeInterval:  Date().distance(to: item.expirationDate), repeats: false)
                                                                       
                        // choose a random identifier
                        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                        // add our notification request
                        UNUserNotificationCenter.current().add(request)
                    }
                }
            })
            Spacer()
            }
        }
            VStack {
            HStack {
                Spacer()
                Button(action: {
                   
                    
                        withAnimation(.easeInOut) {
                            edit.toggle()
                        }
                }) {
                   Text("Edit")
                    .font(.custom("Poppins", size: 16, relativeTo: .subheadline))
                    .padding()
                }
               
            }
                Spacer()
            }
            if edit {
                Color(.systemBackground)
                ShoppingAddView(item: $item, add: $edit)
                    .padding(.top, 100)
            }
        }
    }
}

