//
//  Demo2ViewController.swift
//  ATMVVMDemo
//
//  Created by abiaoyo on 2025/1/17.
//

import UIKit
import ATMVVM
import SnapKit

// MARK: - Properties
public extension UIColor {
    
    convenience init?(red: Int, green: Int, blue: Int, transparency: CGFloat = 1) {
        guard red >= 0 && red <= 255 else { return nil }
        guard green >= 0 && green <= 255 else { return nil }
        guard blue >= 0 && blue <= 255 else { return nil }

        var trans = transparency
        if trans < 0 { trans = 0 }
        if trans > 1 { trans = 1 }

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: trans)
    }
    
    /// SwifterSwift: Random color.
    static var random: UIColor {
        let red = Int.random(in: 0...255)
        let green = Int.random(in: 0...255)
        let blue = Int.random(in: 0...255)
        return UIColor(red: red, green: green, blue: blue)!
    }
}

class Demo2HeaderView: ATMVVM_Table_HeaderFooterView {
    
    lazy var titleLabel = UILabel()
    override func setupSubviews() {
        super.setupSubviews()
        contentView.backgroundColor = .green
        titleLabel.numberOfLines = 0
        titleLabel.backgroundColor = .clear
        addSubview(titleLabel)
    }
    override func setupLayout() {
        super.setupLayout()
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(0)
            make.top.bottom.equalToSuperview().inset(0)
        }
        
    }
    
    override func refreshSubviews(_ isFromVM: Bool) {
        super.refreshSubviews(isFromVM)
        let vm = self.sectionVM as? Demo2SectionVM
        titleLabel.text = vm?.text
    }
}

class Demo2FooterView: ATMVVM_Table_HeaderFooterView {
    
    lazy var titleLabel = UILabel()
    override func setupSubviews() {
        super.setupSubviews()
        contentView.backgroundColor = .orange
        titleLabel.numberOfLines = 0
        titleLabel.backgroundColor = .clear
        addSubview(titleLabel)
    }
    override func setupLayout() {
        super.setupLayout()
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(0)
            make.top.bottom.equalToSuperview().inset(0)
        }
    }
    
    override func refreshSubviews(_ isFromVM: Bool) {
        super.refreshSubviews(isFromVM)
        let vm = self.sectionVM as? Demo2SectionVM
        titleLabel.text = vm?.text
    }
}

class Demo2Cell: ATMVVM_Table_Cell {
    lazy var titleLabel = UILabel()
    override func setupSubviews() {
        super.setupSubviews()
        contentView.backgroundColor = .random
        
        titleLabel.backgroundColor = .random
        titleLabel.numberOfLines = 0
        contentView.addSubview(titleLabel)
    }
    override func setupLayout() {
        super.setupLayout()
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(0)
            make.top.bottom.equalToSuperview().inset(0)
        }
    }
    override func refreshSubviews(_ isFromVM: Bool) {
        super.refreshSubviews(isFromVM)
        let vm = rowVM as? Demo2ItemVM
        titleLabel.text = vm?.text
    }
}

class Demo2SectionVM: ATMVVM_Table_SectionVM {
    var text:String = ""
    
    init(text: String) {
        self.text = text
    }
    override func setupData() {
        super.setupData()
        headerId = "Demo2HeaderView"
//        footerId = "Demo2FooterView"
    }
}

class Demo2ItemVM: ATMVVM_Table_RowVM {
    
    var text:String = ""
    
    init(text: String) {
        self.text = text
    }
    
    override func setupData() {
        super.setupData()
        cellId = "Demo2Cell"
    }
    
    override func createLayout() {
        super.createLayout()
    }
}

class Demo2ListVM: ATMVVM_Table_ListVM {
    
    override func register(_ tableView: UITableView) {
        super.register(tableView)
        
        tableView.register(Demo2Cell.self, forCellReuseIdentifier: "Demo2Cell")
        tableView.register(Demo2HeaderView.self, forHeaderFooterViewReuseIdentifier: "Demo2HeaderView")
        tableView.register(Demo2FooterView.self, forHeaderFooterViewReuseIdentifier: "Demo2FooterView")
    }
    
    override func setupData() {
        super.setupData()
    }
    override func createData() {
        super.createData()
        
        let itemVM1 = Demo2ItemVM(text: "有时候也要配合上面自动布局需要实现的方法共同")
        let sectionVM1 = Demo2SectionVM(text: itemVM1.text)
        sectionVM1.rowVMs.add(itemVM1)
        
        let itemVM12 = Demo2ItemVM(text: "正如 @Caio 在评论中指出的那样，此解决方案会导致 iOS 10 及更早版本崩溃。在我的项目中，我通过包装上面的代码if #available(iOS 11.0, *) { ... }并在 else 子句中提供固定大小来“解决”了这个问题。这不是理想的，但对我来说是可以接受的。")
        sectionVM1.rowVMs.add(itemVM12)
        
        viewProxy.sectionVMs.add(sectionVM1)
        
        let itemVM2 = Demo2ItemVM(text: "比如，CollectionViewCell中有一个支持多行的label, 在sectionController的sizeForItem 中首先要手动计算这些字所占高度，再加上label上下间隙高度。")
        let sectionVM2 = Demo2SectionVM(text: itemVM2.text)
        sectionVM2.rowVMs.add(itemVM2)
        viewProxy.sectionVMs.add(sectionVM2)
        
        let itemVM3 = Demo2ItemVM(text: "计算字所占高度通常可通知创建一个模拟label的实际计算，注意这个模拟label的字体以及样式")
        let sectionVM3 = Demo2SectionVM(text: itemVM3.text)
        sectionVM3.rowVMs.add(itemVM3)
        viewProxy.sectionVMs.add(sectionVM3)
        
        let itemVM4 = Demo2ItemVM(text: "UITableViewCell的自动高度很方便，开发中很多时候首选tableView的原因也是因为这个，可以减少很多高度或者动态高度的计算过程。CollectionViewCell 其实也是可以自动高度的, 需要重写实现一个方法func preferredLayoutAttributesFitting(_ layoutAttributesUICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes")
        let sectionVM4 = Demo2SectionVM(text: itemVM4.text)
        sectionVM4.rowVMs.add(itemVM4)
        viewProxy.sectionVMs.add(sectionVM4)
        
        let itemVM5 = Demo2ItemVM(text: "计算字所占高度通常可通知创建一个模拟label的实际计算，注意这个模拟label的字体以及样式 比如，CollectionViewCell中有一个支持多行的label, 在sectionController的sizeForItem 中首先要手动计算这些字所占高度，再加上label上下间隙高度。有时候需要实现在tableViewCell中嵌入collectionView, 虽然tableViewCell可以实现自动高度，但因为collectionView是可以滚动的，虽然可以像textView一样禁掉滚动属性，但毕竟是collectionView, 有时候加载的东西比较多，实现不了像textView一样实时更新高度。如果collectionViewCell的item大小不确定，有什么办法实现tableViewCell的自动高度呢？")
        itemVM5.didSelectItemBlock = { collectionView, indexPath, itemVM in
            let vm = itemVM as? Demo2ItemVM
            vm?.text = "1111111"
            vm?.reloadViewBlock()
        }
        let sectionVM5 = Demo2SectionVM(text: itemVM5.text)
        sectionVM5.rowVMs.add(itemVM5)
        viewProxy.sectionVMs.add(sectionVM5)
        
        let itemVM6 = Demo2ItemVM(text: "计算字所占高度通常可通知")
        let sectionVM6 = Demo2SectionVM(text: itemVM6.text)
        sectionVM6.rowVMs.add(itemVM6)
        viewProxy.sectionVMs.add(sectionVM6)
        
        let itemVM7 = Demo2ItemVM(text: "计算字所占高度通常可通知创建一个模拟label的实际计算，注意这个模拟label的字体以及样式 比如，CollectionViewCell中有一个支持多行的label, 在sectionController的sizeForItem 中首先要手动计算这些字所占高度，再加上label上下间隙高度。有时候需要实现在tableViewCel")
        let sectionVM7 = Demo2SectionVM(text: itemVM7.text)
        sectionVM7.rowVMs.add(itemVM7)
        viewProxy.sectionVMs.add(sectionVM7)
        
        let itemVM8 = Demo2ItemVM(text: "计算字所占高度通常可通知创建一个模拟label的实际计算，注意这个模拟label的字体以及样式 比如，CollectionViewCell中有一个支持多行的label, 在sectionController的sizeForItem 中首先要手动计算这些字所占高度，再加上label上下间隙高度。有时候需要实现在tableViewCell中嵌入collectionView")
        let sectionVM8 = Demo2SectionVM(text: itemVM8.text)
        sectionVM8.rowVMs.add(itemVM8)
        viewProxy.sectionVMs.add(sectionVM8)
        
    }
}

class Demo2ViewController: UIViewController {
    
    lazy var listVM = Demo2ListVM()
    
    lazy var tableView:UITableView = {
        
        let v = UITableView(frame: .zero, style: .grouped)
        v.backgroundColor = UIColor.clear
        v.backgroundColor = .random
        v.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        v.contentInsetAdjustmentBehavior = .never
        v.setupListVM(listVM)
        v.setup(withViewProxy: listVM.viewProxy)

        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        listVM.viewProxy.isAutoLayoutCell = true
        listVM.viewProxy.isAutoLayoutHeader = true
        listVM.viewProxy.isAutoLayoutFooter = true
        listVM.createData()
        
        listVM.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}
