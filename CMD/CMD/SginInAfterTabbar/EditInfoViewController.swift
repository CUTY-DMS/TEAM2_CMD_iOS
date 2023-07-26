//
//  EditInfoViewControllerViewController.swift
//  CMD
//
//  Created by 이태규 on 2023/07/17.
//

import UIKit
import SnapKit
import Then

class EditInfoViewController: UIViewController {

    var editName: String = "이태규"
    var editClassNum: String = "1212"
    var editBirthday: String = "070410"
    var editFieldOfStudy: String = "iOS"
    var editMajorClub: String = "RMA"
    
    @objc func edit(_ sender: UIButton) {
        self.editInfoSuccessButton.addTarget(self, action: #selector(self.editPop), for: .touchUpInside)
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
        self.editInfoSuccessButton.addTarget(self, action: #selector(self.editPop), for: .touchUpInside)
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
    
    @objc func editPop() {
        editName = nameTextField.text!
        editClassNum = classNumTextField.text!
        editBirthday = birthDayTextField.text!
        editFieldOfStudy = fieldOfStudyTextField.text!
        editMajorClub = majorClubTextField.text!

        self.navigationController?.pushViewController(MyPageViewController(), animated: true)
//        self.navigationController?.popViewController(animated: true)
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
