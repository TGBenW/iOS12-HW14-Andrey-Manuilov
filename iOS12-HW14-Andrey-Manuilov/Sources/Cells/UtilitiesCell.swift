import UIKit

class UtilitiesCell: MediaTypeCell {
    
    // MARK: - Outlets
    private let lockImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        imageView.tintColor = StyleGuide.Colors.imageTintGray
        return imageView
    }()
    
    // MARK: - Configuration
    override func configure(with model: RowCellModel) {
        super.configure(with: model)
        
        iconImageView.image = UIImage(systemName: model.iconName) ?? UIImage(systemName: "exclamationmark.triangle.fill")
        titleLabel.text = model.title
        
        if model.locked {
            lockImageView.isHidden = false
            lockImageView.image = UIImage(systemName: "lock.fill")
            countLabel.isHidden = true
        } else {
            lockImageView.isHidden = true
            countLabel.isHidden = false
            
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            let formattedCount = formatter.string(from: NSNumber(value: model.count)) ?? "\(model.count)"
            countLabel.text = formattedCount
        }
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLockImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupLockImageView() {
        contentView.addSubview(lockImageView)
        
        lockImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(chevronImageView.snp.left).offset(-8) // place lock to the left of the chevron
            make.size.equalTo(CGSize(width: 16, height: 16)) // size for the lock icon
        }
    }
    
    // MARK: - Prepare for Reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        
        lockImageView.isHidden = true
        countLabel.isHidden = false
    }
}
