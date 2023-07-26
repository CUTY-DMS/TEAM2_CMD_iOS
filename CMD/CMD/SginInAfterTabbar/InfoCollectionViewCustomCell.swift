import Foundation
import SnapKit
import Then

var studentNameLabel: [String] = ["아니요", "진짜요?", "아 예~~"]

class InfoCollectionViewCustomCell: UICollectionViewCell {
    
    static let identifier = "InfoCollectionViewCustomCell"
    
    let imageView = UIImageView().then {
        $0.backgroundColor = .white
    }
    let nameLabel = UILabel().then {
        $0.text = "김이름"
        $0.font = UIFont.systemFont(ofSize: 15)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("7")
        contentView.backgroundColor = .white
        addSubView()
        setLayout()
    }
    
    func addSubView() {
        [
            imageView,
            nameLabel
        ].forEach {
            contentView.addSubview($0)
        }
    }
    
    func setLayout() {
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview().inset(15)
            $0.bottom.equalToSuperview().inset(20)
        }
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(imageView).inset(80)
            $0.centerX.equalToSuperview()
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
