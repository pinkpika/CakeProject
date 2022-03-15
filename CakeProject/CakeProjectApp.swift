//
//  CakeProjectApp.swift
//  CakeProject
//
//  Created by cm0620 on 2022/3/15.
//

import SwiftUI

@main
struct CakeProjectApp: App {
    var body: some Scene {
        WindowGroup {
            CakeView().environmentObject(CakeModel())
        }
    }
}
