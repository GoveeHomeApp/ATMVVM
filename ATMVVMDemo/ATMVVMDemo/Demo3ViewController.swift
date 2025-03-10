//
//  Demo3ViewController.swift
//  ATMVVMDemo
//
//  Created by abiaoyo on 2025/3/4.
//

import UIKit
import ATMVVM
import SnapKit

class Demo3HeaderView: ATMVVM_Collection_ReusableView {
    
    lazy var textLabel = UILabel()
    lazy var expandButton:UIButton = {
        let v = UIButton()
        v.setTitle("收起", for: .normal)
        v.setTitle("展开", for: .selected)
        v.backgroundColor = .random
        v.addTarget(self, action: #selector(clickExpand), for: .touchUpInside)
        return v
    }()
    override func setupSubviews() {
        super.setupSubviews()
        backgroundColor = .green
        textLabel.numberOfLines = 0
//        textLabel.backgroundColor = .random
        addSubview(textLabel)
        addSubview(expandButton)
    }
    override func setupLayout() {
        super.setupLayout()
        textLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(0)
            make.top.bottom.equalToSuperview().inset(0)
        }
        expandButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.size.equalTo(CGSize(width: 49, height: 60))
            make.top.bottom.equalToSuperview().inset(5).priority(.high)
        }
    }
    
    override func refreshSubviews(_ isFromVM: Bool) {
        super.refreshSubviews(isFromVM)
        guard let vm = self.sectionVM as? Demo3SectionVM else { return }
        textLabel.text = vm.text
        expandButton.isSelected = !vm.expand
    }
    @objc func clickExpand() {
        guard let vm = self.sectionVM as? Demo3SectionVM else { return }
        vm.expand = !vm.expand
        vm.createLayout()
        
        let offset = vm.collectionView?.contentOffset
        vm.reloadSectionBlock()
        if let offset {
            vm.collectionView?.contentOffset = offset
        }
    }
}


class Demo3Cell: ATMVVM_Collection_Cell {
    lazy var textLabel = UILabel()
    override func setupSubviews() {
        super.setupSubviews()
//        contentView.backgroundColor = .random
        
//        textLabel.backgroundColor = .random
        contentView.backgroundColor = .white
        textLabel.numberOfLines = 0
        contentView.addSubview(textLabel)
    }
    override func setupLayout() {
        super.setupLayout()
        textLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.bottom.equalToSuperview().inset(10)
        }
    }
    override func refreshSubviews(_ isFromVM: Bool) {
        super.refreshSubviews(isFromVM)
        guard let vm = itemVM as? Demo3ItemVM else { return }
        textLabel.text = vm.text
//        textLabel.numberOfLines = vm.expand ? 0 : 2
    }
}

class Demo3SectionVM: ATMVVM_Collection_SectionVM {
    var text:String = ""
    var expand:Bool = true
    
    var oriItemVMs:[Demo3ItemVM] = []
    
    init(text: String) {
        self.text = text
    }
    override func setupData() {
        super.setupData()
        headerId = "Demo3HeaderView"
//        footerId = "Demo3FooterView"
        minimumLineSpacing = 1
//        headerSize = CGSize(width: UIScreen.main.bounds.width, height: 44)
//        footerSize = CGSize(width: UIScreen.main.bounds.width, height: 50)
    }
    override func createLayout() {
        super.createLayout()
        if expand {
            itemVMs.removeAllObjects()
            itemVMs.addObjects(from: oriItemVMs)
        }else{
            itemVMs.removeAllObjects()
        }
        for vm in itemVMs {
            (vm as? ATMVVM_Collection_ItemVM)?.createLayout()
            (vm as? ATMVVM_Collection_ItemVM)?.didSelectItemBlock = { [weak self] collectionView,indexPath,itemVM in
                guard let self = self else { return }
                (itemVM as? Demo3ItemVM)?.expand = !((itemVM as? Demo3ItemVM)?.expand ?? true)
                itemVM.createLayout()
                self.reloadViewBlock()
            }
        }
    }
}

class Demo3ItemVM: ATMVVM_Collection_ItemVM {
    
    var text:String = ""
    var expand:Bool = true
    lazy var textLabel = UILabel()
    
    init(text: String) {
        self.text = text
    }
    
    override func setupData() {
        super.setupData()
        cellId = "Demo3Cell"
        itemSize = CGSize(width: UIScreen.main.bounds.width, height: 100)
    }
    
    override func createLayout() {
        super.createLayout()
        
//        let size = (text as NSString).boundingRect(with: CGSize(width: UIScreen.main.bounds.width-20, height: 1000), context: nil)
//        
//        itemSize = CGSize(width: UIScreen.main.bounds.width, height: ceil(size.height))
    }
}

class Demo3ListVM: ATMVVM_Collection_ListVM {
    
    override func register(_ collectionView: UICollectionView) {
        super.register(collectionView)
        collectionView.register(Demo3Cell.self, forCellWithReuseIdentifier: "Demo3Cell")
        collectionView.register(Demo3HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Demo3HeaderView")
//        collectionView.register(Demo3FooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "Demo3FooterView")
        
    }
    
    override func setupData() {
        super.setupData()
    }
    override func createData() {
        super.createData()
        
        let itemVM1 = Demo3ItemVM(text: "11 有时候也要配合上面自动布局需要实现的方法共同")
        
        let sectionVM1 = Demo3SectionVM(text: "1")
        sectionVM1.oriItemVMs.append(itemVM1)
        
        let itemVM12 = Demo3ItemVM(text: "12 正如 @Caio 在评论中指出的那样，此解决方案会导致 iOS 10 及更早版本崩溃。在我的项目中，我通过包装上面的代码if #available(iOS 11.0, *) { ... }并在 else 子句中提供固定大小来“解决”了这个问题。这不是理想的，但对我来说是可以接受的。")
        sectionVM1.oriItemVMs.append(itemVM12)

        sectionVM1.createLayout()
        viewProxy.sectionVMs.add(sectionVM1)
        
        
        //----------
        
        let itemVM2 = Demo3ItemVM(text: "21 比如，CollectionViewCell中有一个支持多行的label, 在sectionController的sizeForItem 中首先要手动计算这些字所占高度，再加上label上下间隙高度。")
        let sectionVM2 = Demo3SectionVM(text: "2")
        sectionVM2.oriItemVMs.append(itemVM2)
        sectionVM2.createLayout()
        viewProxy.sectionVMs.add(sectionVM2)
        
        //----------
        
        let itemVM3 = Demo3ItemVM(text: "31 计算字所占高度通常可通知创建一个模拟label的实际计算，注意这个模拟label的字体以及样式")
        let sectionVM3 = Demo3SectionVM(text: "3")
        sectionVM3.oriItemVMs.append(itemVM3)
        sectionVM3.createLayout()
        viewProxy.sectionVMs.add(sectionVM3)
        
        //----------
        
        let itemVM4 = Demo3ItemVM(text: "41 UITableViewCell的自动高度很方便，开发中很多时候首选tableView的原因也是因为这个，可以减少很多高度或者动态高度的计算过程。CollectionViewCell 其实也是可以自动高度的, 需要重写实现一个方法func preferredLayoutAttributesFitting(_ layoutAttributesUICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes")
        let sectionVM4 = Demo3SectionVM(text: "4")
        sectionVM4.oriItemVMs.append(itemVM4)
        sectionVM4.createLayout()
        viewProxy.sectionVMs.add(sectionVM4)
        
        //----------
        
        let itemVM5 = Demo3ItemVM(text: "51 计算字所占高度通常可通知创建一个模拟label的实际计算，注意这个模拟label的字体以及样式 比如，CollectionViewCell中有一个支持多行的label, 在sectionController的sizeForItem 中首先要手动计算这些字所占高度，再加上label上下间隙高度。有时候需要实现在tableViewCell中嵌入collectionView, 虽然tableViewCell可以实现自动高度，但因为collectionView是可以滚动的，虽然可以像textView一样禁掉滚动属性，但毕竟是collectionView, 有时候加载的东西比较多，实现不了像textView一样实时更新高度。如果collectionViewCell的item大小不确定，有什么办法实现tableViewCell的自动高度呢？")
        itemVM5.didSelectItemBlock = { collectionView, indexPath, itemVM in
            let vm = itemVM as? Demo3ItemVM
            vm?.text = "1111111"
            vm?.reloadViewBlock()
        }
        let sectionVM5 = Demo3SectionVM(text: "5")
        sectionVM5.oriItemVMs.append(itemVM5)
        sectionVM5.createLayout()
        viewProxy.sectionVMs.add(sectionVM5)
        
        //----------
        
        let itemVM6 = Demo3ItemVM(text: "61 计算字所占高度通常可通知")
        let sectionVM6 = Demo3SectionVM(text: "6")
        sectionVM6.oriItemVMs.append(itemVM6)
        sectionVM6.createLayout()
        viewProxy.sectionVMs.add(sectionVM6)
        
        let sectionVM7 = Demo3SectionVM(text: "7")
        let itemVM7 = Demo3ItemVM(text: "71 计算字所占高度通常可通知创建一个模拟label的实际计算，注意这个模拟label的字体以及样式 比如，CollectionViewCell中有一个支持多行的label, 在sectionController的sizeForItem 中首先要手动计算这些字所占高度，再加上label上下间隙高度。有时候需要实现在tableViewCel")
        itemVM7.didSelectItemBlock = { [weak sectionVM7] collectionView, indexPath, itemVM in
            sectionVM7?.itemVMs.removeAllObjects()
            collectionView.reloadData()
        }
        sectionVM7.oriItemVMs.append(itemVM7)
        sectionVM7.createLayout()
        viewProxy.sectionVMs.add(sectionVM7)
        
        //----------
        
        let sectionVM8 = Demo3SectionVM(text: "8")
        let itemVM8 = Demo3ItemVM(text: "81 计算字所占高度通常可通知创建一个模拟label的实际计算，注意这个模拟label的字体以及样式 比如，CollectionViewCell中有一个支持多行的label, 在sectionController的sizeForItem 中首先要手动计算这些字所占高度，再加上label上下间隙高度。有时候需要实现在tableViewCell中嵌入collectionView")
        itemVM8.didSelectItemBlock = { [weak sectionVM8] collectionView, indexPath, itemVM in
            sectionVM8?.itemVMs.removeAllObjects()
            collectionView.reloadData()
        }
        sectionVM8.oriItemVMs.append(itemVM8)
        sectionVM8.createLayout()
        viewProxy.sectionVMs.add(sectionVM8)
        
    }
}

class Demo3ViewControlelr: UIViewController {
    
    lazy var listVM = Demo3ListVM()
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            //1 构造Item的NSCollectionLayoutSize
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
            // 2 构造NSCollectionLayoutItem
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            // 3 构造Group的NSCollectionLayoutSize
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),heightDimension: .estimated(100))
            // 4 构造NSCollectionLayoutGroup
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//            group.interItemSpacing = .fixed(floor(10.5.rate))
//            group.contentInsets = .init(top: 0, leading: 15.rate, bottom: 0, trailing: 15.rate)
            
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
        return layout
    }
    
    lazy var collectionView:UICollectionView = {
        let v = UICollectionView.init(frame: .zero, collectionViewLayout: createLayout())
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

        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        listVM.viewProxy.isAutoLayoutCell = true
        listVM.viewProxy.isAutoLayoutHeader = true
        
        listVM.createData()
        
        listVM.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

