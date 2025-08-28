//
//  DashBoardView.swift
//  ROTGDemo
//
//  Created by zoondia on 07/08/25.


import SwiftUI


struct DashBoardView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var desiredWidth: CGFloat = 0
    @State var desiredHeight: CGFloat = 0
    
    var body: some View {
        
        NavigationView {
            
            VStack (alignment: .leading) {
                let screenHeight = UIScreen.main.bounds.height
                topBarView
                    .padding(.horizontal, 28.5)
                    .frame(height: screenHeight * 0.10)
                
                ScrollView {
                    VStack (alignment: .leading) {
                        observationContentsView
                        
                        groupTitleView
                            .padding(.horizontal, 28.5)
                            .padding(.top, 42)
                        
                        groupContentsView
                            .padding(.top, 18.5)
                    }
                }
                .background(Color.clrPaleGrey).ignoresSafeArea()
                
            }
        }
    }
    
    
    var topBarView: some View {
        HStack {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("<-")
                    .frame(width: 19, height: 15.5)
                    .foregroundColor(Color.clrDarkIndigo)
                
            }
            
            Text("Homee")
                .font(.custom("Poppins-SemiBold", size: 19.3))
                .foregroundColor(Color.clrDarkIndigo)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .padding(.trailing, 19)
        }
    }
    
    
    var viewObservationView: some View {

        HStack {
            Image(.noteBookIcon)
                .resizable()
                .frame(width: 25.5, height: 26)
            
            Text("View Observation")
                .foregroundColor(.white)
                .font(.custom("Poppins-Regular", size: 13))
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 82)
        .background(
            LinearGradient(gradient: Gradient(colors: [.clrCarolinaBlue, .clrCornflour]), startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .cornerRadius(9)
    }
    
    
    var observationDraftView: some View {
        HStack {
            Image(.draft)
                .resizable()
                .frame(width: 25.5, height: 26)
            
            Text("Observation     Draft")
                .foregroundColor(.white)
                .font(.custom("Poppins-Regular", size: 13))
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 82)
        .background(
            LinearGradient(gradient: Gradient(colors: [.clrWheat, .clrSalmon]), startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .cornerRadius(9)
    }
    
    
    var notLinkedtoAGroupView: some View {
        HStack {
            Image(.groupIcon)
                .resizable()
                .frame(width: 25.5, height: 26)
            
            Text("Not Linked to A Group")
                .foregroundColor(.white)
                .font(.custom("Poppins-Regular", size: 13))
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 82)
        .background(
            LinearGradient(gradient: Gradient(colors: [.clrBrightCyanTwo, .clrBrightSkyBlue]), startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .cornerRadius(9)
    }
    
    
    var createObservationView: some View {
        HStack {
            Image(.addIcon)
                .resizable()
                .frame(width: 25.5, height: 26)
            
            Text("Create Observation")
                .foregroundColor(.white)
                .font(.custom("Poppins-Regular", size: 13))
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 82)
        .background(
            LinearGradient(gradient: Gradient(colors: [.clrSoftGreen, .clrDarkMint]), startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .cornerRadius(9)
    }
    
    
    var observationContentsView: some View {
        
            VStack (alignment: .leading) {
                
                Text("Observartion")
                    .font(.custom("Poppins-SemiBold", size: 17))
                    .foregroundColor(Color.clrDarkIndigo)
                    .padding(.bottom, 22.5)
                
                VStack (spacing: 13.5) {
                    HStack (spacing: 16.5) {
                        viewObservationView
                        
                        observationDraftView
                    }
                    
                    HStack (spacing: 16.5) {
                        notLinkedtoAGroupView
                        
                        createObservationView
                    }
                }
                .padding(.bottom, 36.5)
            }
            .padding(.horizontal, 28.5)
            .background(Color.clrWhiteThree)
            .clipShape(RoundedCorner(radius: 30, corners: [.bottomLeft, .bottomRight]))
            .shadow(radius: 24.5, x: 0, y: 6.5)
    }
    
    
    var groupContentsView: some View {
        VStack (alignment: .leading) {
            HStack {
                EachGroupView(image: "PEOPLEICONIMAGE", textOne: "View", textTwo: "Group")
                
                EachGroupView(image: "inviteImage", textOne: "Invite Users to", textTwo: "Group")
                    .padding(.leading, 16)
            }
            
            HStack {
                EachGroupView(image: "requestImage", textOne: "Request Access", textTwo: "to Group")

                EachGroupView(image: "addImage", textOne: "Create New", textTwo: "Group")
                    .padding(.leading, 16)
            }
            .padding(.top, 13)
        }
        .padding(.horizontal, 29)
    }
    
    
    struct EachGroupView: View {
        @State var image: String
        @State var textOne: String
        @State var textTwo: String
        
        
        var body: some View {
            VStack {
                Image("\(image)")
                    .resizable()
                    .frame(width: 33, height: 28.5)

                VStack {
                    Text("\(textOne)")
                        .font(.custom("Poppins-Medium", size: 12.8))
                        .foregroundColor(Color.clrDarkIndigo)
                    Text("\(textTwo)")
                        .font(.custom("Poppins-Medium", size: 12.8))
                }
            }
            .padding()
            .frame(minWidth: 150.5, maxWidth: .infinity, minHeight: 106.5, maxHeight: .infinity)
            .background(Color.white)
            .cornerRadius(9)
        }
    }
    

    
    var groupTitleView: some View {
        Text("Group")
            .font(.custom("Poppins-SemiBold", size: 17))
            .foregroundColor(Color.clrDarkIndigo)
    }
    
    
    struct RoundedCorner: Shape {
        var radius: CGFloat = .infinity
        var corners: UIRectCorner = .allCorners

        func path(in rect: CGRect) -> Path {
            let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            return Path(path.cgPath)
        }
    }

}


#Preview {
    DashBoardView()
}
