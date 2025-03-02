import Foundation

enum ReviewErrors: Error {
    case reviewProviderError(GetReviewsError)
    case unknownError(Error)
    
    init(_ error: Error) {
        if let error = error as? GetReviewsError {
            self = .reviewProviderError(error)
        } else {
            self = .unknownError(error)
        }
    }
    
    var localizedDescription: NSAttributedString {
        switch self {
        case .reviewProviderError:
            return "Что-то пошло не так...".attributed(font: .text)
        case .unknownError:
            return "Неизвесная ошибка".attributed(font: .text)
        }
    }
}
