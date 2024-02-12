import Foundation

struct RowCellModel {
    let iconName: String
    let title: String
    let count: Int
    let locked: Bool

    init(iconName: String, title: String, count: Int, locked: Bool = false) {
        self.iconName = iconName
        self.title = title
        self.count = count
        self.locked = locked
    }
}

let mediaTypesContent: [RowCellModel] = [
    RowCellModel(iconName: "photo.artframe", title: "Photos", count: 1),
    RowCellModel(iconName: "photo.artframe", title: "Photos", count: 2),
    RowCellModel(iconName: "photo.artframe", title: "Photos", count: 3),
    RowCellModel(iconName: "photo.artframe", title: "Photos", count: 4),
    RowCellModel(iconName: "photo.artframe", title: "Photos", count: 5555),
    RowCellModel(iconName: "photo.artframe", title: "Photos", count: 6),
    RowCellModel(iconName: "photo.artframe", title: "Photos", count: 7),
    RowCellModel(iconName: "photo.artframe", title: "Photos", count: 8),
    RowCellModel(iconName: "photo.artframe", title: "Photos", count: 9),
    RowCellModel(iconName: "photo.artframe", title: "Photos", count: 1010),
    RowCellModel(iconName: "photo.artframe", title: "Photos", count: 11),
    RowCellModel(iconName: "photo.artframe", title: "Photos", count: 12),
    RowCellModel(iconName: "photo.artframe", title: "Photos", count: 13),
]

let utilitiesContent: [RowCellModel] = [
    RowCellModel(iconName: "star", title: "Videos", count: 1111),
    RowCellModel(iconName: "star", title: "Videos", count: 2222),
    RowCellModel(iconName: "star", title: "Videos", count: 3333),
    RowCellModel(iconName: "star", title: "Videos", count: 444, locked: true) // locked one
]
