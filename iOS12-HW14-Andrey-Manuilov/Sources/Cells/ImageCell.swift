import UIKit

class ImageCell: UICollectionViewCell {
    
    // MARK: - Outlets
    let imageView: UIImageView = {
        let cellImage = UIImageView()
        cellImage.contentMode = .scaleAspectFill
        cellImage.clipsToBounds = true
        cellImage.layer.cornerRadius = 8
        cellImage.image = UIImage(named: "placeholder_img") // placeholder image, real ones to set in Model
        return cellImage
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.text = "placeholder" // placeholder album name
        return label
    }()
        
    let countLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        label.textColor = StyleGuide.Colors.textGray
        label.text = "11 111" // placeholder count
        return label
    }()
    
    private let heartIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "heart.fill")
        imageView.tintColor = StyleGuide.Colors.white
        return imageView
    }()
    
    // MARK: - Configuration
    func configure(with model: ImageCellModel) {
        titleLabel.text = model.title

        let formatter = NumberFormatter() // format the count with a space
        formatter.numberStyle = .decimal
        let formattedCount = formatter.string(from: NSNumber(value: model.count)) ?? "\(model.count)"
        countLabel.text = formattedCount

        imageView.image = UIImage(named: model.imageName)
        heartIconView.isHidden = !model.isFavorite
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
    func setupHierarchy() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(countLabel)
        
        imageView.addSubview(heartIconView)
        
        imageView.snp.makeConstraints { make in
            let screenWidth = UIScreen.main.bounds.width
            let imageWidth = screenWidth * 0.43
            make.width.height.equalTo(imageWidth)
            make.top.left.equalToSuperview()
        }
        
        heartIconView.snp.makeConstraints { make in
            make.left.equalTo(imageView.snp.left).offset(6)
            make.bottom.equalTo(imageView.snp.bottom).offset(-6)
            make.size.equalTo(CGSize(width: 22, height: 22))
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
        }
                
        countLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
        }
    }
    
    // MARK: - Prepare for Reuse
    override func prepareForReuse() { // reset the cell to default values
        super.prepareForReuse()
            
        imageView.image = UIImage(named: "placeholder_img")
        titleLabel.text = "placeholder"
        countLabel.text = "11 111"
        heartIconView.isHidden = true
    }
}

