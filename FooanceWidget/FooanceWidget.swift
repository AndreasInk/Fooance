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
    @State var course = "Math"
    @State var font = "Poppins-Bold"
    @Environment(\.widgetFamily) var size
    let columns = [
            GridItem(.adaptive(minimum: 80)),
        GridItem(.adaptive(minimum: 80))
        ]
    var body: some View {
        ZStack {
            
            Color.clear
                .onAppear() {
                    let defaults = UserDefaults(suiteName: "group.fooance.app")
                    color1 = defaults?.colorForKey(key: "color1") ?? color1
                    color2 = defaults?.colorForKey(key: "color2") ?? color2
                    textColor = defaults?.colorForKey(key: "textColor") ?? textColor
                    font = defaults?.string(forKey: "font") ?? font
                    course = defaults?.string(forKey: "course") ?? course
                }
            LinearGradient(gradient: Gradient(colors: [Color(color1!), Color(color2!)]), startPoint: .leading, endPoint: .bottomTrailing)
           
            HStack {
            VStack(spacing: 0) {
                ForEach(0 ..< 3) { number in
                    HStack {
                HStack {
                Text(course)
                    .font(.custom(font, size: 18, relativeTo: .headline))
                    .foregroundColor(Color(textColor))
                    
                }
                HStack {
                Text("A")
                    .font(.custom(font, size: 20, relativeTo: .title))
                    .bold()
                    .foregroundColor(Color(textColor))
                    Spacer()
                }
               
                        VStack {
                        LineChartView(data: [8,23,54,32,12,37,7,23,43], title: "", legend: "")
                           
                        }
        
            }
                    
                }
           
            }
                
            } .padding(.horizontal)
        
    }
}
}
struct smallWidgetView : View {
    var entry: Provider.Entry
    @State var color1 = UIColor(named: "blue")
    @State var color2 = UIColor(named: "lightBlue")
    @State var textColor = UIColor(.white)
    @State var course = "Math"
    @State var font = "Poppins-Bold"
    @Environment(\.widgetFamily) var size
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View {
        ZStack {
            
            Color.clear
                .onAppear() {
                    let defaults = UserDefaults(suiteName: "group.fooance.app")
                    color1 = defaults?.colorForKey(key: "color1") ?? color1
                    color2 = defaults?.colorForKey(key: "color2") ?? color2
                    textColor = defaults?.colorForKey(key: "textColor") ?? textColor
                    font = defaults?.string(forKey: "font") ?? font
                    course = defaults?.string(forKey: "course") ?? course
                }
                
        LinearGradient(gradient: Gradient(colors: [Color(color1!), Color(color2!)]), startPoint: .leading, endPoint: .bottomTrailing)
            VStack {
                HStack {
                Text(course)
                    .font(.custom(font, size: 24, relativeTo: .headline))
                    .foregroundColor(Color(textColor))
                    Spacer()
                }
                HStack {
                Text("A")
                    .font(.custom(font, size: 28, relativeTo: .title))
                    .bold()
                    .foregroundColor(Color(textColor))
                    Spacer()
                }
                Spacer()
                HStack {
                    VStack {
                        HStack {
                    Text("Unit Test 1")
                        .foregroundColor(Color(textColor))
                        .font(.custom(font, size: 12, relativeTo: .subheadline))
                            Spacer()
                        }
                        HStack {
                    Text("A")
                        .font(.custom(font, size: 12, relativeTo: .subheadline))
                        .foregroundColor(Color(textColor))
                        
                            Spacer()
                        }
                    }
                    Spacer()
                    Image(systemName: "doc")
                        .font(.headline)
                        .foregroundColor(Color(textColor))
                    
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
