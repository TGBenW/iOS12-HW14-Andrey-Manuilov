import Foundation

struct AlbumSection { // section model
    let title: String
    let items: [ImageCellModel]
}


struct SharedPerson { // for persons in Shared Albums to extend ImageCellModel
    let email: String
    let name: String
    let surname: String
    let imageName: String? // not every person might have an associated image
    
    init(email: String, name: String, surname: String, imageName: String? = nil) {
        self.email = email
        self.name = name
        self.surname = surname
        self.imageName = imageName
    }
}

struct ImageCellModel { // image cell model
    let imageName: String
    let title: String
    let count: Int
    var isFavorite: Bool
    var sharedWith: [SharedPerson] // array of  persons albums are shared with
    
    init(title: String, count: Int, imageName: String = "placeholder_img", isFavorite: Bool = false, sharedWith: [SharedPerson] = [sharedPerson3]) {
        self.title = title
        self.count = count
        self.imageName = imageName
        self.isFavorite = isFavorite
        self.sharedWith = sharedWith
    }
}

let sections = [
    AlbumSection(title: "My Albums", items: myAlbumsContent),
    AlbumSection(title: "Shared Albums", items: sharedAlbumsContent)
]

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

let sharedPerson1 = SharedPerson(email: "person1@example.com", name: "Alice", surname: "Johnson", imageName: "aliceImage")
let sharedPerson2 = SharedPerson(email: "person2@example.com", name: "Bob", surname: "Smith")
let sharedPerson3 = SharedPerson(email: "person3@example.com", name: "Carol", surname: "Taylor", imageName: "carolImage")
let sharedPerson4 = SharedPerson(email: "person4@example.com", name: "Dave", surname: "Brown")

let sharedAlbumsContent: [ImageCellModel] = [
    ImageCellModel(title: "Shared Album 1", count: 1120, sharedWith: [sharedPerson1, sharedPerson2]),
    ImageCellModel(title: "Shared Album 2", count: 3495, sharedWith: [sharedPerson3]),
    ImageCellModel(title: "Shared Album 3", count: 78, sharedWith: [sharedPerson4]),
    ImageCellModel(title: "Shared Album 4", count: 45110, sharedWith: [sharedPerson2, sharedPerson4, sharedPerson1]),
    ImageCellModel(title: "Shared Album 5", count: 132, sharedWith: [sharedPerson1])
]
