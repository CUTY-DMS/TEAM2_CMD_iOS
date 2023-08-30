import UIKit
import SnapKit
import Then

class SginInAfterTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("3")
        setupTabbarLayout()
        setupTabbarItem()
    }
    
    func setupTabbarLayout() {
        tabBar.tintColor = UIColor(named: "Main1")
        tabBar.backgroundColor = .white
    }
    
    func setupTabbarItem() {
        let firstViewController = MainHomeViewController()
        firstViewController.tabBarItem = UITabBarItem(
            title: "시간표",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house")
        )
        
        let secondViewController = StudentInfoViewController()
        secondViewController.tabBarItem = UITabBarItem(
            title: "학생정보",
            image: UIImage(systemName: "info.circle"),
            selectedImage: UIImage(systemName: "info.circle")
        )
        
        let thirdViewController = NotificationViewController()
        thirdViewController.tabBarItem = UITabBarItem(
            title: "공지사항",
            image: UIImage(systemName: "bell.fill"),
            selectedImage: UIImage(systemName: "bell.fill")
        )
        
        let fourViewController = MyPageViewController()
        fourViewController.tabBarItem = UITabBarItem(
            title: "마이페이지",
            image: UIImage(systemName: "person.crop.circle.fill"),
            selectedImage: UIImage(systemName: "person.crop.circle.fill")
        )
        
        viewControllers = [
            firstViewController,
            secondViewController,
            thirdViewController,
            fourViewController
        ]
    }
}
