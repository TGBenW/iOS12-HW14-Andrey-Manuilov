import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let libraryViewController = setupViewController(LibraryViewController(), title: "Library", systemImageName: "photo.on.rectangle.angled")
        let forYouViewController = setupViewController(ForYouViewController(), title: "For You", systemImageName: "heart.text.square")
        let albumsViewController = setupViewController(AlbumsViewController(), title: "Albums", systemImageName: "rectangle.stack")
        let searchViewController = setupViewController(SearchViewController(), title: "Search", systemImageName: "magnifyingglass")
        
        let tabBarViewController = UITabBarController()
        tabBarViewController.setViewControllers([libraryViewController, forYouViewController, albumsViewController, searchViewController], animated: true)
        tabBarViewController.selectedIndex = 2 // albums tab opens by default
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = tabBarViewController
        window?.makeKeyAndVisible()
    }
    
    private func setupViewController(_ viewController: UIViewController, title: String, systemImageName: String) -> UINavigationController {
        viewController.navigationItem.largeTitleDisplayMode = .always
        
        let navController = UINavigationController(rootViewController: viewController)
        navController.navigationBar.prefersLargeTitles = true
        
        let tabBarItem = UITabBarItem(title: title, image: UIImage(systemName: systemImageName), selectedImage: UIImage(systemName: "\(systemImageName).fill"))
        viewController.tabBarItem = tabBarItem
        
        return navController
    }
}
