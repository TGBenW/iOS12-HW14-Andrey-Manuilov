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
let sharedPerson5 = SharedPerson(email: "person5@example.com", name: "Eston", surname: "Diggory", imageName: "estonImage")
let sharedPerson6 = SharedPerson(email: "person6@example.com", name: "Filly", surname: "Jennings", imageName: "fillyImage")

let sharedAlbumsContent: [ImageCellModel] = [
    ImageCellModel(title: "Shared Album 1", count: 1120, sharedWith: [sharedPerson1, sharedPerson2]),
    ImageCellModel(title: "Shared Album 2", count: 3495, sharedWith: [sharedPerson3]),
    ImageCellModel(title: "Shared Album 3", count: 78, sharedWith: [sharedPerson4]),
    ImageCellModel(title: "Shared Album 4", count: 45110, sharedWith: [sharedPerson5, sharedPerson6, sharedPerson3]),
    ImageCellModel(title: "Shared Album 5", count: 132, sharedWith: [sharedPerson6])
]

let place1 = Place(
    latitude: 48.8567,
    longitude: 2.3508,
    zoomMeters: 200
)

let peoplePetsImages = PeoplePetImageName(imageName: ["people1", "pet1", "people2", "people3"])

let combinedContent: [ImageCellModel] = [
    ImageCellModel(title: "People & Pets", count: 4567, peoplePetImageName: peoplePetsImages),
    ImageCellModel(title: "Places", count: 7986, place: place1)
]
