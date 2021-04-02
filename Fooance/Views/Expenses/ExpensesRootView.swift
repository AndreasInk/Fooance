//
//  ExpensesRootView.swift
//  Fooance
//
//  Created by Andreas on 3/13/21.
//

import SwiftUI  

struct ExpensesRootView: View {
    @State private var date = Date()
    @State var open = false
    @State var items = [Item]()
    @Binding var lists: [ItemsList]
    @Binding var list: ItemsList
    @Binding var i: Int
    var body: some View {
        
        VStack {
            ScrollView {
                VStack {
            DatePicker("Select Month", selection: $date, displayedComponents: .date)
                                 .datePickerStyle(CompactDatePickerStyle())
                .font(.custom("Poppins-Bold", size: 14, relativeTo: .headline))
                .padding(.horizontal)
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
                            
                            items += list.items
                            items = items.removeDuplicates()
                            
                        }
                        }
                        }
                      
                    }
                }
                .onChange(of: date, perform: { value in
                    items.removeAll()
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
                            
                            items += list.items
                        }
                        }
                        }
                      
                    }
                    
                })
            if !open {
                if lists.indices.contains(i) {
            ExpensesView(items: $items)
                }
            }
                    
                }
               
            }
           
        }
    }
}
