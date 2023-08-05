//
//  MainHomeViewController.swift
//  CMD
//
//  Created by 이태규 on 2023/07/11.
//

//로그인하면 탭바로 와야할지
//아니면 메인 화면으로 가야할지

import UIKit
import SnapKit
import Then
import DropDown

var subjectTableModel: [SubjectTableModel] = []

class MainHomeViewController: UIViewController {
    let dropDown = DropDown().then {
        $0.dataSource = [
            "1-1",
            "1-2",
            "1-3",
            "1-4",
            "2-1",
            "2-2",
            "2-3",
            "2-4",
            "3-1",
            "3-2",
            "3-3",
            "3-4"
        ]
        $0.backgroundColor = UIColor.white
        $0.cornerRadius = 5
    }
    
    let MainLabel = UILabel().then {
        $0.text = "시간표"
        $0.font = UIFont.systemFont(ofSize: 50, weight: .bold)
//        $0.textColor = .white
        $0.textColor = .black
    }
    let dateLabel = UILabel().then {
        $0.text = "2023년 07월 11일 화요일"
//        $0.textColor = .white
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 15)
    }
    let dropDownButton = UIButton().then {
        $0.setTitle("1-2", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(named: "Main1")?.cgColor
        $0.layer.cornerRadius = 5
        $0.layer.shadowColor = UIColor.gray.cgColor
        $0.layer.shadowOpacity = 1.0
        $0.layer.shadowOffset = CGSize.zero
        $0.layer.shadowRadius = 1
    }
    let tableView = UITableView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.register(SubjectTableViewControllerCell.self, forCellReuseIdentifier: "SubjectTableViewControllerCell")
        $0.separatorStyle = .none
//        $0.backgroundColor = UIColor(named: "Main1")
        $0.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .red
//        view.backgroundColor = UIColor(named: "Main1")
        dropDown.anchorView = dropDownButton
        dropDown.bottomOffset = CGPoint(x: 0, y: 40)
//        (dropDown.anchorView?.plainView.bounds.height)!
          view.backgroundColor = .white
        print("4")
        // Do any additional setup after loading the view.

        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 100
        
        dropDownButton.addTarget(self, action: #selector(showDropDown), for: .touchUpInside)
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
        dropDownButton.setTitle(item, for: .normal)
//            self.updateTableView(with: item)
            //API 들어와야함.
        }
    }
    override func viewDidLayoutSubviews() {
        addSubView()
        setLayout()
    }
    
//    func updateTableView(with selectedItem: String) {
//        subjectTableModel.append(SubjectTableModel(subjectTitleName: ["HI", "Hello", "wjWjf"]))
//    }
    
    @objc func showDropDown() {
        dropDown.show()
    }
    
    func addSubView() {
        [
            MainLabel,
            dateLabel,
            dropDownButton,
            tableView
        ].forEach({view.addSubview($0)})
    }
    
    func setLayout() {
        MainLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(100)
            $0.left.equalToSuperview().inset(60)
        }
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(MainLabel).inset(100)
            $0.left.equalToSuperview().inset(30)
        }
        dropDownButton.snp.makeConstraints {
            $0.top.equalTo(MainLabel).inset(85)
            $0.left.equalTo(dateLabel).inset(280)
            $0.right.equalToSuperview().inset(25)
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(dateLabel).inset(20)
            $0.left.equalToSuperview().inset(13)
            $0.right.equalToSuperview().inset(13)
            $0.bottom.equalToSuperview().inset(90)
        }
    }
}

extension MainHomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let customCell = tableView.dequeueReusableCell(withIdentifier: "SubjectTableViewControllerCell", for: indexPath) as! SubjectTableViewControllerCell
        // subjectTableModel 이라는 변수 안에, SubjectTableModel이라는 구조체가 있고,
        // 그 구조체 안에 subjectTitleName 이라는 배열(?)이 존재
        
        // 아니면 requset랑 response로 따로따로 받아와야함 위에 dropdown에서 requset랑 response를 받아도 될듯.
        // 배열 한개만 있어도 괜찮을 수도. 그렇게 되면 셀 갯수도 배열 갯수로 설정해야 함.
//        customCell.subject.text = subjectTableModel[indexPath.row].subjectTitleName
        
        return customCell
    }
}
