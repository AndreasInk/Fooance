//
//  ShoppingListRow.swift
//  Fooance
//
//  Created by Andreas on 3/13/21.
//

import SwiftUI

struct ShoppingListRow: View {
    @Binding var item: Item
    @State var open = false
    @State var price = ""
    @State var expenses = false
    var body: some View {
        HStack {
            
            Button(action: {
                open = true
            }) {
               
            VStack {
                LeadingTextView2(text: $item.name, size: 18)
                    .padding(.horizontal)
                    HStack(spacing: 0) {
                        Text("$")
                            .foregroundColor(Color("text"))
                            .font(.custom("Poppins-Bold", size: 14, relativeTo: .headline))
                LeadingTextView2(text: $price, size: 14)
                    } .padding(.horizontal)
                   
                }
            
            Spacer()
            }
            if !expenses {
            Button(action: {
                item.check.toggle()
            }) {
                Image(systemName: "checkmark.circle")
                    .foregroundColor(item.check ? .green : .gray)
                    .font(.title)
                    .padding()
            }
            }
        } //.padding()
        .onChange(of: item.price, perform: { value in
            price = item.price
        })
        .onAppear() {
            
            price = item.price
            
        }
        .sheet(isPresented: $open, content: {
            ZStack {
                ItemDetailsView(item: $item, locationManager: LocationManager())
                VStack {
                    HStack {
                        Button(action: {
                            open = false
                        }) {
                            Image(systemName: "xmark")
                                .foregroundColor(.gray)
                                .font(.title)
                                .padding()
                        }
                        Spacer()
                    }
                    Spacer()
                }
            }
        })
    }
}
struct ShoppingListRow2: View {
    @State var item: Item
    @State var open = false
    @State var price = ""
    @State var expenses = false
    var body: some View {
        HStack {
            
            Button(action: {
                open = true
            }) {
               
            VStack {
                LeadingTextView2(text: $item.name, size: 18)
                    .padding(.horizontal)
                    HStack(spacing: 0) {
                        Text("$")
                            .foregroundColor(Color("text"))
                            .font(.custom("Poppins-Bold", size: 14, relativeTo: .headline))
                LeadingTextView2(text: $price, size: 14)
                    } .padding(.horizontal)
                   
                }
            
            Spacer()
            }
            if !expenses {
            Button(action: {
                item.check.toggle()
            }) {
                Image(systemName: "checkmark.circle")
                    .foregroundColor(item.check ? .green : .gray)
                    .font(.title)
                    .padding()
            }
            }
        } //.padding()
        .onChange(of: item.price, perform: { value in
            price = item.price
        })
        .onAppear() {
            
            price = item.price
            
        }
        .sheet(isPresented: $open, content: {
            ZStack {
                ItemDetailsView(item: $item, locationManager: LocationManager())
                VStack {
                    HStack {
                        Button(action: {
                            open = false
                        }) {
                            Image(systemName: "xmark")
                                .foregroundColor(.gray)
                                .font(.title)
                                .padding()
                        }
                        Spacer()
                    }
                    Spacer()
                }
            }
        })
    }
}
