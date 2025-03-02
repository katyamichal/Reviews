import UIKit

final class ReviewsView: UIView {
    
    var onRefresh: (() -> Void)?
    
    let tableView = UITableView()
    private let activityIndicator = UIActivityIndicatorView()
    private let refreshControl = UIRefreshControl()
    
    private enum Constants {
        static let activityIndicatorSize: CGFloat = 30
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupFrames()
    }

    func stopLoading() {
        activityIndicator.stopAnimating()
        tableView.isHidden = false
    }
    
    func stopRefreshControl() {
        refreshControl.endRefreshing()
    }

}

// MARK: - Private

private extension ReviewsView {
    func setupFrames() {
        tableView.frame = bounds.inset(by: safeAreaInsets)
        activityIndicator.center = center
    }

    func setupView() {
        backgroundColor = .systemBackground
        setupTableView()
        setupActivityIndicator()
        setupRefreshControl()
    }

    func setupTableView() {
        addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.isHidden = true
        tableView.allowsSelection = false
        tableView.register(ReviewCell.self, forCellReuseIdentifier: ReviewCellConfig.reuseId)
        tableView.register(ReviewCountCell.self, forCellReuseIdentifier: ReviewCountCellConfig.reuseId)
    }
    
    func setupActivityIndicator() {
        addSubview(activityIndicator)
        activityIndicator.style = .medium
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
    }
    
    func setupRefreshControl() {
        tableView.refreshControl = refreshControl
        refreshControl.attributedTitle = NSAttributedString(string: "Обновляем...")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    @objc
    func refresh() {
        refreshControl.beginRefreshing()
        onRefresh?()
    }
}
