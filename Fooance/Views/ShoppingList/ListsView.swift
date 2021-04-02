//
//  ListsView.swift
//  Fooance
//
//  Created by Andreas on 3/26/21.
//

import SwiftUI

struct ListsView: View {
    @State var items = [Item]()
    @State var edit = false
    @State var edit2 = false
    @State var isShowingScannerSheet: Bool = false
    @State var add = false
    @EnvironmentObject var userData: UserData
    @Binding var lists: [ItemsList]
    @State var list = ItemsList(items: [Item](), date: Date(), title: "")
    @State var lists2 = [ItemsList]()
    @Binding var i: Int
    @State var item = Item(name: "", type: "", price: "", expirationDate: Date(), check: false, noti: false, notiSet: false)
    @State var error = false
   // @Binding var showMenu: Bool
    var body: some View {
        ZStack {
           
         //   ScanningView(items: $list.items, isShowingScannerSheet: $isShowingScannerSheet)
            
        VStack {
            HStack {
//                Button(action: {
//                    withAnimation(.easeInOut) {
//                    showMenu.toggle()
//                    }
//                }) {
//                   Image(systemName: "sidebar.leading")
//                    .font(.headline)
//                    .padding()
//                }
                Button(action: {
                    
                    if !lists.isEmpty {
                        lists.append(ItemsList(items: [Item](), date: Date(), title: ""))
                        add = true
                    
                    i += 1
                    } else {
                        lists.append(ItemsList(items: [Item](), date: Date(), title: ""))
                        add = true
                    }
//                    let isIndexValid = lists.indices.contains(lists.count - 1)
//                   // if isIndexValid {
//                    lists[lists.count - 1].items = items
//                    add = true
//                    //}
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
//                if edit {
//                    Button(action: {
//                        lists.append(ItemsList(items: [Item](), date: Date(), title: ""))
//                        i += 1
//
//                    }) {
//                       Text("New List")
//                        .font(.custom("Poppins", size: 16, relativeTo: .subheadline))
//                        .padding()
//                    }
//                }
            } //.padding()
        if edit {
            ZStack {
                Color(.systemBackground)
            
        List {
            Spacer(minLength: 35)
            ForEach(0..<lists.count, id: \.self) { i2 in
               
                ListRow(list: $lists[i2, default: ItemsList(items: [Item](), date: Date(), title: "")])
                    //.id(UUID())
                   
        } .onMove(perform: move)
        .onDelete(perform: delete)
        } .listStyle(PlainListStyle()) 
        .environment(\.editMode, edit ? .constant(.active) : .constant(.inactive))
                
            }  .transition(.slide)
        } else {
           
            ScrollView {
                Spacer(minLength: 35)
                ForEach(0..<lists.count, id: \.self) { i2 in
                    
                    ListRow(list: $lists[i2, default: ItemsList(items: [Item](), date: Date(), title: "")])
                      //  .id(UUID())
                    Divider()
                    
            }  .opacity(edit2 ? 0.0 : 1.0)
            } .onAppear() {
                
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
//                } .sheet(isPresented: $add, content: {
//
//
//
//
//
//
//                })
                }
            
        }
            if add {
                ZStack {
                    Color(.systemBackground)
                VStack {
                    HStack {
                        Button(action: {
                            add = false
                        }) {
                            Image(systemName: "xmark")
                                .font(.title)
                                .padding()
                        }
                        Spacer()
                    }
                ShoppingAddView(item: $item, add: $add, list: $lists[i, default: ItemsList(items: [Item](), date: Date(), title: "")], isAddingItem: false)
                }
                }
            }
            if error {
                ZStack {
                RoundedRectangle(cornerRadius: 25.0)
                    .foregroundColor(Color("lightBlue"))
                    .padding()
                    Text("Please Add Another List Before Deleting Your Last List")
                        .multilineTextAlignment(.center)
                        .padding()
                        .font(.custom("Poppins-Bold", size: 14, relativeTo: .headline))
                        .foregroundColor(.white)
                } .onTapGesture {
                    error = false
                }
            }
//            if lists.indices.contains(i) {
//                Color.clear
//                .onChange(of: lists[i], perform: { value in
//                    items = lists[i].items
//                })
//            }
        }
//        .onChange(of: items, perform: { value in
//            if lists.indices.contains(i) {
//            lists[i].items = items
//            }
//        })
//        .onChange(of: list, perform: { value in
//            lists.append(list)
//            lists = lists.removeDuplicates()
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
            lists2 = lists
        })
        
    }
    
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
    func delete(at offsets: IndexSet) {
        if lists.count != 1 {
            
        lists.remove(atOffsets: offsets)
            
        
        } else {
            error = true
        }
   
      
       }
    
    func move(from source: IndexSet, to destination: Int) {
        
        lists.move(fromOffsets: source, toOffset: destination)
        
        }
}




extension Binding where
    Value: MutableCollection,
    Value: RangeReplaceableCollection
{
    subscript(
        _ index: Value.Index,
        default defaultValue: Value.Element
    ) -> Binding<Value.Element> {
        Binding<Value.Element> {
            guard index < self.wrappedValue.endIndex else {
                return defaultValue
            }
            return self.wrappedValue[index]
        } set: { newValue in
            
            // It is possible that the index we are updating
            // is beyond the end of our array so we first
            // need to append items to the array to ensure
            // we are within range.
            while index >= self.wrappedValue.endIndex {
                self.wrappedValue.append(defaultValue)
            }
            
            self.wrappedValue[index] = newValue
        }
    }
}
