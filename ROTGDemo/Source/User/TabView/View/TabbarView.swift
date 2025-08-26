//
//  TabView.swift
//  ROTGDemo
//
//  Created by zoondia on 22/08/25.
//

import SwiftUI


struct TabbarView: View {

    var body: some View {

        HStack {
        TabView {

                DashBoardView()
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                            .font(.custom("Poppins-Regular", size: 9))
                    }
                
                
                DashBoardView()
                    .tabItem {
                        Image(systemName: "house")
                        Text("History")
                            .font(.custom("Poppins-Regular", size: 9))
                    }
                
                
                DashBoardView()
                    .tabItem {
                        Image(systemName: "house")
                        Text("Notification")
                            .font(.custom("Poppins-Regular", size: 9))
                    }
                
                
                DashBoardView()
                    .tabItem {
                        Image(systemName: "house")
                        Text("Profile")
                            .font(.custom("Poppins-Regular", size: 9))
                    }
            }
        }
        .frame(minHeight: 83.5)
        .background(Color.clrWhiteThree).ignoresSafeArea()
        .overlay(
            Circle()
                .fill(Color.clrElectricBlue)
                .frame(width: 63.5, height: 63.5)
                .overlay(
                    Image(.appIcon)
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 24, height: 32.5)
                        .foregroundColor(Color.white)
                )
                .offset(x: 3, y: 340)
        )
        
        .navigationBarBackButtonHidden(true)
    }
    
}


#Preview {
    TabbarView()
}
