import UIKit

class SharedCell: ImageCell {
    
    // MARK: - Variables
    private static let sharedPersonRadius = 18
    private var sharedIndicators: [UIView] = []
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    override func configure(with model: ImageCellModel) {
        super.configure(with: model)
        
        sharedIndicators.forEach { $0.removeFromSuperview() }
        sharedIndicators.removeAll()
        
        for (index, sharedPerson) in model.sharedWith.prefix(5).enumerated() { // not more than 5 shared persons displayed
            let sharedIndicatorView = createSharedIndicatorView(for: sharedPerson, at: index)
            imageView.addSubview(sharedIndicatorView)
            sharedIndicators.append(sharedIndicatorView)
        }
    }
    
    // MARK: - Setup
    private func createSharedIndicatorView(for sharedPerson: SharedPerson, at index: Int) -> UIView {
        let view = UIView()
        view.backgroundColor = .gray
        view.layer.cornerRadius = CGFloat(SharedCell.sharedPersonRadius)
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 1
        imageView.addSubview(view)
        
        let overlapOffset = CGFloat(SharedCell.sharedPersonRadius * 2) * 0.5 * CGFloat(index) // right constraint for overlapping
        
        view.snp.makeConstraints { make in
            make.bottom.equalTo(imageView.snp.bottom).offset(-8)
            make.right.equalTo(imageView.snp.right).offset(-8 - overlapOffset)
            make.width.height.equalTo(CGFloat(SharedCell.sharedPersonRadius * 2))
        }
        
        let initialsLabel = UILabel()
        initialsLabel.textAlignment = .center
        initialsLabel.textColor = .white
        initialsLabel.font = UIFont.boldSystemFont(ofSize: 12)
        initialsLabel.isHidden = sharedPerson.imageName != nil
        
        let sharedPersonImageView = UIImageView()
        sharedPersonImageView.contentMode = .scaleAspectFill
        sharedPersonImageView.clipsToBounds = true
        sharedPersonImageView.layer.cornerRadius = CGFloat(SharedCell.sharedPersonRadius)
        sharedPersonImageView.isHidden = sharedPerson.imageName == nil
        
        if let imageName = sharedPerson.imageName, let image = UIImage(named: imageName) {
            sharedPersonImageView.image = image
        } else {
            let initials = "\(sharedPerson.name.prefix(1))\(sharedPerson.surname.prefix(1))"
            initialsLabel.text = initials.uppercased()
        }
        
        view.addSubview(sharedPersonImageView)
        view.addSubview(initialsLabel)
        
        sharedPersonImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        initialsLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        return view
    }
}
