//
//  Demo1ViewControlelr.swift
//  ATMVVMDemo
//
//  Created by abiaoyo on 2025/1/16.
//

import UIKit
import SnapKit

class Demo1HeaderView: AutoListReuseableView {
    
    lazy var textLabel = UILabel()
    override func setupSubviews() {
        super.setupSubviews()
        backgroundColor = .gray
        textLabel.numberOfLines = 0
        textLabel.backgroundColor = .random
        addSubview(textLabel)
    }
    override func setupLayout() {
        super.setupLayout()
        textLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(0)
            make.top.bottom.equalToSuperview().inset(0)
        }
        
    }
    override func refreshSubviews(isFromVM: Bool) {
        super.refreshSubviews(isFromVM: isFromVM)
        guard let sectionVM = self.sectionVM as? Demo1SectionVM else { return }
        textLabel.text = sectionVM.headerText
    }
}

class Demo1FooterView: AutoListReuseableView {
    
    lazy var textLabel = UILabel()
    override func setupSubviews() {
        super.setupSubviews()
        backgroundColor = .lightGray
        textLabel.numberOfLines = 0
        textLabel.backgroundColor = .random
        addSubview(textLabel)
    }
    override func setupLayout() {
        super.setupLayout()
        textLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(0)
            make.top.bottom.equalToSuperview().inset(0)
        }
    }
    
    override func refreshSubviews(isFromVM: Bool) {
        super.refreshSubviews(isFromVM: isFromVM)
        guard let sectionVM = self.sectionVM as? Demo1SectionVM else { return }
        textLabel.text = sectionVM.footerText
    }
}

class Demo1Cell: AutoListCell {
    lazy var textLabel = UILabel()
    override func setupSubviews() {
        super.setupSubviews()
        contentView.backgroundColor = .white
        textLabel.numberOfLines = 0
        contentView.addSubview(textLabel)
    }
    override func setupLayout() {
        super.setupLayout()
        textLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(0)
            make.top.bottom.equalToSuperview().inset(0)
        }
    }
    override func refreshSubviews(isFromVM: Bool) {
        super.refreshSubviews(isFromVM: isFromVM)
        let vm = itemVM as? Demo1ItemVM
        textLabel.text = vm?.text
        textLabel.numberOfLines = vm?.expand ?? true ? 0 : 2
    }
}

class Demo1SectionVM: AutoListSectionVM {
    var headerText:String = ""
    var footerText:String = ""
    
    init(text: String) {
        self.headerText = text
    }
    override func setupData() {
        super.setupData()
        headerId = "Demo1HeaderView"
        footerId = "Demo1FooterView"
    }
    
    func createLayoutSection1() -> NSCollectionLayoutSection {
        //1 构造Item的NSCollectionLayoutSize
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
        // 2 构造NSCollectionLayoutItem
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // 3 构造Group的NSCollectionLayoutSize
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),heightDimension: .estimated(100))
        // 4 构造NSCollectionLayoutGroup
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//            group.interItemSpacing = .fixed(floor(10.5.rate))
        group.contentInsets = .init(top: 0, leading: 30.rate, bottom: 0, trailing: 30.rate)
        
        // 5 构造 header / footer
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(48.rate))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
//            header.pinToVisibleBounds = true
        
        // 6 构造NSCollectionLayoutSection
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 5.rate
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    func createLayoutSection2() -> NSCollectionLayoutSection {
        //1 构造Item的NSCollectionLayoutSize
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
        // 2 构造NSCollectionLayoutItem
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // 3 构造Group的NSCollectionLayoutSize
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),heightDimension: .estimated(100))
        // 4 构造NSCollectionLayoutGroup
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//            group.interItemSpacing = .fixed(floor(10.5.rate))
        group.contentInsets = .init(top: 10, leading: 50.rate, bottom: 10, trailing: 50.rate)
        
        // 5 构造 header / footer
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(48.rate))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
//            header.pinToVisibleBounds = true
        
        // 6 构造NSCollectionLayoutSection
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 5.rate
        section.boundarySupplementaryItems = [header]
        
        return section
    }
}

class Demo1ItemVM: AutoListItemVM {
    
    var text:String = ""
    var expand:Bool = true
    init(text: String) {
        self.text = text
    }
    
    override func setupData() {
        super.setupData()
        cellId = "Demo1Cell"
    }
    
    override func createLayout() {
        super.createLayout()
    }
}

class Demo1ListVM: AutoListVM {
    
    override func register(collectionView: UICollectionView) {
        super.register(collectionView: collectionView)
        collectionView.register(Demo1Cell.self, forCellWithReuseIdentifier: "Demo1Cell")
        collectionView.register(Demo1HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Demo1HeaderView")
        collectionView.register(Demo1FooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "Demo1FooterView")
    }
    
    
    override func createData() {
        super.createData()
        
        let itemVM1 = Demo1ItemVM(text: "11 有时候也要配合上面自动布局需要实现的方法共同")
        let sectionVM1 = Demo1SectionVM(text: "1")
        sectionVM1.layoutSection = sectionVM1.createLayoutSection1()
        sectionVM1.itemVMs.append(itemVM1)
        
        let itemVM12 = Demo1ItemVM(text: "12 正如 @Caio 在评论中指出的那样，此解决方案会导致 iOS 10 及更早版本崩溃。在我的项目中，我通过包装上面的代码if #available(iOS 11.0, *) { ... }并在 else 子句中提供固定大小来“解决”了这个问题。这不是理想的，但对我来说是可以接受的。")
        sectionVM1.itemVMs.append(itemVM12)
        viewProxy.sectionVMs.append(sectionVM1)
        
        let itemVM2 = Demo1ItemVM(text: "21 比如，CollectionViewCell中有一个支持多行的label, 在sectionController的sizeForItem 中首先要手动计算这些字所占高度，再加上label上下间隙高度。")
        let sectionVM2 = Demo1SectionVM(text: "2")
        sectionVM2.layoutSection = sectionVM1.createLayoutSection2()
        sectionVM2.itemVMs.append(itemVM2)
        viewProxy.sectionVMs.append(sectionVM2)
        
        let itemVM3 = Demo1ItemVM(text: "31 计算字所占高度通常可通知创建一个模拟label的实际计算，注意这个模拟label的字体以及样式")
        let sectionVM3 = Demo1SectionVM(text: "3")
        sectionVM3.itemVMs.append(itemVM3)
        viewProxy.sectionVMs.append(sectionVM3)
        
        let itemVM4 = Demo1ItemVM(text: "41 UITableViewCell的自动高度很方便，开发中很多时候首选tableView的原因也是因为这个，可以减少很多高度或者动态高度的计算过程。CollectionViewCell 其实也是可以自动高度的, 需要重写实现一个方法func preferredLayoutAttributesFitting(_ layoutAttributesUICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes")
        let sectionVM4 = Demo1SectionVM(text: "4")
        sectionVM4.itemVMs.append(itemVM4)
        viewProxy.sectionVMs.append(sectionVM4)
        
        let itemVM5 = Demo1ItemVM(text: "51 计算字所占高度通常可通知创建一个模拟label的实际计算，注意这个模拟label的字体以及样式 比如，CollectionViewCell中有一个支持多行的label, 在sectionController的sizeForItem 中首先要手动计算这些字所占高度，再加上label上下间隙高度。有时候需要实现在tableViewCell中嵌入collectionView, 虽然tableViewCell可以实现自动高度，但因为collectionView是可以滚动的，虽然可以像textView一样禁掉滚动属性，但毕竟是collectionView, 有时候加载的东西比较多，实现不了像textView一样实时更新高度。如果collectionViewCell的item大小不确定，有什么办法实现tableViewCell的自动高度呢？")
        itemVM5.onSelectItemBlock = { collectionView, indexPath, itemVM in
            let vm = itemVM as? Demo1ItemVM
            vm?.text = "1111111"
            vm?.reloadListBlock?()
        }
        let sectionVM5 = Demo1SectionVM(text: "5")
        sectionVM5.itemVMs.append(itemVM5)
        viewProxy.sectionVMs.append(sectionVM5)
        
        let itemVM6 = Demo1ItemVM(text: "61 计算字所占高度通常可通知")
        let sectionVM6 = Demo1SectionVM(text: "6")
        sectionVM6.itemVMs.append(itemVM6)
        viewProxy.sectionVMs.append(sectionVM6)
        
        let sectionVM7 = Demo1SectionVM(text: "7")
        let itemVM7 = Demo1ItemVM(text: "71 计算字所占高度通常可通知创建一个模拟label的实际计算，注意这个模拟label的字体以及样式 比如，CollectionViewCell中有一个支持多行的label, 在sectionController的sizeForItem 中首先要手动计算这些字所占高度，再加上label上下间隙高度。有时候需要实现在tableViewCel")
        itemVM7.onSelectItemBlock = { [weak sectionVM7] collectionView, indexPath, itemVM in
            sectionVM7?.itemVMs.removeAll()
            itemVM.reloadListBlock?()
        }
        sectionVM7.itemVMs.append(itemVM7)
        viewProxy.sectionVMs.append(sectionVM7)
        
        let sectionVM8 = Demo1SectionVM(text: "8")
        let itemVM8 = Demo1ItemVM(text: "81 计算字所占高度通常可通知创建一个模拟label的实际计算，注意这个模拟label的字体以及样式 比如，CollectionViewCell中有一个支持多行的label, 在sectionController的sizeForItem 中首先要手动计算这些字所占高度，再加上label上下间隙高度。有时候需要实现在tableViewCell中嵌入collectionView")
        itemVM8.onSelectItemBlock = { [weak sectionVM8] collectionView, indexPath, itemVM in
            sectionVM8?.itemVMs.removeAll()
            itemVM.reloadListBlock?()
        }
        sectionVM8.itemVMs.append(itemVM8)
        viewProxy.sectionVMs.append(sectionVM8)
        
    }
}

class Demo1ViewControlelr: UIViewController {
    
    lazy var listVM = Demo1ListVM()
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            
            if let layoutSection = self.listVM.viewProxy.sectionVMs[sectionIndex].layoutSection {
                return layoutSection
            }
            
            //1 构造Item的NSCollectionLayoutSize
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
            // 2 构造NSCollectionLayoutItem
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            // 3 构造Group的NSCollectionLayoutSize
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),heightDimension: .estimated(100))
            // 4 构造NSCollectionLayoutGroup
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(48.rate))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 5.rate
            section.boundarySupplementaryItems = [header]
            
            return section
        }
        return layout
    }
    
    lazy var collectionView:UICollectionView = {
        
        let v = UICollectionView.init(frame: .zero, collectionViewLayout: createLayout())
        v.backgroundColor = UIColor.clear
        v.backgroundColor = .random
        v.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        v.contentInsetAdjustmentBehavior = .never
        v.config(listVM: listVM)
        v.config(viewProxy: listVM.viewProxy)
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
//        listVM.viewProxy.autoLayoutCell = .height
//        listVM.viewProxy.autoLayoutHeader = .height
//        listVM.viewProxy.autoLayoutFooter = .height
        
//        listVM.viewProxy.autoLayoutCell = .width
//        listVM.viewProxy.autoLayoutCellMaxHeight = 60
//        listVM.viewProxy.autoLayoutHeader = .width
//        listVM.viewProxy.autoLayoutFooter = .width
        
        listVM.createData()
        
        listVM.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}
