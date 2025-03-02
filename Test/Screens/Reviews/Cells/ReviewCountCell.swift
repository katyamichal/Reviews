import UIKit

struct ReviewCountCellConfig {
    
    static let reuseId = String(describing: ReviewCountCellConfig.self)
    
    let reviewCountText: NSAttributedString
        
    fileprivate let layout = ReviewCountCellLayout()
}

// MARK: - TableCellConfig

extension ReviewCountCellConfig: TableCellConfig {
    
    func update(cell: UITableViewCell) {
        guard let cell = cell as? ReviewCountCell else { return }
        cell.reviewCountTextLabel.attributedText = reviewCountText
        cell.config = self
    }
    
    func height(with size: CGSize) -> CGFloat {
        layout.height(config: self, maxWidth: size.width)
    }
    
}

// MARK: - Cell

final class ReviewCountCell: UITableViewCell {
    
    fileprivate var config: Config?
    
    fileprivate let reviewCountTextLabel = UILabel()
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let layout = config?.layout else { return }
        reviewCountTextLabel.frame = layout.reviewCountTextLabelFrame
    }
    
}

// MARK: - Private

private extension ReviewCountCell {
    
    func setupCell() {
        setupReviewCountLable()
    }
    
    func setupReviewCountLable() {
        contentView.addSubview(reviewCountTextLabel)
    }
}

private final class ReviewCountCellLayout {
    
    // MARK: - Фреймы
    
    private(set) var reviewCountTextLabelFrame = CGRect.zero
    
    // MARK: - Отступы
    
    private let insets = UIEdgeInsets(top: 9.0, left: 12.0, bottom: 9.0, right: 12.0)
    
    func height(config: Config, maxWidth: CGFloat) -> CGFloat {
        let width = maxWidth - insets.left - insets.right
        
        let textWidth = config.reviewCountText.boundingRect(width: width).size.width
        let textHeight = config.reviewCountText.boundingRect(width: width).size.height
        
        // Центрирование по горизонтали
        let xPosition = (maxWidth - textWidth) / 2
        
        reviewCountTextLabelFrame = CGRect(
            origin: CGPoint(x: xPosition, y: insets.top),
            size: CGSize(width: textWidth, height: textHeight)
        )
        
        return reviewCountTextLabelFrame.maxY + insets.bottom
    }
    
}


// MARK: - Typealias

fileprivate typealias Config = ReviewCountCellConfig
fileprivate typealias Layout = ReviewCountCellLayout
