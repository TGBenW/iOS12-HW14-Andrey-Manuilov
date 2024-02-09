import UIKit
import SnapKit

class CustomHeaderView: UICollectionReusableView {
    static let identifier = "CustomHeaderView"
    
    // MARK: - Outlets
    private let separatorLine: UIView = {
        let line = UIView()
        line.backgroundColor = .systemGray
        return line
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()

    let seeAllButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("See All", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(separatorLine)
        addSubview(titleLabel)
        addSubview(seeAllButton)

        setupConstraints()

        seeAllButton.addTarget(self, action: #selector(seeAllTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupConstraints() {
        separatorLine.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(0.2)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        seeAllButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
        }
    }
    
    // MARK: - Actions
    func setTitle(_ title: String) {
        titleLabel.text = title
    }

    @objc func seeAllTapped() {
        print("See All tapped in \(titleLabel.text ?? "Unknown") section")
    }
}
