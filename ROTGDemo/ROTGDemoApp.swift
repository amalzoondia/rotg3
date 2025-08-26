//
//  ROTGDemoApp.swift
//  ROTGDemo
//
//  Created by zoondia on 04/08/25.
//

import SwiftUI

@main
struct ROTGDemoApp: App {
    
    @State private var showSplash: Bool = true
    
    init() {
           let tabBarAppearance = UITabBarAppearance()
           tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = UIColor.clrWhiteThree
        
        let normalAttributes: [NSAttributedString.Key: Any] = [
                   .foregroundColor: UIColor.green
               ]
               let selectedAttributes: [NSAttributedString.Key: Any] = [
                   .foregroundColor: UIColor.orange
               ]
               
               tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = normalAttributes
               tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = selectedAttributes
               
               tabBarAppearance.stackedLayoutAppearance.normal.iconColor = .green
               tabBarAppearance.stackedLayoutAppearance.selected.iconColor = .orange
               
           
           UITabBar.appearance().standardAppearance = tabBarAppearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
       }
       
    
    var body: some Scene {
        WindowGroup {
            Group {
                if showSplash {
                    SplashScreenView()
                } else {
                    LoginView()
                }
                
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        self.showSplash = false
                    }
                }
            }
        }
    }
}
