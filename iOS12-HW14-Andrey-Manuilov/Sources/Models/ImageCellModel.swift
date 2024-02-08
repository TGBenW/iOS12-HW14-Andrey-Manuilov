import Foundation

struct ImageCellModel {
    let imageName: String
    let title: String
    let count: Int
    var isFavorite: Bool = false // default value

    init(title: String, count: Int, imageName: String = "placeholder_img", isFavorite: Bool = false) { // custom init
        self.title = title
        self.count = count
        self.imageName = imageName
        self.isFavorite = isFavorite
    }
}

let myAlbumsContent: [ImageCellModel] = [
    ImageCellModel(title: "Album 1", count: 1120),
    ImageCellModel(title: "Album 2", count: 3495, isFavorite: true),
    ImageCellModel(title: "Album 3", count: 78),
    ImageCellModel(title: "Album 4", count: 45110),
    ImageCellModel(title: "Album 5", count: 132),
    ImageCellModel(title: "Album 6", count: 1180),
    ImageCellModel(title: "Album 7", count: 60),
    ImageCellModel(title: "Album 8", count: 45),
    ImageCellModel(title: "Album 9", count: 88),
    ImageCellModel(title: "Album 10", count: 100)
]
