//
//  StudentInfoViewController.swift
//  CMD
//
//  Created by 이태규 on 2023/07/11.
//

import UIKit
import SnapKit
import Then
import Alamofire

struct studentTitle: Codable {
    var id : Int
    var username : String
    var grader : Int
    var schoolClass : Int
    var number : Int
}

class StudentInfoViewController:
    UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var studentTitles: [studentTitle] = []
    
    var collectionView: UICollectionView!
    
    let titleLabel = UILabel().then {
        $0.text = "학생정보"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 50, weight: .bold)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("6")
        
        // 컨테이너 뷰 생성
        let containerView = UIView()
        containerView.backgroundColor = .white
        
        // 컬렉션 뷰 레이아웃 설정
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 100, height: 100)
        
        // 컬렉션 뷰 생성
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        
        
        // 서브뷰 추가 및 제약 조건 설정
        view.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(collectionView)
        
        
        containerView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(50)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(50)
            $0.left.equalToSuperview().inset(60)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(150)
            $0.left.equalToSuperview().inset(30)
            $0.right.equalToSuperview().inset(30)
            $0.bottom.equalToSuperview().inset(100)
        }
        
        self.collectionView!.register(InfoCollectionViewCustomCell.self, forCellWithReuseIdentifier: InfoCollectionViewCustomCell.identifier)
    }
    
    //API
    func fetchAdminNotices() {
            let baseURL = "http://52.65.160.119:8080"
            let adminNoticesURL = "\(baseURL)/getStudentList" // 서버 API 엔드포인트 URL for admin notices

            AF.request(adminNoticesURL, method: .get).responseData(queue: .main) { response in
                switch response.result {
                case .success(let data):
                    // 서버에서 받아온 JSON 데이터 파싱
                    do {
                        let decoder = JSONDecoder()
                        self.studentTitles = try decoder.decode([studentTitle].self, from: data)
                        // 서버에서 받아온 공지사항 데이터를 컬렉션 뷰에 반영
                        self.collectionView.reloadData()
                    } catch {
                        print("Error parsing JSON: \(error)")
                    }
                case .failure(let error):
                    print("Error fetching admin notices: \(error)")
                }
            }
        }
    
    
    // 컬렉션 뷰 데이터 소스 메서드
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return studentTitles.count // 셀 개수
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InfoCollectionViewCustomCell", for: indexPath) as! InfoCollectionViewCustomCell
        cell.imageView.image = UIImage(named: "MainLogo")
        
        let studentTitle = studentTitles[indexPath.item]
        
        cell.nameLabel.text = studentTitle.username
        
        
        return cell
    }
    
    // 컬렉션 뷰 델리게이트 메서드
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let newViewController = StudentInfoModalViewController()
        newViewController.modalPresentationStyle = .overFullScreen // 아래에서 올라오는 스타일
        
        // 필요한 경우 새로운 뷰 컨트롤러에 데이터를 전달하는 등의 설정 가능
        
        present(StudentInfoModalViewController(), animated: true, completion: nil)
        print("선택한 셀: \(indexPath.item)")
    }
}
