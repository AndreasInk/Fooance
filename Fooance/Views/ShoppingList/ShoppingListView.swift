//
//  ShoppingListView.swift
//  Fooance
//
//  Created by Andreas on 3/13/21.
//

import SwiftUI

struct ShoppingListView: View {
    @State var items = [Item]()
    @State var edit = false
    @State var edit2 = false
    @State var isShowingScannerSheet: Bool = false
    @State var add = false
    @EnvironmentObject var userData: UserData
    @Binding var lists: [ItemsList]
    @Binding var i: Int
    var body: some View {
        ZStack {
            if lists.indices.contains(i) {
            ScanningView(items: $lists[i].items, isShowingScannerSheet: $isShowingScannerSheet)
            }
        VStack {
            HStack {
                Button(action: {
                    isShowingScannerSheet = true
                }) {
                   Image(systemName: "camera")
                    .font(.headline)
                    .padding()
                }
                Button(action: {
                    if lists.indices.contains(i) {
                    lists[i].items.append(Item(name: "", type: "", price: "", expirationDate: Date(), check: false, noti: true, notiSet: false))
                    add = true
                    }
//                    let isIndexValid = lists.indices.contains(lists.count - 1)
//                    if isIndexValid {
//                    lists[lists.count - 1].items = items
//                    add = true
//                    }
                }) {
                   Image(systemName: "plus")
                    .font(.headline)
                    .padding()
                }
                Spacer()
                Button(action: {
                    if !edit {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        withAnimation(.easeInOut) {
                            edit.toggle()
                        }
                    }
                    withAnimation(.easeInOut) {
                        edit2.toggle()
                    }
                    } else {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            withAnimation(.easeInOut) {
                                edit2.toggle()
                            }
                        }
                        withAnimation(.easeInOut) {
                            edit.toggle()
                        }
                    }
                }) {
                   Text("Edit")
                    .font(.custom("Poppins", size: 16, relativeTo: .subheadline))
                    .padding()
                }
                if edit {
                    Button(action: {
                        lists.append(ItemsList(items: [Item](), date: Date()))
                        i += 1
                           
                    }) {
                       Text("New List")
                        .font(.custom("Poppins", size: 16, relativeTo: .subheadline))
                        .padding()
                    }
                }
            } //.padding()
        if edit {
            ZStack {
                Color(.systemBackground)
                if lists.indices.contains(i) {
        List {
            ForEach(lists[i].items, id: \.self) { item in
                ShoppingListRow2(item: item)
        } .onMove(perform: move)
        .onDelete(perform: delete)
        } .listStyle(PlainListStyle())
       
        .environment(\.editMode, edit ? .constant(.active) : .constant(.inactive))
                }
            }  .transition(.slide)
        } else {
            if lists.indices.contains(i) {
            ScrollView {
                ForEach(lists[i].items.indices, id: \.self) { i2 in
                    ShoppingListRow(item: $lists[i].items[i2])
                    Divider()
            }  .opacity(edit2 ? 0.0 : 1.0)
        }
            }
        }
            Spacer()
                
//                .onChange(of: items, perform: { value in
//
//
//                        for i in items.indices {
//
//                            if !items[i].notiSet {
//                                #warning("for testing only")
//                                let calendar = Calendar.current
//                                let date = calendar.date(byAdding: .second, value: 10, to: items[i].expirationDate)
//
//                                items[i].expirationDate = date!
//                        let content = UNMutableNotificationContent()
//                        content.title = "🍓"
//                        if items[i].name.last?.lowercased() == "s" {
//                        content.subtitle = "Your " + items[i].name + " are expiring soon!"
//                        } else {
//                            content.subtitle = "Your " + items[i].name + " is expiring soon!"
//                        }
//                        content.sound = UNNotificationSound.default
//
//                        // show this notification five seconds from now
//                        let trigger = UNTimeIntervalNotificationTrigger(timeInterval:  Date().distance(to: items[i].expirationDate), repeats: false)
//
//                        // choose a random identifier
//                        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
//
//                        // add our notification request
//                        UNUserNotificationCenter.current().add(request)
//                                items[i].notiSet = true
//                    }
//                    }
//
//                })
                
                .onAppear() {
                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                        if success {
                            print("All set!")
                           
                        } else if let error = error {
                            print(error.localizedDescription)
                        }
                }
                } .sheet(isPresented: $add, content: {
                    
            if lists.indices.contains(i) {
                if lists[i].items.indices.contains(lists[i].items.count - 1) {
                ShoppingAddView(item: $lists[i].items[lists[i].items.count - 1], add: $add)
            }
            }
                })
           
            
        }
            if lists.indices.contains(i) {
                Color.clear
                .onChange(of: lists[i], perform: { value in
                    items = lists[i].items
                })
            }
        }
//        .onChange(of: items, perform: { value in
//            if lists.indices.contains(i) {
//            lists[i].items = items
//            }
//        })
        .onChange(of: lists, perform: { value in
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(lists) {
                if let json = String(data: encoded, encoding: .utf8) {
                    print(json)
                    do {
                        let url = self.getDocumentsDirectory().appendingPathComponent("lists.txt")
                        try json.write(to: url, atomically: false, encoding: String.Encoding.utf8)
                    
                    } catch {
                        print("erorr")
                    }
                    }

               
            }
        })
       
    }
    
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
    func delete(at offsets: IndexSet) {
        if lists.indices.contains(i) {
        lists[i].items.remove(atOffsets: offsets)
        }
   
      
       }
    
    func move(from source: IndexSet, to destination: Int) {
        if lists.indices.contains(i) {
        lists[i].items.move(fromOffsets: source, toOffset: destination)
        }
        }
}



