import Foundation

struct DeclensionHelper {
    func correctDeclension(for count: Int) -> String {
        let lastDigit = count % 10
        let lastTwoDigits = count % 100
        
        if lastDigit == 1 && lastTwoDigits != 11 {
            return "\(count) отзыв"
        } else if lastDigit >= 2 && lastDigit <= 4 && (lastTwoDigits < 12 || lastTwoDigits > 14) {
            return "\(count) отзыва"
        } else {
            return "\(count) отзывов"
        }
    }
}
