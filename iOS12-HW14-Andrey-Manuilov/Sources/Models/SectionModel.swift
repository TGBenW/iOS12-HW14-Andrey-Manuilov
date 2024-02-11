import Foundation

struct AlbumSection { // section model
    let title: String
    let items: [ImageCellModel]
}

let sections = [
    AlbumSection(title: "My Albums", items: myAlbumsContent),
    AlbumSection(title: "Shared Albums", items: sharedAlbumsContent),
    AlbumSection(title: "People, Pets & Places", items: combinedContent)
]
