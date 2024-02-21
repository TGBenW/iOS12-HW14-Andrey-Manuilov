import UIKit
import MapKit
import SnapKit

class PeoplePetsPlacesCell: ImageCell {
    // MARK: - Variables
    let innerImagePadding: CGFloat = 4
    
    // MARK: - Outlets
    private let peoplePetsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isHidden = true // people & pets images initially hidden
        return imageView
    }()
    
    let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.layer.cornerRadius = 8
        mapView.clipsToBounds = true
        mapView.isScrollEnabled = false
        mapView.isZoomEnabled = false
        mapView.isUserInteractionEnabled = false
        mapView.isHidden = true // map at places also initially hidden
        return mapView
    }()
    
    private let bubbleIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "placePointer") // image, not SF Symbol because of side ratio
        imageView.tintColor = StyleGuide.Colors.white
        return imageView
    }()
    
    private let placeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "placeImage")
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.removeFromSuperview()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupView() {
        contentView.addSubview(mapView)
        contentView.addSubview(peoplePetsImageView)
        mapView.addSubview(bubbleIconView)
        bubbleIconView.addSubview(placeImageView)
    }
    
    func setupMapHierarchy() {
        mapView.isHidden = false
        bubbleIconView.isHidden = false
        placeImageView.isHidden = false
        
        contentView.addSubview(mapView)

        mapView.addSubview(bubbleIconView)
        bubbleIconView.addSubview(placeImageView)
        configurePlaceImageView()
        
        mapView.snp.makeConstraints { make in
            let screenWidth = UIScreen.main.bounds.width
            let mapWidth = screenWidth * 0.43
            make.width.height.equalTo(mapWidth)
            make.top.left.equalToSuperview()
        }
        
        bubbleIconView.snp.makeConstraints { make in
            make.center.equalTo(mapView)
            make.width.equalTo(mapView.snp.width).multipliedBy(0.5) // bubble image equal 1/2 of mapView width
        }
        
        placeImageView.snp.makeConstraints { make in
            make.centerX.equalTo(bubbleIconView.snp.centerX)
            make.centerY.equalTo(bubbleIconView.snp.centerY).offset(-innerImagePadding * 1.2)
            make.width.equalTo(bubbleIconView.snp.width).offset(-innerImagePadding * 2)
            make.height.equalTo(placeImageView.snp.width)
        }
        
        titleLabel.snp.remakeConstraints { make in
            make.top.equalTo(mapView.snp.bottom).offset(8)
        }
                
        countLabel.snp.remakeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
        }
    }
    
    private func setupPeoplePetsLayout(with imageNames: [String]) {
        guard imageNames.count == 4 else { return }

        let screenWidth = UIScreen.main.bounds.width
        let stackWidth = screenWidth * 0.43
        let imageWidth = (stackWidth - innerImagePadding) / 2

        let topStackView = UIStackView()
        let bottomStackView = UIStackView()
        let verticalStackView = UIStackView()

        [topStackView, bottomStackView].forEach { stackView in
            stackView.axis = .horizontal
            stackView.distribution = .fillEqually
            stackView.alignment = .fill
            stackView.spacing = innerImagePadding
        }

        verticalStackView.axis = .vertical
        verticalStackView.distribution = .fillEqually
        verticalStackView.alignment = .fill
        verticalStackView.spacing = innerImagePadding

        [topStackView, bottomStackView].forEach { stackView in
            verticalStackView.addArrangedSubview(stackView)
        }

        for (index, imageName) in imageNames.enumerated() {
            let imageView = UIImageView(image: UIImage(named: imageName))
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = imageWidth / 2

            (index < 2 ? topStackView : bottomStackView).addArrangedSubview(imageView)

            imageView.snp.makeConstraints { make in
                make.width.height.equalTo(imageWidth)
            }
        }

        contentView.addSubview(verticalStackView)
        verticalStackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalTo(stackWidth)
        }

        titleLabel.snp.remakeConstraints { make in
            make.top.equalTo(verticalStackView.snp.bottom).offset(8)
        }

        countLabel.snp.remakeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
        }
    }



    
    // MARK: - Configuration
    override func configure(with model: ImageCellModel) {
        super.configure(with: model)

            mapView.isHidden = true
            peoplePetsImageView.isHidden = true

            if let place = model.place {
                mapView.isHidden = false
                setMapRegion(to: CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude), zoomMeters: place.zoomMeters)
                setupMapHierarchy()
        } else if let images = model.peoplePetImageName?.imageName {
            setupPeoplePetsLayout(with: images)
        }
    }
    
    // MARK: - Actions
    private func setMapRegion(to coordinate: CLLocationCoordinate2D, zoomMeters: Double) {
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: zoomMeters, longitudinalMeters: zoomMeters)
        mapView.setRegion(region, animated: false)
    }
    
    private func configurePlaceImageView() {
        placeImageView.layer.cornerRadius = innerImagePadding
    }
    
    // MARK: - Prepare for Reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        
        mapView.isHidden = true
        peoplePetsImageView.isHidden = true
    }

}
