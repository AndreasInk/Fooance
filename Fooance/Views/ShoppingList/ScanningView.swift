//
//  ScanningVieww.swift
//  Fooance
//
//  Created by Andreas on 3/13/21.
//

import SwiftUI
import VisionKit
import Vision
import UIKit
struct ScanningView: View {
    @Binding var items: [Item]
   // @Binding var alreadyCheckedNotis: Bool
    let tagger = NSLinguisticTagger(tagSchemes:[.tokenType, .language, .lexicalClass, .nameType, .lemma], options: 0)
    let options: NSLinguisticTagger.Options = [.joinNames]
    var body: some View {
        Color.clear
            .sheet(isPresented: self.$isShowingScannerSheet) { self.makeScannerView() }
            .onChange(of: text, perform: { value in
                
               
//print(text)
                if text.lowercased().contains("walmart") {
                    var lines = tokenizeText(for: text)
                for i in lines.indices {
                 //   print(lines[i])
                    if isNumber(text: lines[i]) {
                        
                        let isIndexValid = lines.indices.contains(i - 1)
                        if isIndexValid {
                            if containsLetter(text: lines[i - 1]) {
                                print(1)
                                if !isNotFood(text: lines[i - 1]) {
                                    print(2)
                                    if !isNotFood(text: lines[i]) {
                                    print(3)
                                    if !containsLetter(text: lines[i]) {
                                        print(4)
//                                    if isNumber(text: lines[i - 1]) {
                                        print(5)
                                    lines[i] =  lines[i].replacingOccurrences(of: "$", with: "", options: NSString.CompareOptions.literal, range:nil)
                                    items.append(Item(name: lines[i - 1], type: "", price: (lines[i]), expirationDate: Date(), check: true, noti: true, notiSet: false))
                                    }}
                                  //  }
                            }
                            }
                        }
                    }
                }
                } else {
                    
                    var lines = text.components(separatedBy: "\n")
                    for i in lines.indices {
                    let isIndexValid = lines.indices.contains(i - 1)
                                         if isIndexValid {
                                             if !containsPrice(text: lines[i - 1]) {
                                                 if !isNotFood(text: lines[i - 1]) {
                                                     if isNumber(text: lines[i]) {
                                                        
                                                     if !isNumber(text: lines[i - 1]) {
                                                       
                                                     lines[i] =  lines[i].replacingOccurrences(of: "$", with: "", options: NSString.CompareOptions.literal, range:nil)
                                                     items.append(Item(name: lines[i - 1], type: "", price: (lines[i]), expirationDate: Date(), check: true, noti: true, notiSet: false))
                                                     }
                                                        }
                                                     }
                                             }
                                             
                                         }
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                var groupedItems: [Item] = []
                for i in items.indices {
                        if !items[i].notiSet {
                            #warning("for testing")
                            let calendar = Calendar.current
                            let date = calendar.date(byAdding: .minute, value: 1, to: items[i].expirationDate)
                           
                            items[i].expirationDate = date!
                            groupedItems = items
                            for i2 in groupedItems.indices.reversed() {
                                if groupedItems[i2].expirationDate.timeIntervalSince1970 + 8460 > date?.timeIntervalSince1970 ?? 0.0  || groupedItems[i2].expirationDate.timeIntervalSince1970 < date?.timeIntervalSince1970 ?? 0.0 - 8640 {
                                    if groupedItems[i2] != items[i] {
                                        
                                    
                                    groupedItems.remove(at: i2)
                                    }
                                    
                                }
                            }
                           
                              
                            }
                    
                }
                    #warning("Double check")
                    let vegetables = Bundle.main.decode(Vegetables.self, from: "vegetables.json")
                    let fruits = Bundle.main.decode(Fruits.self, from: "fruits.json")
                for item in groupedItems {
                    for v in vegetables.vegetables {
                        for f in fruits.fruits {
                            if item.name.lowercased().contains(f.lowercased())  {
                        let calendar = Calendar.current
                        let date = calendar.date(byAdding: .day, value: 6, to: item.expirationDate)
                       
                        if !item.notiSet {
                            
                        let content = UNMutableNotificationContent()
                        content.title = "🍓"
                        
                        content.subtitle = "You have mulitple items expiring soon!"
                       
                        content.sound = UNNotificationSound.default

                        // show this notification five seconds from now
                            let trigger = UNTimeIntervalNotificationTrigger(timeInterval:  Date().distance(to: date ?? Date()), repeats: false)
                                                                       
                        // choose a random identifier
                        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                        // add our notification request
                        UNUserNotificationCenter.current().add(request)
                              print(f)
                    }
                    else if item.name.lowercased().contains("milk") || item.name.lowercased().contains("yo") {
                        let calendar = Calendar.current
                        let date = calendar.date(byAdding: .day, value: 7, to: item.expirationDate)
                       
                        if !item.notiSet {
                            
                        let content = UNMutableNotificationContent()
                        content.title = "🍓"
                        
                        content.subtitle = "You have mulitple items expiring soon!"
                       
                        content.sound = UNNotificationSound.default

                        // show this notification five seconds from now
                            let trigger = UNTimeIntervalNotificationTrigger(timeInterval:  Date().distance(to: date ?? Date()), repeats: false)
                                                                       
                        // choose a random identifier
                        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                        // add our notification request
                        UNUserNotificationCenter.current().add(request)
                              
                    }
                    //item.notiSet = true
                        
                    } else if item.name.lowercased().contains(v.lowercased())  {
                        
                    
                    } else {
                        let calendar = Calendar.current
                        let date = calendar.date(byAdding: .day, value: 4, to: item.expirationDate)
                       
                        if !item.notiSet {
                            
                        let content = UNMutableNotificationContent()
                        content.title = "🍓"
                        
                        content.subtitle = "You have mulitple items expiring soon!"
                       
                        content.sound = UNNotificationSound.default

                        // show this notification five seconds from now
                            let trigger = UNTimeIntervalNotificationTrigger(timeInterval:  Date().distance(to: date ?? Date()), repeats: false)
                                                                       
                        // choose a random identifier
                        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                        // add our notification request
                        UNUserNotificationCenter.current().add(request)
                              
                    }
                }
                }
                    }
                }
                }
                }
            })
    }
  
    func tokenizeText(for text: String) -> [String] {
        var words = [String]()
        tagger.string = text
        let range = NSRange(location: 0, length: text.utf16.count)
        tagger.enumerateTags(in: range, unit: .sentence, scheme: .tokenType, options: options) { tag, tokenRange, stop in
            let word = (text as NSString).substring(with: tokenRange)
            words.append(word)
            
        }
        return words
    }
    func containsPrice(text: String) -> Bool {
       
           
        let range = text.contains("$")

            // range will be nil if no letters is found
        if range  {
                return true
            }
            else {
                return false
            }
            
            // range will be nil if no whitespace is found
          
          
        }
    func isNumber(text: String) -> Bool {
        let decimalCharacters = CharacterSet.decimalDigits

        let decimalRange = text.rangeOfCharacter(from: decimalCharacters)

        if decimalRange != nil {
            return true
        } else {
            return false
        }
    }
    func containsLetter(text: String) -> Bool {
        let decimalCharacters = CharacterSet.letters

        let decimalRange = text.rangeOfCharacter(from: decimalCharacters)
       
        if decimalRange != nil {
            return true
        } else {
            return false
        }
    }
    func isNotSymbol(text: String) -> Bool {
        let decimalCharacters = CharacterSet.symbols

        let decimalRange = text.rangeOfCharacter(from: decimalCharacters)
       
        if decimalRange != nil {
            return true
        } else {
            return false
        }
    }
    func isNotFood(text: String) -> Bool {
       
           
        let range = text.lowercased().contains("total") || text.lowercased().contains("subtotal") || text.lowercased().contains("cash") || text.lowercased().contains("cash") || text.lowercased().contains("change") || text.lowercased().contains("net") || text.lowercased() == "fo" || text.lowercased() == "fc" || text.lowercased().contains("BLVD") || text.lowercased().contains("walmart") || text.lowercased().contains("rd") || text.lowercased().contains("fl") || text.lowercased().contains("te") || text.lowercased().contains("/") || text.lowercased().contains("tc") || text.lowercased().contains("%") || text.lowercased().contains("tax") || text.lowercased().contains("ic") || text.lowercased().contains("@") || text.lowercased().contains("store")
            // range will be nil if no letters is found
        if range  {
                return true
            }
            else {
                return false
            }
            
            // range will be nil if no whitespace is found
          
          
        }
    
    @Binding var isShowingScannerSheet: Bool
    @State private var text: String = ""
     
    private func openCamera() {
        isShowingScannerSheet = true
    }
     
    private func makeScannerView() -> ScannerView {
        ScannerView(completion: { textPerPage in
            if let text = textPerPage?.joined(separator: "\n").trimmingCharacters(in: .whitespacesAndNewlines) {
                self.text = text
            }
            self.isShowingScannerSheet = false
        })
    }
}
struct ScannerView: UIViewControllerRepresentable {
    private let completionHandler: ([String]?) -> Void
     
    init(completion: @escaping ([String]?) -> Void) {
        self.completionHandler = completion
    }
     
    typealias UIViewControllerType = VNDocumentCameraViewController
     
    func makeUIViewController(context: UIViewControllerRepresentableContext<ScannerView>) -> VNDocumentCameraViewController {
        let viewController = VNDocumentCameraViewController()
        viewController.delegate = context.coordinator
        return viewController
    }
     
    func updateUIViewController(_ uiViewController: VNDocumentCameraViewController, context: UIViewControllerRepresentableContext<ScannerView>) {}
     
    func makeCoordinator() -> Coordinator {
        return Coordinator(completion: completionHandler)
    }
     
    final class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate {
        private let completionHandler: ([String]?) -> Void
         
        init(completion: @escaping ([String]?) -> Void) {
            self.completionHandler = completion
        }
         
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
            print("Document camera view controller did finish with ", scan)
            let recognizer = TextRecognizer(cameraScan: scan)
            recognizer.recognizeText(withCompletionHandler: completionHandler)
        }
         
        func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
            completionHandler(nil)
        }
         
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
            print("Document camera view controller did finish with error ", error)
            completionHandler(nil)
        }
    }
}
final class TextRecognizer {
    let cameraScan: VNDocumentCameraScan
     
    init(cameraScan: VNDocumentCameraScan) {
        self.cameraScan = cameraScan
    }
     
    private let queue = DispatchQueue(label: "com.augmentedcode.scan", qos: .default, attributes: [], autoreleaseFrequency: .workItem)
     
    func recognizeText(withCompletionHandler completionHandler: @escaping ([String]) -> Void) {
        queue.async {
            let images = (0..<self.cameraScan.pageCount).compactMap({ self.cameraScan.imageOfPage(at: $0).cgImage })
            let imagesAndRequests = images.map({ (image: $0, request: VNRecognizeTextRequest()) })
            let textPerPage = imagesAndRequests.map { image, request -> String in
                let handler = VNImageRequestHandler(cgImage: image, options: [:])
                do {
                    try handler.perform([request])
                    guard let observations = request.results as? [VNRecognizedTextObservation] else { return "" }
                    return observations.compactMap({ $0.topCandidates(1).first?.string }).joined(separator: "\n")
                }
                catch {
                    print(error)
                    return ""
                }
            }
            DispatchQueue.main.async {
                completionHandler(textPerPage)
            }
        }
    }
}
