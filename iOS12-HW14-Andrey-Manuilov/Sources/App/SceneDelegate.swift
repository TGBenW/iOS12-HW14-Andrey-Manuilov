import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let libraryViewController = LibraryViewController() // initialize view controllers
        let forYouViewController = ForYouViewController()
        let albumsViewController = AlbumsViewController()
        let searchViewController = SearchViewController()
        
        let libraryNavViewController = UINavigationController(rootViewController: libraryViewController) // wrap each in navigation controller
        let forYouNavViewController = UINavigationController(rootViewController: forYouViewController)
        let albumsNavViewController = UINavigationController(rootViewController: albumsViewController)
        let searchNavViewController = UINavigationController(rootViewController: searchViewController)
        
        [libraryNavViewController, forYouNavViewController, albumsNavViewController, searchNavViewController].forEach { // large titles
            $0.navigationBar.prefersLargeTitles = true
        }
        
        let tabBarViewController = UITabBarController() // tab bar controller
        tabBarViewController.setViewControllers([libraryNavViewController, forYouNavViewController, albumsNavViewController, searchNavViewController], animated: true)
        tabBarViewController.selectedIndex = 2 // albums tab opens by default
        
        libraryNavViewController.tabBarItem = UITabBarItem(
            title: "Library",
            image: UIImage(systemName: "photo.on.rectangle.angled"),
            selectedImage: UIImage(systemName: "photo.on.rectangle.angled.fill")
        )

        forYouNavViewController.tabBarItem = UITabBarItem(
            title: "For You",
            image: UIImage(systemName: "heart.text.square"),
            selectedImage: UIImage(systemName: "heart.text.square.fill")
        )

        albumsNavViewController.tabBarItem = UITabBarItem(
            title: "Albums",
            image: UIImage(systemName: "rectangle.stack"),
            selectedImage: UIImage(systemName: "rectangle.stack.fill")
        )

        searchNavViewController.tabBarItem = UITabBarItem(
            title: "Search",
            image: UIImage(systemName: "magnifyingglass"),
            selectedImage: UIImage(systemName: "magnifyingglass")
        )
        
        window = UIWindow(windowScene: windowScene) // tab bar controller -> window root view controller
        window?.rootViewController = tabBarViewController
        window?.makeKeyAndVisible()
    }
}
