//
//  ViewController.swift
//  CMD
//
//  Created by 이태규 on 2023/07/09.
//

import UIKit
import SnapKit
import Then
import Alamofire

class SginUpViewController: UIViewController {
    var pwHideCount1 = 0
    var pwHideCount2 = 0
    
    @objc func sginUpClickedBtn(_ sender: UIButton) {
        self.sginUpButton.addTarget(self, action: #selector(self.sginInViewShift), for: .touchUpInside)
    }
    
    @objc func goSignInClickedBtn(_ sender: UIButton) {
        self.goSignInButton.addTarget(self, action: #selector(self.goSginInViewShift), for: .touchUpInside)
    }
    
    // 눈 깜박깜박 부분 버튼 기능
    @objc func sginUpPWHideClickedBtn(_ sender: UIButton) {
        self.sginUpPWHideClickedBtn.addTarget(self, action: #selector(self.pwHide1), for: .touchUpInside)
    }
    @objc func sginUpCheckPWHideClickedBtn(_ sender: UIButton) {
        self.sginUpCheckPWHideClickedBtn.addTarget(self, action: #selector(self.pwHide2), for: .touchUpInside)
    }
    /* : : : : : : : : : */
    
    private let sginUpLabel = UILabel().then {
        $0.text = "회원가입"
        $0.textColor = .black
        $0.font = UIFont.boldSystemFont(ofSize: 50)
    }
    
//    let scrollView: UIScrollView = {
//      let scrollView = UIScrollView()
//      scrollView.backgroundColor = .blue
//      scrollView.translatesAutoresizingMaskIntoConstraints = false
//      return scrollView
//    }()
    
    let scrollView = UIScrollView().then {
        $0.backgroundColor = .white
    }
    let contentView = UIView().then {
        $0.backgroundColor = .white
    }
    private let sginUpIDTextField = UITextField().then {
        $0.textColor = .black
        $0.placeholder = "아이디"
        $0.borderStyle = .none
        $0.backgroundColor = .clear
        $0.autocapitalizationType = .none
    }
    private let sginUpEmailTextField = UITextField().then {
        $0.textColor = .black
        $0.placeholder = "이메일"
        $0.borderStyle = .none
        $0.backgroundColor = .clear
        $0.autocapitalizationType = .none
    }
    private let sginUpPWTextField = UITextField().then {
        $0.textColor = .black
        $0.placeholder = "비밀번호"
        $0.autocapitalizationType = .none
        $0.isSecureTextEntry = true
    }
    
    //뜬 눈
    var sginUpPWHideClickedBtn: UIButton = {
        let button = UIButton()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold)
        let image = UIImage(systemName: "eye", withConfiguration: imageConfig)
        
        button.setImage(image, for: .normal)
        button.tintColor = .lightGray
        button.backgroundColor = .white
        return button
    }()
    /* : : : : : : : : :*/
    //뜬 눈
    var sginUpCheckPWHideClickedBtn: UIButton = {
        let button = UIButton()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold)
        let image = UIImage(systemName: "eye", withConfiguration: imageConfig)
        
        button.setImage(image, for: .normal)
        button.tintColor = .lightGray
        button.backgroundColor = .white
        return button
    }()
    /* : : : : : : : : :*/
    
    private let checkPWTextField = UITextField().then {
        $0.textColor = .black
        $0.placeholder = "비밀번호 확인"
        $0.autocapitalizationType = .none
        $0.isSecureTextEntry = true
    }
    private let nameTextField = UITextField().then {
        $0.textColor = .black
        $0.placeholder = "이름"
        $0.autocapitalizationType = .none
    }
    private let classNumTextField = UITextField().then {
        $0.textColor = .black
        $0.placeholder = "학번"
        $0.autocapitalizationType = .none
    }
    private let birthdayTextField = UITextField().then {
        $0.textColor = .black
        $0.placeholder = "생년월일"
        $0.autocapitalizationType = .none
    }
    private let fieldOfStudyTextField = UITextField().then {
        $0.textColor = .black
        $0.placeholder = "전공분야"
        $0.autocapitalizationType = .none
    }
    private let majorClubTextField = UITextField().then {
        $0.textColor = .black
        $0.placeholder = "전공동아리"
        $0.autocapitalizationType = .none
    }
    
    let idUnderlineView = UIView().then {
        $0.backgroundColor = UIColor.lightGray // 밑줄 색상 설정
    }
    let emailUnderlineView = UIView().then {
        $0.backgroundColor = UIColor.lightGray // 밑줄 색상 설정
    }
    let pwUnderlineView = UIView().then {
        $0.backgroundColor = UIColor.lightGray // 밑줄 색상 설정
    }
    let checkPWUnderlineView = UIView().then {
        $0.backgroundColor = UIColor.lightGray // 밑줄 색상 설정
    }
    let nameUnderlineView = UIView().then {
        $0.backgroundColor = UIColor.lightGray // 밑줄 색상 설정
    }
    let classNumUnderlineView = UIView().then {
        $0.backgroundColor = UIColor.lightGray // 밑줄 색상 설정
    }
    let birthdayUnderlineView = UIView().then {
        $0.backgroundColor = UIColor.lightGray // 밑줄 색상 설정
    }
    let fieldOfStudyUnderlineView = UIView().then {
        $0.backgroundColor = UIColor.lightGray // 밑줄 색상 설정
    }
    let majorClubUnderlineView = UIView().then {
        $0.backgroundColor = UIColor.lightGray // 밑줄 색상 설정
    }
    
    private let sginUpButton = UIButton().then {
        $0.backgroundColor = UIColor(named: "Main1")
        $0.setTitle("회원가입", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel!.font = UIFont.boldSystemFont(ofSize: 18)
        $0.layer.cornerRadius = 2
        $0.layer.shadowColor = UIColor.gray.cgColor
        $0.layer.shadowOpacity = 1.0
        $0.layer.shadowOffset = CGSize.zero
        $0.layer.shadowRadius = 2
    }
    
    
    
    private let goSignInLabel = UILabel().then {
        $0.text = "계정이 있으신가요?"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 12)
    }
    private let goSignInButton = UIButton().then {
        $0.setTitle("로그인하기", for: .normal)
        $0.setTitleColor(UIColor.lightGray, for: .normal)
        $0.titleLabel!.font = UIFont.systemFont(ofSize: 12)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("2")
        view.backgroundColor = .white
        addSubView()
        scrollView.addSubview(contentView)
        contentViewAddSubView()
        setLayout()
        setLayoutUnderLine()
        self.navigationController?.navigationBar.isHidden = true;
        
        self.sginUpButton.addTarget(self, action: #selector(self.sginInViewShift), for: .touchUpInside)
        
        self.goSignInButton.addTarget(self, action: #selector(self.goSginInViewShift), for: .touchUpInside)
        
        self.sginUpPWHideClickedBtn.addTarget(self, action: #selector(self.pwHide1), for: .touchUpInside)
        self.sginUpCheckPWHideClickedBtn.addTarget(self, action: #selector(self.pwHide2), for: .touchUpInside)
    }
    
    //비번 부분 눈 깜박깜박하는 기능
    @objc func pwHide1() {
        if pwHideCount1 == 0 {
            sginUpPWTextField.isSecureTextEntry = false;
            pwHideCount1 += 1
        } else {
            sginUpPWTextField.isSecureTextEntry = true;
            pwHideCount1 -= 1
        }
    }
    /* : : : : : : : : :*/
    
    //비번 확인 부분 눈 깜박깜박하는 기능
    @objc func pwHide2() {
        if pwHideCount2 == 0 {
            checkPWTextField.isSecureTextEntry = false;
            pwHideCount2 += 1
        } else {
            checkPWTextField.isSecureTextEntry = true;
            pwHideCount2 -= 1
        }
    }
    /* : : : : : : : : :*/
    
    @objc func goSginInViewShift() {
        // 여긴 그냥 로그인 창으로 이동
        self.navigationController?.pushViewController(SginInViewController(), animated: true)
    }
    @objc func sginInViewShift() {
        // 여기에 회원가입이 가능한 정보들인지 확인
        
        guard let username = sginUpIDTextField.text,
              let email = sginUpEmailTextField.text,
              let password = sginUpPWTextField.text else {
            return
        }

        let parameters: [String: Any] = [
            "username": username,
            "email": email,
            "password": password
        ]

        // 회원가입 API 엔드포인트 URL (서버에 맞게 변경해야 합니다.)
        let signupURL = "https://your-server.com/api/signup"

        AF.request(signupURL, method: .post, parameters: parameters)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    // 회원가입 성공 시 처리
                    self.navigationController?.pushViewController(SginInViewController(), animated: true)
                    print("회원가입 성공: \(value)")
                    // 서버에서 받은 응답에 따라 회원가입 성공 처리를 진행합니다.

                case .failure(let error):
                    // 회원가입 실패 또는 에러 처리
                    print("회원가입 실패: \(error)")
                    // 회원가입 실패나 네트워크 에러 등을 처리합니다.
                }
            }
        self.navigationController?.pushViewController(SginInViewController(), animated: true)
    }
    func addSubView() {
        [
            sginUpLabel,
            scrollView,
            sginUpButton,
            goSignInLabel,
            goSignInButton
        ].forEach {
            view.addSubview($0)
        }
    }
    
    func contentViewAddSubView() {
        [
            sginUpIDTextField,
            sginUpEmailTextField,
            sginUpPWTextField,
            sginUpPWHideClickedBtn,
            checkPWTextField,
            sginUpCheckPWHideClickedBtn,
            nameTextField,
            classNumTextField,
            birthdayTextField,
            fieldOfStudyTextField,
            majorClubTextField,
            idUnderlineView,
            emailUnderlineView,
            pwUnderlineView,
            checkPWUnderlineView,
            nameUnderlineView,
            classNumUnderlineView,
            birthdayUnderlineView,
            fieldOfStudyUnderlineView,
            majorClubUnderlineView
        ].forEach {
            contentView.addSubview($0)
        }
    }
    func setLayout() {
        sginUpLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(110)
            $0.left.equalToSuperview().inset(50)
        }
        scrollView.snp.makeConstraints {
            $0.top.equalTo(sginUpLabel).inset(122)
            $0.left.equalToSuperview().inset(40)
            $0.right.equalToSuperview().inset(30)
            $0.bottom.equalToSuperview().inset(170)
        }
        contentView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.right.equalToSuperview()
            $0.left.equalToSuperview()
            $0.height.equalTo(970)
            $0.width.equalTo(360)
        }
        sginUpIDTextField.snp.makeConstraints {
            $0.top.equalToSuperview().inset(50)
            $0.left.equalToSuperview().inset(30)
            $0.right.equalToSuperview().inset(30)
        }
        sginUpEmailTextField.snp.makeConstraints {
            $0.top.equalTo(sginUpIDTextField).inset(102)
            $0.left.equalToSuperview().inset(30)
            $0.right.equalToSuperview().inset(70)
        }
        sginUpPWTextField.snp.makeConstraints {
            $0.top.equalTo(sginUpEmailTextField).inset(102)
            $0.left.equalToSuperview().inset(30)
            $0.right.equalToSuperview().inset(70)
        }
        // 눈알 ::
        sginUpPWHideClickedBtn.snp.makeConstraints {
            $0.top.equalTo(sginUpPWTextField)
            $0.left.equalTo(sginUpPWTextField).inset(265)
        }
        // ::
        
        checkPWTextField.snp.makeConstraints {
            $0.top.equalTo(sginUpPWTextField).inset(102)
            $0.left.equalToSuperview().inset(30)
            $0.right.equalToSuperview().inset(70)
        }
        
        // 눈알 ::
        sginUpCheckPWHideClickedBtn.snp.makeConstraints {
            $0.top.equalTo(checkPWTextField)
            $0.left.equalTo(checkPWTextField).inset(265)
        }
        // ::
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(checkPWTextField).inset(102)
            $0.left.equalToSuperview().inset(30)
            $0.right.equalToSuperview().inset(30)
        }
        classNumTextField.snp.makeConstraints {
            $0.top.equalTo(nameTextField).inset(102)
            $0.left.equalToSuperview().inset(30)
            $0.right.equalToSuperview().inset(30)
        }
        birthdayTextField.snp.makeConstraints {
            $0.top.equalTo(classNumTextField).inset(102)
            $0.left.equalToSuperview().inset(30)
            $0.right.equalToSuperview().inset(30)
        }
        fieldOfStudyTextField.snp.makeConstraints {
            $0.top.equalTo(birthdayTextField).inset(102)
            $0.left.equalToSuperview().inset(30)
            $0.right.equalToSuperview().inset(30)
        }
        majorClubTextField.snp.makeConstraints {
            $0.top.equalTo(fieldOfStudyTextField).inset(102)
            $0.left.equalToSuperview().inset(30)
            $0.right.equalToSuperview().inset(30)
        }
        sginUpButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(800)
            $0.left.equalToSuperview().inset(85)
            $0.right.equalToSuperview().inset(85)
            $0.bottom.equalTo(goSignInLabel).inset(55)
        }
        goSignInLabel.snp.makeConstraints {
            $0.top.equalTo(sginUpButton).inset(55)
            $0.left.equalToSuperview().inset(130)
            $0.bottom.equalToSuperview().inset(30)
        }
        goSignInButton.snp.makeConstraints {
            $0.top.equalTo(sginUpButton).inset(65)
            $0.left.equalTo(goSignInLabel).inset(95)
            $0.bottom.equalToSuperview().inset(40)
        }
    }
    
    func setLayoutUnderLine() {
        idUnderlineView.snp.makeConstraints {
            $0.top.equalTo(sginUpIDTextField).inset(25)
            $0.left.equalToSuperview().inset(25)
            $0.right.equalToSuperview().inset(31)
            $0.bottom.equalTo(sginUpIDTextField).inset(-4)
        }
        emailUnderlineView.snp.makeConstraints {
            $0.top.equalTo(sginUpEmailTextField).inset(25)
            $0.left.equalToSuperview().inset(25)
            $0.right.equalToSuperview().inset(31)
            $0.bottom.equalTo(sginUpEmailTextField).inset(-4)
        }
        pwUnderlineView.snp.makeConstraints {
            $0.top.equalTo(sginUpPWTextField).inset(25)
            $0.left.equalToSuperview().inset(25)
            $0.right.equalToSuperview().inset(31)
            $0.bottom.equalTo(sginUpPWTextField).inset(-5)
        }
        checkPWUnderlineView.snp.makeConstraints {
            $0.top.equalTo(checkPWTextField).inset(25)
            $0.left.equalToSuperview().inset(25)
            $0.right.equalToSuperview().inset(31)
            $0.bottom.equalTo(checkPWTextField).inset(-5)
        }
        nameUnderlineView.snp.makeConstraints {
            $0.top.equalTo(nameTextField).inset(25)
            $0.left.equalToSuperview().inset(25)
            $0.right.equalToSuperview().inset(31)
            $0.bottom.equalTo(nameTextField).inset(-4)
        }
        classNumUnderlineView.snp.makeConstraints {
            $0.top.equalTo(classNumTextField).inset(25)
            $0.left.equalToSuperview().inset(25)
            $0.right.equalToSuperview().inset(31)
            $0.bottom.equalTo(classNumTextField).inset(-4)
        }
        birthdayUnderlineView.snp.makeConstraints {
            $0.top.equalTo(birthdayTextField).inset(25)
            $0.left.equalToSuperview().inset(25)
            $0.right.equalToSuperview().inset(31)
            $0.bottom.equalTo(birthdayTextField).inset(-4)
        }
        fieldOfStudyUnderlineView.snp.makeConstraints {
            $0.top.equalTo(fieldOfStudyTextField).inset(25)
            $0.left.equalToSuperview().inset(25)
            $0.right.equalToSuperview().inset(31)
            $0.bottom.equalTo(fieldOfStudyTextField).inset(-4)
        }
        majorClubUnderlineView.snp.makeConstraints {
            $0.top.equalTo(majorClubTextField).inset(25)
            $0.left.equalToSuperview().inset(25)
            $0.right.equalToSuperview().inset(31)
            $0.bottom.equalTo(majorClubTextField).inset(-4)
        }
    }
    
}
