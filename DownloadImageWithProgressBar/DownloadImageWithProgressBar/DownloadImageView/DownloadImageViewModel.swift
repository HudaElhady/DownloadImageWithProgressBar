
import Foundation

protocol DownloadImageViewModelProtocol {
    var input: DownloadImageViewModel.Input { get }
    var output: DownloadImageViewModel.Output { get }
}

extension DownloadImageViewModel {
    class Input: ObservableObject {
        
    }
}

extension DownloadImageViewModel {
    class Output: ObservableObject {
        
    }
}

class DownloadImageViewModel: ViewModel, ViewModelType {
    var input: Input
    var output: Output
    
    override init() {
        self.input = .init()
        self.output = .init()
    }
}
