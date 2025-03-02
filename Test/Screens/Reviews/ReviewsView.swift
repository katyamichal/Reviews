import UIKit

final class ReviewsView: UIView {

    private let activityIndicator = UIActivityIndicatorView()
    private let refreshControl = UIRefreshControl()
    private let errorLabel = UILabel()
    
    private let padding: CGFloat = 16
    let tableView = UITableView()
    var onRefresh: (() -> Void)?

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
    
    func update(with error: NSAttributedString?) {
        tableView.isHidden = true
        errorLabel.isHidden = false
        errorLabel.attributedText = error
        setNeedsLayout()
    }
}

// MARK: - Private

private extension ReviewsView {
    func setupFrames() {
        tableView.frame = bounds.inset(by: safeAreaInsets)
        activityIndicator.center = center
        NSLayoutConstraint.activate([
            errorLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            errorLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: padding),
            errorLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -padding)
        ])
    }

    func setupView() {
        backgroundColor = .systemBackground
        setupTableView()
        setupActivityIndicator()
        setupRefreshControl()
        setupErrorLabel()
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
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    func setupErrorLabel() {
        addSubview(errorLabel)
        errorLabel.isHidden = true
        errorLabel.lineBreakMode = .byWordWrapping
        errorLabel.numberOfLines = 0
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.textAlignment = .center
    }
    
    @objc
    func refresh() {
        refreshControl.beginRefreshing()
        onRefresh?()
    }
}
