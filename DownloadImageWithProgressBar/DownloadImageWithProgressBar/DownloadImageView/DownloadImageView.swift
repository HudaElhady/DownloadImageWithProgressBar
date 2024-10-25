

import SwiftUI

struct DownloadImageView: View {
    @StateObject var input: DownloadImageViewModel.Input
    @StateObject var output: DownloadImageViewModel.Output
    
    init(viewModel: DownloadImageViewModelProtocol) {
        _input = .init(wrappedValue: viewModel.input)
        _output = .init(wrappedValue: viewModel.output)
    }
    
    var body: some View {
        VStack {
            Button(action: input.downloadImageTrigger.send) {
                Text("Start image downloading")
            }
            .isHidden(output.imageData != nil)

            ProgressView(value: output.progress)
            
            Spacer()
            
            if let imageData = output.imageData,
               let image = UIImage(data: imageData) {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 400, height: 400)
            }
            
            Spacer()
        }
        .padding()
    }
}
