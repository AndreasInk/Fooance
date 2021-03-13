//
//  ContentView.swift
//  Fooance
//
//  Created by Andreas on 3/13/21.
//

import SwiftUI

struct ContentView: View {
    @State var lists = [ItemsList(items: [Item(name: "Strawberries", type: "Fruit", price: "1.25", expirationDate: Date(), check: false, noti: true, notiSet: false)], date: Date())]
    @State var i = 6
    @State var list = ItemsList(items: [Item(name: "Strawberries", type: "Fruit", price: "1.25", expirationDate: Date(), check: false, noti: true, notiSet: false), Item(name: "Strawberries", type: "Fruit", price: "1.80", expirationDate: Date(), check: false, noti: true, notiSet: false), Item(name: "Strawberries", type: "Fruit", price: "1.00", expirationDate: Date(), check: false, noti: true, notiSet: false)], date: Date())
    @State private var date = Date()
    @EnvironmentObject var userData: UserData
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .onAppear() {
                    #warning("for testing only")
//                    let calendar = Calendar.current
//                    let date = calendar.date(byAdding: .second, value: 10, to: items.first?.expirationDate ?? Date())
//
//                    items[0].expirationDate = date!
                    
                    let url = self.getDocumentsDirectory().appendingPathComponent("lists.txt")
                    do {
                       
                        let input = try String(contentsOf: url)
                        
                       
                        let jsonData = Data(input.utf8)
                        do {
                            let decoder = JSONDecoder()

                            do {
                                let note = try decoder.decode([ItemsList].self, from: jsonData)
                                lists = note
                                print(lists.count)
//                                if i.first!.id == "1" {
//                                    notes.removeFirst()
//                                }
                            } catch {
                                print(error.localizedDescription)
                            }
                    } catch {
                        print(error.localizedDescription)
                        
                    }
                } catch {
                    print(error.localizedDescription)
                    
                }
                    #warning("disabled for now, will break if in prod")
                   // i = lists.count - 1
//                    if !items.isEmpty {
////                    items = lists.last?.items ?? [Item(name: "Strawberries", type: "Fruit", price: "1.25", expirationDate: Date(), check: false, noti: true, notiSet: false)]
////                        i = lists.count - 1
//                }
                    
                }
            TabView {
                ShoppingListView(lists: $lists, i: $i)
                           .tabItem {
                               Label("Home", systemImage: "house")
                           }

                ExpensesRootView(lists: $lists, list: $list, i: $i)
                           .tabItem {
                               Label("Expenses", systemImage: "chart.bar")
                           }
                    .onAppear() {
                        for list in lists {
                            let components = list.date.get(.day, .month, .year)
                            let components2 = date.get(.day, .month, .year)
                            if let today = components2.day, let month = components.month, let year = components.year {
                            if let today2 = components.day, let month2 = components.month, let year2 = components.year {
                                print("day: \(today), month: \(month), year: \(year)")
                            
                            if  "\(month)" + "\(year)" ==  "\(month2)" + "\(year2)" {
    //                            open = true
    //                             DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
    //                                 withAnimation(.easeInOut) {
    //                                     open = false
    //                                 }
    //                             }
                                
                                self.list = list
                            }
                            }
                            }
                          
                        }
                    }
                   }
        
    }
}
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
}

