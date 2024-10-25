
import SwiftUI

@main
struct DownloadImageWithProgressBarApp: App {
    var body: some Scene {
        WindowGroup {
            DownloadImageView(viewModel: DownloadImageViewModel())
        }
    }
}
