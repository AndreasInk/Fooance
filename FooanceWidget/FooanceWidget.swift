//
//  FooanceWidget.swift
//  FooanceWidget
//
//  Created by Andreas on 3/13/21.
//


import WidgetKit
import SwiftUI
import Intents
import SwiftUICharts
struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
            var entries: [SimpleEntry] = []
    let  entryDate = Calendar.current.date(byAdding: .second, value: 1 , to: Date())!
                 let entry = SimpleEntry(date: entryDate, configuration: configuration)
          
                entries.append(entry)
               
                let timeline = Timeline(entries: entries, policy: .after(entryDate))
   
                
                WidgetCenter.shared.reloadAllTimelines()
                completion(timeline)
            
}
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}
struct largeWidgetView : View {
    var entry: Provider.Entry
    @State var color1 = UIColor(named: "blue")
    @State var color2 = UIColor(named: "lightBlue")
    @State var textColor = UIColor(.white)
    @State var course = "Expenses"
    @State var font = "Poppins-Bold"
    @Environment(\.widgetFamily) var size
    let columns = [
            GridItem(.adaptive(minimum: 80)),
        GridItem(.adaptive(minimum: 80))
        ]
    @State var list = ItemsList(items: [Item(name: "Strawberries", type: "Fruit", price: "1.25", expirationDate: Date(), check: false, noti: true, notiSet: false), Item(name: "Strawberries", type: "Fruit", price: "1.25", expirationDate: Date(), check: false, noti: true, notiSet: false), Item(name: "Strawberries", type: "Fruit", price: "1.25", expirationDate: Date(), check: false, noti: true, notiSet: false), Item(name: "Strawberries", type: "Fruit", price: "1.25", expirationDate: Date(), check: false, noti: true, notiSet: false), Item(name: "Strawberries", type: "Fruit", price: "1.25", expirationDate: Date(), check: false, noti: true, notiSet: false), Item(name: "Strawberries", type: "Fruit", price: "1.80", expirationDate: Date(), check: false, noti: true, notiSet: false), Item(name: "Strawberries", type: "Fruit", price: "1.00", expirationDate: Date(), check: false, noti: true, notiSet: false)], date: Date())
    @State var expenses = [Double]()
    @State var budget = 100.0
    @State var budgetString = "100.0"
    @State var ready = false
    var body: some View {
        ZStack {
            
            Color.clear
                .onAppear() {
                    let defaults = UserDefaults(suiteName: "group.foonance.app")
                    color1 = defaults?.colorForKey(key: "color1") ?? color1
                    color2 = defaults?.colorForKey(key: "color2") ?? color2
                    textColor = defaults?.colorForKey(key: "textColor") ?? textColor
                    font = defaults?.string(forKey: "font") ?? font
                    course = defaults?.string(forKey: "course") ?? course
                    for i in list.items.indices.reversed() {
                        if i > 3 {
                            list.items.remove(at: i)
                        }
                       
                    }
                    expenses.removeAll()
                    for item in list.items {
                        
                        expenses.append(Double(item.price) ?? 0.0)
                    }
                    ready = true
                }
            if ready {
            LinearGradient(gradient: Gradient(colors: [Color(color1!), Color(color2!)]), startPoint: .leading, endPoint: .bottomTrailing)
           
           
            
                
               
               
                        VStack {
//                            LineChartView(data: expenses, title: "Expenses", legend: "", style: ChartStyle.init(backgroundColor: Color(.systemBackground), accentColor: Color(.systemBlue), secondGradientColor: Color(.blue), textColor: Color(textColor), legendTextColor: Color(textColor), dropShadowColor: Color.clear), form: CGSize(width: 225, height: 25))
                            ForEach(list.items.indices, id: \.self) { i2 in
                                ShoppingListRow(item: list.items[i2], textColor: $textColor)
                                Divider()
                        }
                            HStack {
                              
                            Text("Monthly Budget")
                                .font(.custom("Poppins-Bold", size: 18, relativeTo: .headline))
                                .foregroundColor(Color(textColor))
                                .padding(.trailing)
                              
                                HStack(spacing: 0) {
                                    Text("$")
                                        .foregroundColor(Color(textColor))
                                        .font(.custom("Poppins-Bold", size: 14, relativeTo: .headline))
                            Text("\(budget.formattedWithSeparator)")
                                .font(.custom("Poppins-Bold", size: 18, relativeTo: .headline))
                                .foregroundColor(Color(textColor))
                                
                                } .padding(.leading)
                                
                                Spacer()
                                HStack(spacing: 0) {
                                    Text((Double(expenses.reduce(0, +)/budget).rounded(toPlaces: 3)*100).removeZerosFromEnd())
                                        
                                        .font(.custom("Poppins-Bold", size: 18, relativeTo: .headline))
                                        .foregroundColor(Color(textColor))
                                    Text("%")
                                        .foregroundColor(Color(textColor))
                                        .font(.custom("Poppins-Bold", size: 14, relativeTo: .headline))
                                } .padding(.leading)
                               
                            } .padding()
//                            ProgressView(value: expenses.reduce(0, +)/budget)
//                                .accentColor(Color(textColor))
//                                .padding()
                            //Spacer()
                        } .padding(.vertical)
        
            
                    
                
                
            }
        }
    }
}


struct smallWidgetView : View {
    var entry: Provider.Entry
    @State var color1 = UIColor(named: "blue")
    @State var color2 = UIColor(named: "lightBlue")
    @State var textColor = UIColor(.white)
    @State var course = "Expirations"
    @State var font = "Poppins-Bold"
    @Environment(\.widgetFamily) var size
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var list = ItemsList(items: [Item(name: "Strawberries", type: "Fruit", price: "1.25", expirationDate: Date(), check: false, noti: true, notiSet: false), Item(name: "Strawberries", type: "Fruit", price: "1.80", expirationDate: Date(), check: false, noti: true, notiSet: false), Item(name: "Strawberries", type: "Fruit", price: "1.00", expirationDate: Date(), check: false, noti: true, notiSet: false)], date: Date())
    @State var item = Item(name: "Strawberries", type: "Fruit", price: "1.25", expirationDate: Date(), check: false, noti: true, notiSet: false)
    @State var timeTillString = ""
    var body: some View {
        ZStack {
            
            Color.clear
                .onAppear() {
                    let defaults = UserDefaults(suiteName: "group.foonance.app")
                    color1 = defaults?.colorForKey(key: "color1") ?? color1
                    color2 = defaults?.colorForKey(key: "color2") ?? color2
                    textColor = defaults?.colorForKey(key: "textColor") ?? textColor
                    font = defaults?.string(forKey: "font") ?? font
                    course = defaults?.string(forKey: "course") ?? course
                }
                
           
            LinearGradient(gradient: Gradient(colors: [(Color(color1!)), (Color(color2!))]), startPoint: .leading, endPoint: .bottomTrailing)
                .onAppear() {
                    let dateFormatterGet = DateFormatter()
                    dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"

                    let dateFormatterPrint = DateFormatter()
                    dateFormatterPrint.dateFormat = "MMM dd,yyyy"
                    
                   // dateString = dateFormatterGet.string(from: item.expirationDate)
                    #warning("Disable for launch")
                    let calendar = Calendar.current
                    let date = calendar.date(byAdding: .day, value: 6, to: item.expirationDate)
                    item.expirationDate = date ?? Date()
                    let timeTill = Date().distance(to: item.expirationDate)
                    timeTillString = String(Int((timeTill / 86400).rounded())) + " days"
                    
                }
                VStack {
                    HStack {
                    Text(course)
                        .font(.custom(font, size: 16, relativeTo: .headline))
                        .foregroundColor((Color(textColor)))
                        Spacer()
                    }
                    HStack {
                        Text(item.name)
                        .font(.custom(font, size: 16, relativeTo: .title))
                        
                            .foregroundColor(Color(textColor.cgColor))
                        Spacer()
                    }
                    Spacer()
                    HStack {
                        VStack {
                            HStack {
                        Text("Expires in")
                            .foregroundColor(Color(textColor))
                            .font(.custom(font, size: 16, relativeTo: .subheadline))
                                Spacer()
                            }
                            HStack {
                        Text(timeTillString)
                            .font(.custom(font, size: 16, relativeTo: .subheadline))
                            .foregroundColor(Color(textColor))
                            
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

struct WidgetEntryView : View {
    var entry: Provider.Entry
    @State var color1 = UIColor(named: "blue")
    @State var color2 = UIColor(named: "lightBlue")
    @State var textColor = UIColor(.white)
    @State var course = "Math"
    @State var font = "Poppins-Bold"
    @Environment(\.widgetFamily) var size
    var body: some View {
        switch size {
             case .systemSmall:
                smallWidgetView(entry: entry)
             case .systemMedium:
                 HStack(alignment: .bottom) {
                    smallWidgetView(entry: entry)
                     
                 }.padding()
             case .systemLarge:
                 
                    largeWidgetView(entry: entry)
                 
             @unknown default:
                smallWidgetView(entry: entry)
             }
       
    }
}

@main
struct WidgetApp: Widget {
    let kind: String = "Widget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            WidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct WidgetApp_Previews: PreviewProvider {
    static var previews: some View {
        WidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
extension UserDefaults {
 func colorForKey(key: String) -> UIColor? {
  var color: UIColor?
  if let colorData = data(forKey: key) {
   color = NSKeyedUnarchiver.unarchiveObject(with: colorData) as? UIColor
  }
  return color
 }

 func setColor(color: UIColor?, forKey key: String) {
  var colorData: NSData?
   if let color = color {
    colorData = NSKeyedArchiver.archivedData(withRootObject: color) as NSData?
  }
  set(colorData, forKey: key)
 }

}

struct ItemsList: Identifiable, Hashable, Codable {
    var id = UUID()
    var items: [Item]
    var date: Date
}
struct Item: Identifiable, Hashable, Codable {
    var id = UUID()
    var name: String
    var type: String
    var price: String
    var expirationDate: Date
    var check: Bool
    var noti: Bool
    var notiSet: Bool
}



struct ShoppingListRow: View {
    @State var item: Item
    @State var open = false
    @State var price = ""
    @State var expenses = false
    @Binding var textColor: UIColor
    var body: some View {
        HStack {
            
          
               
            VStack {
                LeadingTextView2(text: $item.name, size: 18, textColor: $textColor)
                    .padding(.horizontal)
                    HStack(spacing: 0) {
                        Text("$")
                            .foregroundColor(Color(textColor))
                            .font(.custom("Poppins-Bold", size: 14, relativeTo: .headline))
                        LeadingTextView2(text: $price, size: 14, textColor: $textColor)
                    } .padding(.horizontal)
                   
                }
            
            Spacer()
            
//            if !expenses {
//            Button(action: {
//                item.check.toggle()
//            }) {
//                Image(systemName: "checkmark.circle")
//                    .foregroundColor(item.check ? .green : .gray)
//                    .font(.title)
//                    .padding()
//            }
//            }
        } //.padding()
        .onChange(of: item.price, perform: { value in
            price = item.price
        })
        .onAppear() {
            
            price = item.price
            
        }
     
    }
}
struct ShoppingListRow2: View {
    @State var item: Item
    @State var open = false
    @State var price = ""
    @State var expenses = false
    @Binding var textColor: UIColor
    var body: some View {
        HStack {
            
            Button(action: {
                open = true
            }) {
               
            VStack {
                LeadingTextView2(text: $item.name, size: 18, textColor: $textColor)
                    .padding(.horizontal)
                    HStack(spacing: 0) {
                        Text("$")
                            .foregroundColor(Color(textColor))
                            .font(.custom("Poppins-Bold", size: 14, relativeTo: .headline))
                        LeadingTextView2(text: $price, size: 14, textColor: $textColor)
                    } .padding(.horizontal)
                   
                }
            
            Spacer()
            }
//            if !expenses {
//            Button(action: {
//                item.check.toggle()
//            }) {
//                Image(systemName: "checkmark.circle")
//                    .foregroundColor(item.check ? .green : .gray)
//                    .font(.title)
//                    .padding()
//            }
//            }
        } //.padding()
        .onChange(of: item.price, perform: { value in
            price = item.price
        })
        .onAppear() {
            
            price = item.price
            
        }
      
    }
}


struct LeadingTextView2: View {
    
    @Binding var text: String
    @State var size: CGFloat
    @Binding var textColor: UIColor
    var body: some View {
        HStack {
        Text(text)
            .font(.custom("Poppins-Bold", size: size, relativeTo: .headline))
            .foregroundColor(Color(textColor))
            Spacer()
        } //.padding(.horizontal)
    }
}
struct LeadingTextView: View {
    @State var text: String
    @State var size: CGFloat
    @Binding var textColor: UIColor
    var body: some View {
        HStack {
        Text(text)
            .font(.custom("Poppins-Bold", size: size, relativeTo: .headline))
            .foregroundColor(Color(textColor))
            Spacer()
        } .padding(.horizontal)
    }
}

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        return formatter
    }()
}
extension Double {
    func removeZerosFromEnd() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 16 //maximum digits in Double after dot (maximum precision)
        return String(formatter.string(from: number) ?? "")
    }
}
extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
extension Numeric {
    var formattedWithSeparator: String { Formatter.withSeparator.string(for: self) ?? "" }
}
