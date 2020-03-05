import UIKit

class RowView: UIView {
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    addBottomBorder()
  }
  
  private func addBottomBorder(with color: UIColor = UIColor.lightGray, thickness: CGFloat = 1.0) {
    let bottom = UIView(frame: CGRect.zero)
    bottom.backgroundColor = UIColor.lightGray
    bottom.translatesAutoresizingMaskIntoConstraints = false
    addSubview(bottom)
    
    bottom.heightAnchor.constraint(equalToConstant: thickness).isActive = true
    bottom.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    bottom.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    bottom.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
  }
  
}
