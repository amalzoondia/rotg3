import SwiftUI

struct SplashScreenView: View {
    @StateObject var viewModel = SplashScreenViewModel()
    var body: some View {
        ZStack {
            Image(.logoSplashScreen)
                .frame(width: 119, height: 157)
                .padding(.leading, 126.5)
                .padding(.trailing, 129.5)
                .padding(.top, 289.5)
                .padding(.bottom, 365.5)
            
        }
        .onAppear {
            viewModel.postGeneric()
        }
    }
}


#Preview {
    SplashScreenView()
}
