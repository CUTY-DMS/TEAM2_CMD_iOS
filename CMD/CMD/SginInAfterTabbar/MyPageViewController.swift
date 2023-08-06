//
//  MyPageViewController.swift
//  CMD
//
//  Created by 이태규 on 2023/07/16.
//

import UIKit
import SnapKit
import Then
import Alamofire

class MyPageViewController: UIViewController {
    
    var userInfo: UserInfoModel?
    
    let EditInfoVC = EditInfoViewController()

    private let profileTitleImageView = UIImageView().then {
        $0.backgroundColor = .white
        $0.image = UIImage(named: "MainLogo")
    }

    var profileTitleNameLabel = UILabel().then {
        $0.text = "의지니"
        $0.font = UIFont.systemFont(ofSize: 30, weight: .bold)
    }
    private let profileInfoLabel = UILabel().then {
        $0.text = "회원 정보"
        $0.font = UIFont.systemFont(ofSize: 22, weight: .bold)
    }
    private let editProfileButton = UIButton().then {
        $0.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    private let logoutButton = UIButton().then {
        $0.setTitle("로그아웃", for: .normal)
        $0.backgroundColor = .systemRed
        $0.setTitleColor(.black, for: .normal)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.red.cgColor
        $0.layer.cornerRadius = 5
        $0.layer.shadowColor = UIColor.gray.cgColor
        $0.layer.shadowOpacity = 1.0
        $0.layer.shadowOffset = CGSize.zero
        $0.layer.shadowRadius = 1
    }
    private let nameLabel = UILabel().then {
        $0.text = "이름"
    }
    var profileNameLabel = UILabel().then {
        $0.text = "의지니"
        $0.font = UIFont.systemFont(ofSize: 17, weight: .bold)
    }
    private let classNumLabel = UILabel().then {
        $0.text = "학번"
    }
    var profileClassNumLabel = UILabel().then {
        $0.text = "1211"
        $0.font = UIFont.systemFont(ofSize: 17, weight: .bold)
    }
    private let birthdayLabel = UILabel().then {
        $0.text = "생년월일"
    }
    var profileBirthdayLabel = UILabel().then {
        $0.text = "070910"
        $0.font = UIFont.systemFont(ofSize: 17, weight: .bold)
    }
    private let fieldOfStudyLabel = UILabel().then {
        $0.text = "전공 분야"
    }
    var profileFieldOfStudyLabel = UILabel().then {
        $0.text = "Frontend"
        $0.font = UIFont.systemFont(ofSize: 17, weight: .bold)
    }
    private let majorClubLabel = UILabel().then {
        $0.text = "전공 동아리"
    }
    var profileMajorClubLabel = UILabel().then {
        $0.text = "RMA"
        $0.font = UIFont.systemFont(ofSize: 17, weight: .bold)
    }
    private let seatLabel = UILabel().then {
        $0.text = "자리 배치"
        $0.font = UIFont.systemFont(ofSize: 22, weight: .bold)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        addSubView()
        setLayout()
//        setMyProfile()
        self.editProfileButton.addTarget(self, action: #selector(self.editProfile), for: .touchUpInside)
        self.logoutButton.addTarget(self, action: #selector(self.logout), for: .touchUpInside)
        
        fetchUserInfoFromServer { [weak self] result in
            switch result {
            case .success(let userInfo):
                // 사용자 정보를 라벨에 표시합니다.
                self?.updateLabels(with: userInfo)
            case .failure(let error):
                print("Error fetching user info: \(error)")
            }
        }
    }
    
    
    private func updateLabels(with userInfo: UserInfoModel) {
        profileNameLabel.text = userInfo.username
        var classNum: String = String(userInfo.grader) + String(userInfo.schoolClass) + String(userInfo.number)
        profileClassNumLabel.text = classNum
        profileBirthdayLabel.text = String(userInfo.birth)
        profileFieldOfStudyLabel.text = userInfo.majorType
        profileMajorClubLabel.text = userInfo.club
    }
//    func setMyProfile() {
//        if let userInfo = userInfo {
//            var classNum: String = String(userInfo.grader) + String(userInfo.schoolClass) + String(userInfo.number)
//            profileNameLabel.text = userInfo.username
//            profileClassNumLabel.text = classNum
//            profileBirthdayLabel.text = userInfo.birthday
//            profileFieldOfStudyLabel.text = userInfo.majorType
//            profileMajorClubLabel.text = userInfo.club
//        }
//    }
    
    func fetchUserInfoFromServer(completion: @escaping (Result<UserInfoModel, Error>) -> Void) {
        let baseURL = "http://52.65.160.119:8080"
        let userInfoURL = URL(string: "\(baseURL)/student")!

        AF.request(userInfoURL, method: .get).responseDecodable(of: UserInfoModel.self) { response in
            switch response.result {
            case .success(let userInfo):
                completion(.success(userInfo))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    @objc func editProfile() {
        self.navigationController?.pushViewController(EditInfoViewController(), animated: true)
    }
    
    @objc func logout() {
        UserDefaults.standard.removeObject(forKey: "username")
        UserDefaults.standard.removeObject(forKey: "password")
        UserDefaults.standard.synchronize()
        
        self.navigationController?.pushViewController(SginInViewController(), animated: true)
    }
    
    func addSubView() {
        [
            profileTitleImageView,
            profileTitleNameLabel,
            profileInfoLabel,
            editProfileButton,
            logoutButton,
            nameLabel,
            profileNameLabel,
            classNumLabel,
            profileClassNumLabel,
            birthdayLabel,
            profileBirthdayLabel,
            fieldOfStudyLabel,
            profileFieldOfStudyLabel,
            majorClubLabel,
            profileMajorClubLabel,
            seatLabel
        ].forEach {
            view.addSubview($0)
        }
    }
    
    
    func setLayout() {
        profileTitleImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(80)
            $0.left.equalToSuperview().inset(175)
        }
        profileTitleNameLabel.snp.makeConstraints {
            $0.top.equalTo(profileTitleImageView).inset(90)
            $0.left.equalToSuperview().inset(178)
        }
        profileInfoLabel.snp.makeConstraints {
            $0.top.equalTo(profileTitleNameLabel).inset(65)
            $0.left.equalToSuperview().inset(40)
        }
        editProfileButton.snp.makeConstraints {
            $0.top.equalTo(profileTitleNameLabel).inset(67)
            $0.left.equalTo(profileInfoLabel).inset(86)
        }
        logoutButton.snp.makeConstraints {
            $0.top.equalTo(profileTitleNameLabel).inset(60)
            $0.left.equalTo(editProfileButton).inset(184)
            $0.right.equalToSuperview().inset(35)
        }
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(profileInfoLabel).inset(55)
            $0.left.equalToSuperview().inset(40)
        }
        profileNameLabel.snp.makeConstraints {
            $0.top.equalTo(profileInfoLabel).inset(55)
            $0.left.equalToSuperview().inset(125)
        }
        classNumLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel).inset(45)
            $0.left.equalToSuperview().inset(40)
        }
        profileClassNumLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel).inset(45)
            $0.left.equalToSuperview().inset(125)
        }
        birthdayLabel.snp.makeConstraints {
            $0.top.equalTo(classNumLabel).inset(45)
            $0.left.equalToSuperview().inset(40)
        }
        profileBirthdayLabel.snp.makeConstraints {
            $0.top.equalTo(classNumLabel).inset(45)
            $0.left.equalToSuperview().inset(125)
        }
        fieldOfStudyLabel.snp.makeConstraints {
            $0.top.equalTo(birthdayLabel).inset(45)
            $0.left.equalToSuperview().inset(40)
        }
        profileFieldOfStudyLabel.snp.makeConstraints {
            $0.top.equalTo(birthdayLabel).inset(45)
            $0.left.equalToSuperview().inset(125)
        }
        majorClubLabel.snp.makeConstraints {
            $0.top.equalTo(fieldOfStudyLabel).inset(45)
            $0.left.equalToSuperview().inset(40)
        }
        profileMajorClubLabel.snp.makeConstraints {
            $0.top.equalTo(fieldOfStudyLabel).inset(45)
            $0.left.equalToSuperview().inset(125)
        }
        seatLabel.snp.makeConstraints {
            $0.top.equalTo(majorClubLabel).inset(80)
            $0.left.equalToSuperview().inset(40)
        }
        
        
    }
}
