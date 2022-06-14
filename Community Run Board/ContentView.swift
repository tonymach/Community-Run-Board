//
//  ContentView.swift
//  Community Run Board
//
//  Created by Anthony Mac on 2022-06-10.
//

import SwiftUI
import CoreData
import BottomSheet


struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var bottomSheetPosition: BottomSheetPosition = .middle //1
    @State var searchText: String = ""
    
    @StateObject var locationManager: LocationManager = .init()
    @State var showList: Bool = false
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    
    
    var body: some View {

        ZStack   {
            MapViewSelection()
                .environmentObject(locationManager)
                .navigationBarHidden(true)
            
        }
            

        .bottomSheet(bottomSheetPosition: $bottomSheetPosition, headerContent: {
            HStack(alignment: .center, spacing: 10) {
                
                Button{
                    print("locating")
                }label: {
                    Label("Locate me", systemImage: "mappin.circle.fill")
                    
                }  .tint(.red)
                    .foregroundColor(.white)
                    .buttonStyle(.borderedProminent)
                    .controlSize(.regular)
                
                

                if bottomSheetPosition == .bottom {
                    
                    Button {
                        bottomSheetPosition = .top
                    }label : {
                        
                        Text("View List")
                        Image(systemName: "list.bullet.rectangle")
                            .renderingMode(.original)

                    }
                    
                    .tint(.blue)
                    .foregroundColor(.white)
                    .buttonStyle(.borderedProminent)
                    .controlSize(.regular)
                   
                }
                
                Spacer()
                
                Button{
                    print("locating")
                }label: {
                    Image(systemName: "gear")
                    
                }  .tint(.gray)
                    .foregroundColor(.white)
                    .buttonStyle(.borderedProminent)
                    .controlSize(.regular)
 

            }
            .foregroundColor(Color(UIColor.secondaryLabel))
            .padding(.vertical, 8)
            .padding(.horizontal, 5)
//            .background(RoundedRectangle(cornerRadius: 10).fill(Color(UIColor.quaternaryLabel)))
            .padding(.bottom)
            //When you tap the SearchBar, the BottomSheet moves to the .top position to make room for the keyboard.
            .onTapGesture {
                self.bottomSheetPosition = .top
            }
            
        }) {
                ScrollView {
                        SessionCell(fullSession: true)
                        SessionCell(fullSession: false)
                        SessionCell(fullSession: false)
                        SessionCell(fullSession: true)
                        SessionCell(fullSession: false)
                        SessionCell(fullSession: true)
                        SessionCell(fullSession: true)
                }
            }
            .clearModalBackground()

    

        
    }

    
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

struct ClearBackgroundView: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}

struct ClearBackgroundViewModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .background(ClearBackgroundView())
    }
}

extension View {
    func clearModalBackground()->some View {
        self.modifier(ClearBackgroundViewModifier())
    }
}
