//
//  ExpensesView.swift
//  Fooance
//
//  Created by Andreas on 3/13/21.
//

import SwiftUI
import SwiftUICharts
struct ExpensesView: View {
    @Binding var items: [Item]
    @State var expenses = [Double]()
    @State var budget = 100.0
    @State var budgetString = "100.0"
    let screenSize = UIScreen.main.bounds
    @State var isReady = false
    @State var settings = false
    @EnvironmentObject var userData: UserData
    var body: some View {
        
        VStack {
            LineChartView(data: expenses, title: "Expenses", legend: "", style: ChartStyle.init(backgroundColor: Color(.systemBackground), accentColor: Color(.systemBlue), secondGradientColor: Color(.blue), textColor: Color("text"), legendTextColor: Color("text"), dropShadowColor: Color.clear), form: CGSize(width: screenSize.width/1.1, height: screenSize.width/1.1))
                .onAppear() {
                    expenses.removeAll()
                    for item in items {
                        expenses.append(Double(item.price) ?? 0.0)
                    }
                    isReady = true
                    budget = userData.monthlyBudget
                    budgetString = String(userData.monthlyBudget)
                }
                .padding()
                
            if isReady {
                
                
                    HStack {
                        Button(action: {
                            settings.toggle()
                        }) {
                            Image(systemName: "gear")
                                .foregroundColor(Color(.systemBlue))
                                .font(.headline)
                                .padding()
                        }
                    Text("Monthly Budget")
                        .font(.custom("Poppins-Bold", size: 18, relativeTo: .headline))
                        .foregroundColor(Color("text"))
                        .padding(.trailing)
                      
                        HStack(spacing: 0) {
                            Text("$")
                                .foregroundColor(Color("text"))
                                .font(.custom("Poppins-Bold", size: 14, relativeTo: .headline))
                    Text("\(budget.formattedWithSeparator)")
                        .font(.custom("Poppins-Bold", size: 18, relativeTo: .headline))
                        .foregroundColor(Color("text"))
                        
                        } .padding(.leading)
                        
                        Spacer()
                        HStack(spacing: 0) {
                            Text((Double(expenses.reduce(0, +)/budget).rounded(toPlaces: 3)*100).removeZerosFromEnd())
                                
                                .font(.custom("Poppins-Bold", size: 18, relativeTo: .headline))
                                .foregroundColor(Color("text"))
                            Text("%")
                                .foregroundColor(Color("text"))
                                .font(.custom("Poppins-Bold", size: 14, relativeTo: .headline))
                        } .padding(.leading)
                       
                    } .padding()
                    ProgressView(value: expenses.reduce(0, +)/budget)
                        .accentColor(Color(.systemBlue))
                        .padding()
               
            
           
            ForEach(items, id: \.self) { item in
                ShoppingListRow2(item: item, expenses: true)
                    Divider()
            
        }
                
            Spacer(minLength: 110)
                .sheet(isPresented: $settings, content: {
                    ScrollView {
                    VStack {
                        HStack(spacing: 0) {
                        Text("Budget: ")
                            .foregroundColor(Color("text"))
                            .font(.custom("Poppins-Bold", size: 14, relativeTo: .headline))
                       Text(budgetString)
                        .foregroundColor(Color("text"))
                        .font(.custom("Poppins-Bold", size: 14, relativeTo: .headline))
                            Spacer()
                        } .padding()
//                    TextField("Budget", text: $budgetString)
//                        .padding(.leading)
//                        .font(.custom("Poppins-Bold", size: 14, relativeTo: .headline))
//                        .padding()
                        
                        Slider(value: $userData.monthlyBudget, in: 0...5000, step: 10)
                            .padding()
                        .onChange(of: budgetString, perform: { value in
                            budgetString =  budgetString.replacingOccurrences(of: "$", with: "", options: NSString.CompareOptions.literal, range:nil)
                            userData.monthlyBudget = Double(budgetString) ?? 0.0
                        })
                            .onChange(of: userData.monthlyBudget, perform: { value in
                                budget = userData.monthlyBudget
                                budgetString =  String(budget)
                            })
                           
                        ConfigureWidgetView()
                            
                    }
                    }
                })
                .onChange(of: items, perform: { value in
                    expenses.removeAll()
                    for item in items {
                        expenses.append(Double(item.price) ?? 0.0)
                    }
                })
                }
        }
        }
    }

