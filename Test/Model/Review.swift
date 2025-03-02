/// Модель отзыва.
struct Review: Decodable {
    
    /// Текст отзыва.
    let text: String
    /// Время создания отзыва.
    let created: String
    
    let firstName: String
    let lastName: String
    let rating: Int
    let avatarUrl: String
    
    enum CodingKeys: String, CodingKey {
        case text, created, rating
        case firstName = "first_name"
        case lastName = "last_name"
        case avatarUrl = "avatar_url"
    }
}
