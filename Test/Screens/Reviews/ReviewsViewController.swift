import UIKit

final class ReviewsViewController: UIViewController {

    private lazy var reviewsView = makeReviewsView()
    private let viewModel: ReviewsViewModel

    init(viewModel: ReviewsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = reviewsView
        title = "Отзывы"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        viewModel.getReviews()
    }

}

// MARK: - Private

private extension ReviewsViewController {

    func makeReviewsView() -> ReviewsView {
        let reviewsView = ReviewsView()
        reviewsView.tableView.delegate = viewModel
        reviewsView.tableView.dataSource = viewModel
        return reviewsView
    }
    
    func setupViewModel() {
        viewModel.onStateChange = { [weak self] state in
            switch state.loadingStage {
            case .firstLoad:
                self?.reviewsView.tableView.reloadData()
                self?.reviewsView.stopLoading()
            case .loaded, .refreshing:
                self?.reviewsView.tableView.reloadData()
            case .fail:
                self?.reviewsView.stopLoading()
                //  let errorMessage = NSAttributedString(string: "Error")
            }
        }
    }
}


