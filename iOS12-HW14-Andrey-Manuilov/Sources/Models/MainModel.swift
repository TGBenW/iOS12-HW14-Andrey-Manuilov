import Foundation


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

struct Place {
    let latitude: Double
    let longitude: Double
    let zoomMeters: Double
}

struct PeoplePetImageName {
    var imageName: [String]
}

struct ImageCellModel { // image cell model
    let imageName: String
    let title: String
    let count: Int
    var isFavorite: Bool
    var sharedWith: [SharedPerson] // array of  persons albums are shared with
    var place: Place? // optional places data for a map cell
    var peoplePetImageName: PeoplePetImageName? // optional people/pet image data for a People&Pet cell
    
    init(title: String = "Album name",
         count: Int = 123,
         imageName: String = "placeholder_img",
         isFavorite: Bool = false,
         sharedWith: [SharedPerson] = [],
         place: Place? = nil,
         peoplePetImageName: PeoplePetImageName? = nil) {
        self.title = title
        self.count = count
        self.imageName = imageName
        self.isFavorite = isFavorite
        self.sharedWith = sharedWith
        self.place = place
        self.peoplePetImageName = peoplePetImageName
    }
}

let myAlbumsContent: [ImageCellModel] = [
    ImageCellModel(title: "Recents", count: 25736, imageName: "recentImage"),
    ImageCellModel(title: "Favourites", count: 192, imageName: "favouritesImage", isFavorite: true),
    ImageCellModel(title: "Past posts", count: 36, imageName: "pastPostsImage"),
    ImageCellModel(title: "Future posts", count: 21, imageName: "futurePostsImage"),
    ImageCellModel(title: "Instagram", count: 98, imageName: "instagramImage"),
    ImageCellModel(title: "Memes", count: 237, imageName: "memesImage"),
    ImageCellModel(title: "Pinterest", count: 17, imageName: "pinterestImage"),
    ImageCellModel(title: "Paris", count: 191, imageName: "parisImage"),
    ImageCellModel(title: "Spain", count: 168, imageName: "spainImage"),
    ImageCellModel(title: "Rammstein", count: 94, imageName: "rammsteinImage")
]

let sharedPerson1 = SharedPerson(email: "person1@example.com", name: "Victoria", surname: "Gudovskaya", imageName: "vickyImage")
let sharedPerson2 = SharedPerson(email: "person2@example.com", name: "Bob", surname: "Smith")
let sharedPerson3 = SharedPerson(email: "person3@example.com", name: "Denis", surname: "Gudovskiy", imageName: "denisImage")
let sharedPerson4 = SharedPerson(email: "person4@example.com", name: "Dave", surname: "Brown")
let sharedPerson5 = SharedPerson(email: "person5@example.com", name: "George", surname: "Gudovskiy", imageName: "georgeImage")
let sharedPerson6 = SharedPerson(email: "person6@example.com", name: "Eugene", surname: "Cvetkov", imageName: "eugeneImage")

let sharedAlbumsContent: [ImageCellModel] = [
    ImageCellModel(title: "Weekends", count: 120, imageName: "weekendShared", sharedWith: [sharedPerson1, sharedPerson2]),
    ImageCellModel(title: "Georgia trip", count: 495, imageName: "georgiaShared", sharedWith: [sharedPerson3]),
    ImageCellModel(title: "Turkey trip", count: 78, imageName: "turkeyShared", sharedWith: [sharedPerson4]),
    ImageCellModel(title: "Spain trip", count: 510, imageName: "spainShared", sharedWith: [sharedPerson5, sharedPerson6, sharedPerson3]),
    ImageCellModel(title: "Copenhagen trip", count: 132, imageName: "copenhagenShared", sharedWith: [sharedPerson6])
]

let place1 = Place(
    latitude: 48.8584,
    longitude: 2.2940,
    zoomMeters: 300
)

let peoplePetsImages = PeoplePetImageName(imageName: ["people1", "pet1", "people2", "people3"])

let combinedContent: [ImageCellModel] = [
    ImageCellModel(title: "People & Pets", count: 4567, peoplePetImageName: peoplePetsImages),
    ImageCellModel(title: "Places", count: 7986, place: place1)
]
