import UIKit

final class ImageDataCache {
    static let shared = ImageDataCache()
    
    private init() {}
    
    private let cache = NSCache<NSURL, NSData>()

    func image(for url: URL) -> UIImage? {
        guard let data = cache.object(forKey: url as NSURL) else { return nil }
        return UIImage(data: data as Data)
    }

    func save(_ image: UIImage, for url: URL) {
        if let imageData = image.pngData() {
            cache.setObject(imageData as NSData, forKey: url as NSURL)
        }
    }
}

extension UIImageView {
    
    private static var taskDictionary = [UIImageView: URLSessionDataTask]()
    
    private var currentTask: URLSessionDataTask? {
        get { UIImageView.taskDictionary[self] }
        set {
            UIImageView.taskDictionary[self]?.cancel()
            UIImageView.taskDictionary[self] = newValue
        }
    }

    func setImage(with urlString: String?, defaultImage: String) {
        currentTask = nil
        self.image = UIImage(named: defaultImage)
        
        guard let urlString, let url = URL(string: urlString) else { return }
        
        if let cachedImage = ImageDataCache.shared.image(for: url) {
            self.image = cachedImage
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard
                let self,
                let data, error == nil,
                let image = UIImage(data: data)
            else { return }
            
            ImageDataCache.shared.save(image, for: url)
            
            DispatchQueue.main.async {
                self.image = image
            }
        }
        currentTask = task
        task.resume()
    }
}

