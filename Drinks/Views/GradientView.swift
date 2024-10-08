import SwiftUI

struct GradientBackgroundView: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color.pink, Color.purple]),
                       startPoint: .top,
                       endPoint: .bottom)
        .ignoresSafeArea()
    }
}
