

import SwiftUI

struct DownloadImageView: View {
    var body: some View {
        VStack {
            Button(action: {}) {
                Text("Download Image")
            }
            ProgressView(value: 0.5)
        }
        .padding()
    }
}

#Preview {
    DownloadImageView()
}
