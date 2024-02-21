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
    RowCellModel(iconName: "video", title: "Videos", count: 2431),
    RowCellModel(iconName: "person.crop.square", title: "Selfies", count: 451),
    RowCellModel(iconName: "livephoto", title: "Live Photos", count: 14098),
    RowCellModel(iconName: "f.cursive.circle", title: "Portrait", count: 88),
    RowCellModel(iconName: "long-exposure", title: "Long Exposure", count: 10),
    RowCellModel(iconName: "pano", title: "Panoramas", count: 9),
    RowCellModel(iconName: "timelapse", title: "Time-lapse", count: 15),
    RowCellModel(iconName: "slowmo", title: "Slo-mo", count: 81),
    RowCellModel(iconName: "cinematic", title: "Cinematic", count: 37),
    RowCellModel(iconName: "camera.viewfinder", title: "Screenshots", count: 3040),
    RowCellModel(iconName: "record.circle", title: "Screen Recordings", count: 67),
    RowCellModel(iconName: "animated", title: "Animated", count: 5),
    RowCellModel(iconName: "r.square.on.square", title: "RAW", count: 1)
]

let utilitiesContent: [RowCellModel] = [
    RowCellModel(iconName: "square.and.arrow.down", title: "Imports", count: 850),
    RowCellModel(iconName: "square.on.square", title: "Duplicates", count: 58),
    RowCellModel(iconName: "eye.slash", title: "Hidden", count: 12, locked: true), // locked one
    RowCellModel(iconName: "trash", title: "Recently Deleted", count: 102, locked: true) // locked one
]
