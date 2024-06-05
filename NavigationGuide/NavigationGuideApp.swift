//
//  NavigationGuideApp.swift
//  NavigationGuide
//
//  Created by Sravanthi Chinthireddy on 05/06/24.
//

import SwiftUI

@main
struct NavigationGuideApp: App {
    var body: some Scene {
        WindowGroup {
            SaveAndLoadNavState() //make sure to replace your Specific view here. otherwise it will result in different behaviour
        }
    }
}
