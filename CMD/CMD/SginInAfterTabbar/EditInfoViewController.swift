//
//  EditInfoViewControllerViewController.swift
//  CMD
//
//  Created by 이태규 on 2023/07/17.
//

import UIKit
import SnapKit
import Then
import Alamofire

class EditInfoViewController: UIViewController {

    var userInfo: UserInfoModel?
    
    @objc func edit(_ sender: UIButton) {
        self.editInfoSuccessButton.addTarget(self, action: #selector(self.didTapSaveButton), for: .touchUpInside)
    }
    
    let editInfoLabel = UILabel().then {
        $0.text = "내 정보 수정"
        $0.font = UIFont.systemFont(ofSize: 50, weight: .bold)
    }
    let nameLabel = UILabel().then {
        $0.text = "이름"
    }
    let exNameLabel = UILabel().then {
        $0.text = "ex) 홍길동"
        $0.textColor = .lightGray
    }
    let nameTextField = UITextField().then {
        $0.text = "이태규"
        $0.layer.cornerRadius = 5
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.borderWidth = 0.5
        $0.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 16.0, height: 0.0))
        $0.leftViewMode = .always
        $0.rightView = UIView(frame: CGRect(x: 0.0, y:0.0, width:16.0, height: 0.0))
        $0.rightViewMode = .always
    }
    
    let classNumLabel = UILabel().then {
        $0.text = "학번"
    }
    let exClassNumLabel = UILabel().then {
        $0.text = "ex) 1212"
        $0.textColor = .lightGray
    }
    let classNumTextField = UITextField().then {
        $0.text = "1212"
        $0.layer.cornerRadius = 5
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.borderWidth = 0.5
        $0.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 16.0, height: 0.0))
        $0.leftViewMode = .always
        $0.rightView = UIView(frame: CGRect(x: 0.0, y:0.0, width:16.0, height: 0.0))
        $0.rightViewMode = .always
    }
    
    let birthDayLabel = UILabel().then {
        $0.text = "생년월일"
    }
    let exBirthDayLabel = UILabel().then {
        $0.text = "ex) 070410"
        $0.textColor = .lightGray
    }
    let birthDayTextField = UITextField().then {
        $0.text = "070410"
        $0.layer.cornerRadius = 5
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.borderWidth = 0.5
        $0.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 16.0, height: 0.0))
        $0.leftViewMode = .always
        $0.rightView = UIView(frame: CGRect(x: 0.0, y:0.0, width:16.0, height: 0.0))
        $0.rightViewMode = .always
    }
    
    let fieldOfStudyLabel = UILabel().then {
        $0.text = "전공분야"
    }
    let exFieldOfStudyLabel = UILabel().then {
        $0.text = "ex) iOS"
        $0.textColor = .lightGray
    }
    let fieldOfStudyTextField = UITextField().then {
        $0.text = "iOS"
        $0.layer.cornerRadius = 5
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.borderWidth = 0.5
        $0.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 16.0, height: 0.0))
        $0.leftViewMode = .always
        $0.rightView = UIView(frame: CGRect(x: 0.0, y:0.0, width:16.0, height: 0.0))
        $0.rightViewMode = .always
    }
    
    let majorClubLabel = UILabel().then {
        $0.text = "전공 동아리"
    }
    let exMajorClubLabel = UILabel().then {
        $0.text = "ex) RMA"
        $0.textColor = .lightGray
    }
    let majorClubTextField = UITextField().then {
        $0.text = "RMA"
        $0.layer.cornerRadius = 5
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.borderWidth = 0.5
        $0.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 16.0, height: 0.0))
        $0.leftViewMode = .always
        $0.rightView = UIView(frame: CGRect(x: 0.0, y:0.0, width:16.0, height: 0.0))
        $0.rightViewMode = .always
    }
    
    let editInfoSuccessButton = UIButton().then {
        $0.setTitle("수정 완료", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.backgroundColor = UIColor(named: "Main1")
        $0.titleLabel!.font = UIFont.boldSystemFont(ofSize: 18)
        $0.layer.cornerRadius = 5
        $0.layer.shadowColor = UIColor.gray.cgColor
        $0.layer.shadowOpacity = 1.0
        $0.layer.shadowOffset = CGSize.zero
        $0.layer.shadowRadius = 1
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addSubView()
        setLayout()
        self.editInfoSuccessButton.addTarget(self, action: #selector(self.updateStudentInfo), for: .touchUpInside)
    }
    
    func setMyProfile() {
        if let userInfo = userInfo {
            var classNum: String = String(userInfo.grader) + String(userInfo.schoolClass) + String(userInfo.number)
            nameTextField.text = userInfo.username
            classNumTextField.text = classNum
            birthDayTextField.text = userInfo.birthday
            fieldOfStudyTextField.text = userInfo.majorType
            majorClubTextField.text = userInfo.club
        }
    }
    
    func addSubView() {
        [
            editInfoLabel,
            nameLabel,
            exNameLabel,
            nameTextField,
            classNumLabel,
            exClassNumLabel,
            classNumTextField,
            birthDayLabel,
            exBirthDayLabel,
            birthDayTextField,
            fieldOfStudyLabel,
            exFieldOfStudyLabel,
            fieldOfStudyTextField,
            majorClubLabel,
            exMajorClubLabel,
            majorClubTextField,
            editInfoSuccessButton
        ].forEach {
            view.addSubview($0)
        }
    }
    
    @objc func updateStudentInfo(username: String, grader: String, schoolClass: String, number: String, major: String, club: String, birth: String) {
        let baseURL = "http://52.65.160.119:8080"
        let EditInfoURL = URL(string: "\(baseURL)/student")!

            // 요청에 필요한 파라미터 설정
            let parameters: [String: Any] = [
                "username": username,
                "grader": grader,
                "schoolClass": schoolClass,
                "number": number,
                "major": major,
                "club": club,
                "birth": birth
            ]

            // Alamofire를 사용하여 PUT 메서드로 요청 보냄
        AF.request(EditInfoURL, method: .patch, parameters: parameters).responseJSON { [self] response in
                switch response.result {
                case .success:
                    // 학생 정보 수정 성공 시, 처리 로직 추가
                    userInfo?.username = nameTextField.text!
//                    classNumTextField.text = classNum
                    userInfo?.birthday = birthDayTextField.text!
                    userInfo?.majorType = fieldOfStudyTextField.text!
                    userInfo?.club = majorClubTextField.text!
                    self.navigationController?.pushViewController(SginInAfterTabBarController(), animated: true)
                    print("학생 정보 수정 성공!")
                case .failure(let error):
                    // 학생 정보 수정 실패 시, 에러 처리
                    print("학생 정보 수정 실패: \(error)")
                }
            }
        }
    
    @objc func didTapSaveButton() {
            // 수정할 학생 정보들
        let username = nameTextField.text
        let grader = "1"
        let schoolClass = "2"
        let number = "12"
//        let grader = gradeTextField.text
//        let schoolClass = schoolClassTextField.text
//        let number = classNumberTextField.text
        let major = fieldOfStudyTextField.text
        let club = majorClubTextField.text
        let birth = birthDayTextField.text

            // 학생 정보 수정 API 호출
        updateStudentInfo(username: username!, grader: grader, schoolClass: schoolClass, number: number, major: major!, club: club!, birth: birth!)
        }
    
    func setLayout() {
        editInfoLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(100)
            $0.left.equalToSuperview().inset(40)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(editInfoLabel).inset(160)
            $0.left.equalToSuperview().inset(40)
        }
        exNameLabel.snp.makeConstraints {
            $0.top.equalTo(editInfoLabel).inset(160)
            $0.left.equalTo(nameLabel).inset(36)
        }
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(nameLabel).inset(27)
            $0.left.equalToSuperview().inset(40)
            $0.right.equalToSuperview().inset(40)
            $0.bottom.equalTo(classNumLabel).inset(45)
        }
        
        classNumLabel.snp.makeConstraints {
            $0.top.equalTo(nameTextField).inset(70)
            $0.left.equalToSuperview().inset(40)
        }
        exClassNumLabel.snp.makeConstraints {
            $0.top.equalTo(nameTextField).inset(70)
            $0.left.equalTo(nameLabel).inset(36)
        }
        classNumTextField.snp.makeConstraints {
            $0.top.equalTo(classNumLabel).inset(27)
            $0.left.equalToSuperview().inset(40)
            $0.right.equalToSuperview().inset(40)
            $0.bottom.equalTo(birthDayLabel).inset(45)
        }
        
        birthDayLabel.snp.makeConstraints {
            $0.top.equalTo(classNumTextField).inset(70)
            $0.left.equalToSuperview().inset(40)
        }
        exBirthDayLabel.snp.makeConstraints {
            $0.top.equalTo(classNumTextField).inset(70)
            $0.left.equalTo(nameLabel).inset(65)
        }
        birthDayTextField.snp.makeConstraints {
            $0.top.equalTo(birthDayLabel).inset(27)
            $0.left.equalToSuperview().inset(40)
            $0.right.equalToSuperview().inset(40)
            $0.bottom.equalTo(fieldOfStudyLabel).inset(45)
        }
        
        fieldOfStudyLabel.snp.makeConstraints {
            $0.top.equalTo(birthDayTextField).inset(70)
            $0.left.equalToSuperview().inset(40)
        }
        exFieldOfStudyLabel.snp.makeConstraints {
            $0.top.equalTo(birthDayTextField).inset(70)
            $0.left.equalTo(nameLabel).inset(65)
        }
        fieldOfStudyTextField.snp.makeConstraints {
            $0.top.equalTo(fieldOfStudyLabel).inset(27)
            $0.left.equalToSuperview().inset(40)
            $0.right.equalToSuperview().inset(40)
            $0.bottom.equalTo(majorClubLabel).inset(45)
        }
        
        majorClubLabel.snp.makeConstraints {
            $0.top.equalTo(fieldOfStudyTextField).inset(70)
            $0.left.equalToSuperview().inset(40)
        }
        exMajorClubLabel.snp.makeConstraints {
            $0.top.equalTo(fieldOfStudyTextField).inset(70)
            $0.left.equalTo(nameLabel).inset(85)
        }
        majorClubTextField.snp.makeConstraints {
            $0.top.equalTo(majorClubLabel).inset(27)
            $0.left.equalToSuperview().inset(40)
            $0.right.equalToSuperview().inset(40)
            $0.bottom.equalTo(editInfoSuccessButton).inset(110)
        }
        
        editInfoSuccessButton.snp.makeConstraints {
            $0.top.equalTo(majorClubTextField).inset(115)
            $0.left.equalToSuperview().inset(40)
            $0.right.equalToSuperview().inset(40)
            $0.bottom.equalToSuperview().inset(100)
        }
    }
}
