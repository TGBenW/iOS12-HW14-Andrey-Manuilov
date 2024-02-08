import UIKit
import SnapKit

class AlbumsViewController: UIViewController, UICollectionViewDelegate {
    
    // MARK: - Outlets
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var addButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        button.tintColor = .systemBlue
        return button
    }()
    
    private lazy var separatorLine: UIView = {
        let line = UIView()
        line.backgroundColor = .systemGray
        return line
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = createCompositionalLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: "ImageCell")
        collectionView.register(CustomHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CustomHeaderView.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Albums"
        
        setupHierarchy()
        setupLayout()
    }
    
    // MARK: - Setup
    private func setupHierarchy() {
        navigationItem.leftBarButtonItem = addButton
        
        view.addSubview(scrollView)
        scrollView.addSubview(separatorLine)
        scrollView.addSubview(collectionView)
    }
    
    private func setupLayout() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        separatorLine.snp.makeConstraints { make in
            make.top.equalTo(scrollView.contentLayoutGuide.snp.top)
            make.left.equalTo(scrollView.frameLayoutGuide).offset(20)
            make.right.equalTo(scrollView.frameLayoutGuide)
            make.height.equalTo(0.2) // thin line
            }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(separatorLine.snp.bottom)
            make.left.right.equalTo(scrollView.frameLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide.snp.width)
            make.bottom.equalTo(scrollView.contentLayoutGuide.snp.bottom).offset(-20)
//            make.height.equalTo(scrollView.frameLayoutGuide).offset(-20)
            make.height.equalTo(800)
            }
        
    }
    
    // MARK: - Actions
    @objc private func addButtonTapped() {
        print("+ button tapped") // + button action placeholder
    }
    
    @objc private func seeAllTapped() {
        // Handle the tap event, e.g., navigate to a screen showing all albums
        print("See All tapped in My Albums section")
    }
}

// MARK: - UICollectionViewDataSource

extension AlbumsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myAlbumsContent.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? ImageCell else {
            fatalError("Cannot dequeue ImageCell")
        }
        
        let model = myAlbumsContent[indexPath.item]
        cell.configure(with: model)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CustomHeaderView.identifier, for: indexPath) as? CustomHeaderView else {
            fatalError("Could not dequeue CustomHeaderView")
        }
        header.seeAllButton.addTarget(self, action: #selector(seeAllTapped), for: .touchUpInside)
        return header
    }
}

// EXTENSION
extension AlbumsViewController {
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let contentWidth = layoutEnvironment.container.effectiveContentSize.width
            let itemWidth = (contentWidth / 2) * 0.93 // 90% of half width for each item
            let itemHeight = itemWidth * 2.5 // item height
                        
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .absolute(itemWidth),
                heightDimension: .absolute(itemHeight)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let totalItemHeight = itemHeight
                        
                        let groupSize = NSCollectionLayoutSize(
                            widthDimension: .absolute(itemWidth),
                            heightDimension: .absolute(totalItemHeight)
                        )

            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 2) // group configuration
            group.interItemSpacing = .fixed(0) // space between rows

            let section = NSCollectionLayoutSection(group: group) // section configuration
            section.orthogonalScrollingBehavior = .continuous
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0)

            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), // header configuration
                                                    heightDimension: .estimated(50))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                     elementKind: UICollectionView.elementKindSectionHeader,
                                                                     alignment: .top)
            section.boundarySupplementaryItems = [header]

            return section
        }
        return layout
    }
}
