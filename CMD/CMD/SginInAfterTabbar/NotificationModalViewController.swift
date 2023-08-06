//
//  NotificationModalViewController.swift
//  CMD
//
//  Created by 이태규 on 2023/07/24.
//

import UIKit
import SnapKit
import Then

class NotificationModalViewController: UIViewController {

    let titleLabel = UILabel().then {
        $0.lineBreakMode = .byCharWrapping
        $0.numberOfLines = 0
        $0.text = "대충 제목 대충 제목 대충 제목"
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    }
    let titleLineUnderlineView = UIView().then {
        $0.backgroundColor = UIColor.black // 밑줄 색상 설정
    }
    let notiFicationDateLabel = UILabel().then {
        $0.text = "2023.07.17 오전 12:57"
        $0.font = UIFont.systemFont(ofSize: 15)
        $0.textColor = .gray
    }
    
    let contentLabel = UILabel().then {
        $0.lineBreakMode = .byCharWrapping
        $0.numberOfLines = 0
        $0.text = "대충 내용 대충 내용 대충 내용 대충 내용 대충 내용 대충 내용 대충 내용 대충 내용 대충 내용 대충 내용 대충 내용 대충 내용 대충 내용 대충 내용 대충 내용 대충 내용 대충 내용 대충 내용 대충 내용 대충 내용 대충 내용 대충 내용 대충 내용 대충 내용 대충 내용 대충 내용 대충 내용 대충 내용 대충 내용 대충 내용"
        $0.font = UIFont.systemFont(ofSize: 17)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Main1")
        
        // Do any additional setup after loading the view.
        addSubView()
        setLayout()
    }

    func addSubView() {
        [
            titleLabel,
            titleLineUnderlineView,
            notiFicationDateLabel,
            contentLabel
        ].forEach {
            view.addSubview($0)
        }
    }
    
    func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(30)
            $0.left.equalToSuperview().inset(30)
            $0.right.equalToSuperview().inset(30)
        }
        titleLineUnderlineView.snp.makeConstraints {
            $0.top.equalTo(titleLabel).inset(29)
            $0.left.equalToSuperview().inset(25)
            $0.right.equalToSuperview().inset(31)
            $0.bottom.equalTo(titleLabel).inset(-6)
        }
        notiFicationDateLabel.snp.makeConstraints {
            $0.top.equalTo(titleLineUnderlineView).inset(7)
            $0.left.equalToSuperview().inset(30)
            $0.right.equalToSuperview().inset(30)
        }
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(notiFicationDateLabel).inset(40)
            $0.left.equalToSuperview().inset(30)
            $0.right.equalToSuperview().inset(30)
        }
    }
}
