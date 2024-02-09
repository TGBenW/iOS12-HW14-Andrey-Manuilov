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
    
    private lazy var collectionView: UICollectionView = {
        let layout = createCompositionalLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: "ImageCell")
        collectionView.register(SharedCell.self, forCellWithReuseIdentifier: "SharedCell")
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
        scrollView.addSubview(collectionView)
    }
    
    private func setupLayout() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.contentLayoutGuide.snp.top)
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
}

// MARK: - UICollectionViewDataSource

extension AlbumsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].items.count    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIdentifier = indexPath.section == 0 ? "ImageCell" : "SharedCell"
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? ImageCell else {
            fatalError("Cannot dequeue cell with identifier: \(cellIdentifier)")
        }
        let model = sections[indexPath.section].items[indexPath.item]
        cell.configure(with: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CustomHeaderView.identifier, for: indexPath) as? CustomHeaderView else {
                fatalError("Could not dequeue CustomHeaderView")
            }

            let sectionTitle = sections[indexPath.section].title // set section header title from sections array
            header.setTitle(sectionTitle)

            return header
        }
}

// EXTENSION
extension AlbumsViewController {
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            if sectionIndex == 0 {
                return self.createMyAlbumsSection(using: layoutEnvironment)
            } else {
                return self.createSharedAlbumsSection(using: layoutEnvironment)
            }
        }
        return layout
    }
    
    private func createMyAlbumsSection(using layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let contentWidth = layoutEnvironment.container.effectiveContentSize.width
        let itemWidth = (contentWidth / 2) * 0.93 // 90% of half width for each item
        let itemHeight = itemWidth * 2.5 // item height
                        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(itemWidth),
            heightDimension: .absolute(itemHeight)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
                        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(itemWidth),
            heightDimension: .absolute(itemHeight)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 2) // group configuration
        group.interItemSpacing = .fixed(0) // space between rows

        let section = NSCollectionLayoutSection(group: group) // section configuration
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 10, trailing: 0)

        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), // header configuration
                                                heightDimension: .estimated(50))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                elementKind: UICollectionView.elementKindSectionHeader,
                                                                alignment: .top)
        section.boundarySupplementaryItems = [header]

        return section
    }
    
    private func createSharedAlbumsSection(using layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let contentWidth = layoutEnvironment.container.effectiveContentSize.width
        let itemWidth = (contentWidth / 2) * 0.93
        let itemHeight = itemWidth * 1.25

        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(itemWidth), heightDimension: .absolute(itemHeight))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(itemWidth), heightDimension: .absolute(itemHeight))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(0)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0)

        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        section.boundarySupplementaryItems = [header]

        return section
    }
}
