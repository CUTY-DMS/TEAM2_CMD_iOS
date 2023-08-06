//
//  NotificationViewController.swift
//  CMD
//
//  Created by 이태규 on 2023/07/11.
//

import UIKit
import SnapKit
import Then
import Alamofire

struct notice: Codable {
    let title: String
    let expiredAt: String?
}

class NotificationViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var notices: [notice] = []
    
    var collectionView: UICollectionView!
    
    let titleLabel = UILabel().then {
        $0.text = "공지사항"
        $0.font = UIFont.systemFont(ofSize: 50, weight: .bold)
        $0.textColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Main1")
        print("8")
        // Do any additional setup after loading the view.
        
        // 컨테이너 뷰 생성
        fetchAdminNotices()
        
        let containerView = UIView()
        containerView.backgroundColor = UIColor(named: "Main1")
        
        // 컬렉션 뷰 레이아웃 설정
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 194, height: 173)
        
        // 컬렉션 뷰 생성
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor(named: "Main1")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        
        // 서브뷰 추가 및 제약 조건 설정
        view.addSubview(containerView)
        containerView.addSubview(collectionView)
        containerView.addSubview(titleLabel)
        
        containerView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(50)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(160)
            $0.left.equalToSuperview().inset(13)
            $0.right.equalToSuperview().inset(13)
            $0.bottom.equalToSuperview().inset(85)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(50)
            $0.left.equalToSuperview().inset(60)
        }
        self.collectionView!.register(NotificationCollectionViewCustomCell.self, forCellWithReuseIdentifier: NotificationCollectionViewCustomCell.identifier)
    }
    
    
    
    //API
    func fetchAdminNotices() {
            let baseURL = "http://52.65.160.119:8080"
            let adminNoticesURL = "\(baseURL)/notification/list" // 서버 API 엔드포인트 URL for admin notices

            AF.request(adminNoticesURL, method: .get).responseData(queue: .main) { response in
                switch response.result {
                case .success(let data):
                    // 서버에서 받아온 JSON 데이터 파싱
                    do {
                        let decoder = JSONDecoder()
                        self.notices = try decoder.decode([notice].self, from: data)
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
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notices.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NotificationCollectionViewCustomCell", for: indexPath) as! NotificationCollectionViewCustomCell
        
        let notice = notices[indexPath.item]
        
        cell.notiFicationTitleLabel.text = notice.title
        cell.notiFicationDateLabel.text = notice.expiredAt
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let newViewController = NotificationModalViewController()
        newViewController.modalPresentationStyle = .overFullScreen // 아래에서 올라오는 스타일
        
        // 필요한 경우 새로운 뷰 컨트롤러에 데이터를 전달하는 등의 설정 가능
        
        present(NotificationModalViewController(), animated: true, completion: nil)
        print("선택한 셀: \(indexPath.item)")
    }

}
