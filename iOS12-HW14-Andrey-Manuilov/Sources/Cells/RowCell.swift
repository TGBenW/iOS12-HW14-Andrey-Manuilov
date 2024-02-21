import UIKit

class MediaTypeCell: UICollectionViewCell {
    
    // MARK: - Outlets
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = StyleGuide.Colors.tint
        return label
    }()
    
    let countLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = StyleGuide.Colors.textGray
        return label
    }()
    
    let chevronImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = StyleGuide.Colors.tintGray4
        return imageView
    }()
    
    private let separatorLine: UIView = {
        let line = UIView()
        line.backgroundColor = StyleGuide.Colors.backgroundGray5
        return line
    }()
    
    // MARK: - Configuration
    func configure(with model: RowCellModel) {
        if let systemImage = UIImage(systemName: model.iconName) {
            iconImageView.image = systemImage
        } else if let assetImage = UIImage(named: model.iconName) {
            iconImageView.image = assetImage
            iconImageView.tintColor = StyleGuide.Colors.iconTint
        } else {
            iconImageView.image = UIImage(systemName: "exclamationmark.triangle.fill")
        }
        
        titleLabel.text = model.title
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let formattedCount = formatter.string(from: NSNumber(value: model.count)) ?? "\(model.count)"
        countLabel.text = formattedCount
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupHierarchy() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(countLabel)
        contentView.addSubview(chevronImageView)
        contentView.addSubview(separatorLine)
        
        iconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
            make.size.equalTo(CGSize(width: 26, height: 26))
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(iconImageView.snp.right).offset(12)
            make.bottom.equalToSuperview().offset(-6)
        }
        
        countLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(chevronImageView.snp.left).offset(-8)
        }
        
        chevronImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
            make.size.equalTo(CGSize(width: 10, height: 16))
        }
        
        separatorLine.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.left)
            make.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(6)
            make.height.equalTo(0.2)
        }
    }
    
    // MARK: - Actions
    func setSeparatorHidden(_ hidden: Bool) {
        separatorLine.isHidden = hidden
    }
    
    // MARK: - Prepare for Reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        
        iconImageView.image = nil
        titleLabel.text = ""
        countLabel.text = ""
        separatorLine.isHidden = false
    }
}
