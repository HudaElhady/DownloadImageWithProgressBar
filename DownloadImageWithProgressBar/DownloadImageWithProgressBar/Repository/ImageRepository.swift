
import Foundation

protocol ImageRepositoryProtocol {
    var downloadProgress: Published<Double>.Publisher { get }
    func fetchImage() async throws -> Data?
}

class ImageRepository: ImageRepositoryProtocol {
    
    @Published private var _downloadProgress: Double = 0
    public var downloadProgress: Published<Double>.Publisher { $_downloadProgress }
    
    func fetchImage() async throws -> Data? {
        guard let url = URL(string: "https://picsum.photos/200/300")
        else {
            throw "Invalid URL."
        }
        
        let result: (downloadStream: URLSession.AsyncBytes, response: URLResponse)
        result = try await URLSession.shared.bytes(from: url)
        
        guard (result.response as? HTTPURLResponse)?.statusCode == 200
        else {
            throw "The server responded with an error."
        }
        
        let contentLength = (result.response as? HTTPURLResponse)?.expectedContentLength ?? 0
        var fileData: Data = .init()
        var downloadedBytes = 0
        
        for try await chunk in result.downloadStream {
            fileData.append(chunk)
            downloadedBytes += 1
            
            let currentProgress = Double(downloadedBytes) / Double(contentLength)
            await MainActor.run {
                _downloadProgress = currentProgress
            }
        }

        return fileData
    }
}
