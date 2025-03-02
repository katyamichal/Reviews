import Foundation
/// Модель, хранящая состояние вью модели.
struct ReviewsViewModelState {

    var items = [any TableCellConfig]()
    var limit = 20
    var offset = 0
    var shouldLoad = true
    var loadingStage: LoadingStage = .firstLoad
    var errorMessage: NSAttributedString? = nil
}

enum LoadingStage {
    case firstLoad
    case loaded
    case refreshing
    case fail
}
