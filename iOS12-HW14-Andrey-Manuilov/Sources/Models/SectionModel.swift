import Foundation

enum AlbumSectionItem {
    case imageCellModel(ImageCellModel)
    case rowCellModel(RowCellModel)
}

struct AlbumSection {
    let title: String
    let items: [AlbumSectionItem]
}

let sections = [
    AlbumSection(title: "My Albums", items: myAlbumsContent.map { .imageCellModel($0) }),
    AlbumSection(title: "Shared Albums", items: sharedAlbumsContent.map { .imageCellModel($0) }),
    AlbumSection(title: "People, Pets & Places", items: combinedContent.map { .imageCellModel($0) }),
    AlbumSection(title: "Media Types", items: mediaTypesContent.map { .rowCellModel($0) }),
    AlbumSection(title: "Utilities", items: utilitiesContent.map { .rowCellModel($0) })
]
