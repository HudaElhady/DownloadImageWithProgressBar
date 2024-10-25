
import Foundation

protocol DownloadImageViewModelProtocol {
    var input: DownloadImageViewModel.Input { get }
    var output: DownloadImageViewModel.Output { get }
}

extension DownloadImageViewModel {
    class Input: ObservableObject {
        let downloadImageTrigger: AnyUIEvent<Void> = .create()
    }
}

extension DownloadImageViewModel {
    class Output: ObservableObject {
        @Published var imageData: Data?
        @Published var progress: Double = 0
    }
}

class DownloadImageViewModel: ViewModel, ViewModelType {
    var input: Input
    var output: Output
    let repository: ImageRepositoryProtocol

    init(repository: ImageRepositoryProtocol = ImageRepository()) {
        self.input = .init()
        self.output = .init()
        self.repository = repository
        
        super.init()
        
        setupObservables()
    }
}

private extension DownloadImageViewModel {
    func setupObservables() {
        observeDownloadImageTrigger()
        observeDownloadProgress()
    }

    func observeDownloadImageTrigger() {
        input
            .downloadImageTrigger
            .sink { [weak self] in
                self?.getImage()
            }
            .store(in: &cancellables)
    }
    
    func observeDownloadProgress() {
        repository
            .downloadProgress
            .assign(to: &output.$progress)
    }

    func getImage() {
        Task {
            @MainActor in
            let result = try? await repository.fetchImage()
            guard let image = result else { return }
            output.imageData = image
        }
    }
}
