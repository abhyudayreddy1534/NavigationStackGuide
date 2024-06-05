//
//  ContentView.swift
//  NavigationGuide
//
//  Created by Sravanthi Chinthireddy on 05/06/24.
//

import SwiftUI

enum Navigation: String {
    case one = "Basic Navigation Stack"
    case two = "Basic Navigation with Title display mode"
    case three = "Editable Navigation title"
    case four = "Nav Bar with tool bar items"
    case five = "Navigation link demo"
    case six = "Advanced Navigation label"
    case seven = "Navigation with list data"
    case eight = "Programatic navigation"
    case nine = "Dynamic Path modification"
    case ten = "Navigation Path for multiple Data types"
    case eleven = "Selection state with multiple destinations"
    case twelve = "Saving and Loading navigation State"
}

struct ContentView: View {
    let navigationListArray: [Navigation] = [.one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .ten, .eleven, .twelve]
    
    var body: some View {
        NavigationView {
            List(navigationListArray, id: \.self) { item in
                NavigationLink {
                    switch item {
                    case .one:
                        BasicNavigationStack()
                    case .two:
                        BasicNavWithTitleDisplayMode()
                    case .three:
                        EditableNavigationTitle()
                    case .four:
                        NavBarWithToolBarItems()
                    case .five:
                        NavigationLinkDemo()
                    case .six:
                        NavigationLinkDemoWithLabel()
                    case .seven:
                        NavDemoWithListItems()
                    case .eight:
                        ProgramaticNavDemoWithList()
                    case .nine:
                        DynamicNavPathModification()
                    case .ten:
                        CustomNavigationPathView()
                    case .eleven:
                        StateBasedNavView()
                    case .twelve:
                        SaveAndLoadNavState()
                    default:
                        Text(item.rawValue)
                    }
                } label: {
                    Text(item.rawValue)
                }
            }
            .navigationTitle("Navigation Guide")
        }
        
    }
}

struct BasicNavigationStack: View {
    var body: some View {
        NavigationStack {
            Text("This is the implementation of Basic Navigation ")
                .padding()
                .navigationTitle("Main Page")
        }
    }
}

struct BasicNavWithTitleDisplayMode: View {
    var body: some View {
        NavigationStack {
            Text("This is the implementation of Basic Navigation with Title Display mode")
                .padding()
                .navigationTitle("Display Mode")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct EditableNavigationTitle: View {
    @State private var pageTitle = "The new title"
    var body: some View {
        NavigationStack {
            Text("This is the implementation of Editable Navigation title which comes from Parent View or Some View")
                .padding()
                .navigationTitle($pageTitle) // using a $ symbol give the option to edit the Title and save the same in pageTitle property
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct NavBarWithToolBarItems: View {
    @State private var tappedTitle = ""
    var body: some View {
        NavigationStack {
            Text("This is the implementation of Navigation Bar with tool bar button and their actions")
            HStack {
                Text("Button tapped:")
                Text(tappedTitle)
                    .fontWeight(.bold)
            }
                
                .toolbar(content: {
                    
//                    You can have a ToolBarItem or basic Button but not both at the same time. as the toolbar buttons array expects same type of buttons
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: {
                            tappedTitle = "Create"
                        }, label: {
                            Text("Create")
                        })
                        
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            tappedTitle = "Done"
                        }, label: {
                            Text("Done")
                        })
                    }
                    
                })
        }
        .navigationTitle("Buttons In Action")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct NavigationLinkDemo: View {
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink("Show Detail View") {
                    DetailView()
                }
            }
            .navigationTitle("Navigation Link Example")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct NavigationLinkDemoWithLabel: View {
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink {
                    DetailView()
                } label: {
                    Label("Show Details", systemImage: "info.circle")
                }

            }
            .navigationTitle("Navigation Link Example")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct NavDemoWithListItems: View {
    let items = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"]
    var body: some View {
        NavigationStack {
            List(items, id: \.self) { item in
                NavigationLink(item, value: item)
            }
            .navigationDestination(for: String.self) { itemName in
                ItemView(itemName: itemName)
//                Text("Text \(itemName)")
            }
            .navigationTitle("Select an Item")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ProgramaticNavDemoWithList: View {
    @State private var items = [2, 5, 7]
    
    var body: some View {
        NavigationStack(path: $items) {
            List(1..<15) { num in
                NavigationLink(value: num) {
                    Label("Item \(num)", systemImage: "\(num).circle")
                }
            }
            .navigationDestination(for: Int.self) { number in
                Text("Detail View for \(number)")
            }
            .navigationTitle("Item specific View")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct DynamicNavPathModification: View {
    @State private var selectedItems = [Int]()
    
    var body: some View {
        NavigationStack(path: $selectedItems) {
            List(1..<15) { num in
                NavigationLink(value: num) {
                    Label("Item \(num)", systemImage: "\(num).circle")
                }
            }
            .navigationDestination(for: Int.self) { number in
                VStack {
                    Text("Detail for item \(number)")
                    Button("Navigate to next item") {
                        selectedItems.append(number + 1)
                    }
                }
            }
            .navigationTitle("Dynamic Nav View")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct CustomNavigationPathView: View {
    @State private var navigationPath = NavigationPath()
    var body: some View {
        NavigationStack(path: $navigationPath) {
            Button("Navigate to random item") {
                navigationPath.append(Int.random(in: 1..<15))
            }
            
            List(1..<15) { num in
                NavigationLink(value: "Item \(num)") {
                    Label("Item \(num)", systemImage: "\(num).circle")
                }
                
            }
            .navigationDestination(for: String.self) { str in
                Text("String details view for \(str)")
            }
            .navigationDestination(for: Int.self, destination: { int in
                Text("Int details view for \(int)")
            })
            .navigationTitle("Custom Nav View")
        }
    }
}

struct StateBasedNavView: View {
    @State private var currentSelection: String? = nil
    var body: some View {
        NavigationView(content: {
            VStack {
                NavigationLink(destination: Text("Destination X"), tag: "X", selection: $currentSelection) { 
                    Text("Navigate X")
//                    EmptyView()
                }
                NavigationLink(destination: Text("Destination Y"), tag: "Y", selection: $currentSelection) {
                    Text("Navigate Y")
//                    EmptyView()
                }
                
                Button("Navigate to X") {
                    currentSelection = "X" //We are changing the selection value to modify the controller to navigate
                }
                
                Button("Navigate to Y") {
                    currentSelection = "Y" //We are changing the selection value to modify the controller to navigate
                }
            }
            .navigationTitle("State based item nav.")
        })
    }
}

struct SaveAndLoadNavState: View {
    @StateObject private var navigationStore = NavigationStore()
    var body: some View {
        NavigationStack(path: $navigationStore.path) {
            DetailedView(id: 0)
                .navigationDestination(for: Int.self) { DetailedView(id: $0) }
                .navigationTitle("Complex Navigation")
        }
    }
}

struct DetailedView: View {
    let id: Int
    var body: some View {
        VStack {
            Text("View \(id)")
                .font(.largeTitle)
            NavigationLink("Go to random View", value: Int.random(in: 1...100))
        }
    }
}

class NavigationStore: ObservableObject {
    @Published var path = NavigationPath() {
        didSet {
            save()
        }
    }
    
    private let saveURL = URL.documentsDirectory.appendingPathComponent("SavedNavigationPath")
    
    init() {
        if let data = try? Data(contentsOf: saveURL),
           let decoded = try? JSONDecoder().decode(NavigationPath.CodableRepresentation.self, from: data)
        {
            path = NavigationPath(decoded)
        }
    }
    
    func save() {
        guard let representation = path.codable else { return }
        do {
            let data = try JSONEncoder().encode(representation)
            try data.write(to: saveURL)
        }
        catch {
            print("Failed to save Navigation state")
        }
    }
}

struct DetailView: View {
    var body: some View {
        Text("I will show you details here")
    }
}

struct ItemView: View {
    let itemName: String
    var body: some View {
        Text("Selected Item: \(itemName)")
            .font(.largeTitle)
    }
}

#Preview {
    SaveAndLoadNavState()
}
