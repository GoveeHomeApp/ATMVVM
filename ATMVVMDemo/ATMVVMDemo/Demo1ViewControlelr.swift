////
////  Demo1ViewControlelr.swift
////  ATMVVMDemo
////
////  Created by abiaoyo on 2025/1/16.
////
//
//import UIKit
//import ATMVVM
//import SnapKit
//
//class Demo1HeaderView: ATMVVM_Collection_ReusableView {
//    
//    lazy var textLabel = UILabel()
//    override func setupSubviews() {
//        super.setupSubviews()
//        backgroundColor = .gray
//        textLabel.numberOfLines = 0
//        textLabel.backgroundColor = .random
//        addSubview(textLabel)
//    }
//    override func setupLayout() {
//        super.setupLayout()
//        textLabel.snp.makeConstraints { make in
//            make.leading.trailing.equalToSuperview().inset(0)
//            make.top.bottom.equalToSuperview().inset(0)
//        }
//        
//    }
//    
//    override func refreshSubviews(_ isFromVM: Bool) {
//        super.refreshSubviews(isFromVM)
//        let vm = self.sectionVM as? Demo1SectionVM
//        textLabel.text = vm?.text
//    }
//}
//
//class Demo1FooterView: ATMVVM_Collection_ReusableView {
//    
//    lazy var textLabel = UILabel()
//    override func setupSubviews() {
//        super.setupSubviews()
//        backgroundColor = .lightGray
//        textLabel.numberOfLines = 0
//        textLabel.backgroundColor = .random
//        addSubview(textLabel)
//    }
//    override func setupLayout() {
//        super.setupLayout()
//        textLabel.snp.makeConstraints { make in
//            make.leading.trailing.equalToSuperview().inset(0)
//            make.top.bottom.equalToSuperview().inset(0)
//        }
//    }
//    
//    override func refreshSubviews(_ isFromVM: Bool) {
//        super.refreshSubviews(isFromVM)
//        let vm = self.sectionVM as? Demo1SectionVM
//        textLabel.text = vm?.text
//    }
//}
//
//class Demo1Cell: ATMVVM_Collection_Cell {
//    lazy var textLabel = UILabel()
//    override func setupSubviews() {
//        super.setupSubviews()
////        contentView.backgroundColor = .random
//        
////        textLabel.backgroundColor = .random
//        contentView.backgroundColor = .white
//        textLabel.numberOfLines = 0
//        contentView.addSubview(textLabel)
//    }
//    override func setupLayout() {
//        super.setupLayout()
//        textLabel.snp.makeConstraints { make in
//            make.leading.trailing.equalToSuperview().inset(0)
//            make.top.bottom.equalToSuperview().inset(0)
//        }
//    }
//    override func refreshSubviews(_ isFromVM: Bool) {
//        super.refreshSubviews(isFromVM)
//        let vm = itemVM as? Demo1ItemVM
//        textLabel.text = vm?.text
//        textLabel.numberOfLines = vm?.expand ?? true ? 0 : 2
//    }
//}
//
//class Demo1SectionVM: ATMVVM_Collection_SectionVM {
//    var text:String = ""
//    
//    init(text: String) {
//        self.text = text
//    }
//    override func setupData() {
//        super.setupData()
//        headerId = "Demo1HeaderView"
////        footerId = "Demo1FooterView"
//        minimumLineSpacing = 10
////        headerSize = CGSize(width: UIScreen.main.bounds.width, height: 50)
////        footerSize = CGSize(width: UIScreen.main.bounds.width, height: 50)
//    }
//}
//
//class Demo1ItemVM: ATMVVM_Collection_ItemVM {
//    
//    var text:String = ""
//    var expand:Bool = true
//    init(text: String) {
//        self.text = text
//    }
//    
//    override func setupData() {
//        super.setupData()
//        cellId = "Demo1Cell"
//        itemSize = CGSize(width: UIScreen.main.bounds.width, height: 80)
//    }
//    
//    override func createLayout() {
//        super.createLayout()
//    }
//}
//
//class Demo1ListVM: ATMVVM_Collection_ListVM {
//    
//    override func register(_ collectionView: UICollectionView) {
//        super.register(collectionView)
//        collectionView.register(Demo1Cell.self, forCellWithReuseIdentifier: "Demo1Cell")
//        collectionView.register(Demo1HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Demo1HeaderView")
//        collectionView.register(Demo1FooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "Demo1FooterView")
//        
//    }
//    
//    override func setupData() {
//        super.setupData()
//    }
//    override func createData() {
//        super.createData()
//        
//        let itemVM1 = Demo1ItemVM(text: "11 有时候也要配合上面自动布局需要实现的方法共同")
//        let sectionVM1 = Demo1SectionVM(text: "1")
//        sectionVM1.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0)
//        
//        sectionVM1.itemVMs.add(itemVM1)
//        
//        let itemVM12 = Demo1ItemVM(text: "12 正如 @Caio 在评论中指出的那样，此解决方案会导致 iOS 10 及更早版本崩溃。在我的项目中，我通过包装上面的代码if #available(iOS 11.0, *) { ... }并在 else 子句中提供固定大小来“解决”了这个问题。这不是理想的，但对我来说是可以接受的。")
//        sectionVM1.itemVMs.add(itemVM12)
//        
//        viewProxy.sectionVMs.add(sectionVM1)
//        
//        let itemVM2 = Demo1ItemVM(text: "21 比如，CollectionViewCell中有一个支持多行的label, 在sectionController的sizeForItem 中首先要手动计算这些字所占高度，再加上label上下间隙高度。")
//        let sectionVM2 = Demo1SectionVM(text: "2")
//        sectionVM2.itemVMs.add(itemVM2)
//        viewProxy.sectionVMs.add(sectionVM2)
//        
//        let itemVM3 = Demo1ItemVM(text: "31 计算字所占高度通常可通知创建一个模拟label的实际计算，注意这个模拟label的字体以及样式")
//        let sectionVM3 = Demo1SectionVM(text: "3")
//        sectionVM3.itemVMs.add(itemVM3)
//        viewProxy.sectionVMs.add(sectionVM3)
//        
//        let itemVM4 = Demo1ItemVM(text: "41 UITableViewCell的自动高度很方便，开发中很多时候首选tableView的原因也是因为这个，可以减少很多高度或者动态高度的计算过程。CollectionViewCell 其实也是可以自动高度的, 需要重写实现一个方法func preferredLayoutAttributesFitting(_ layoutAttributesUICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes")
//        let sectionVM4 = Demo1SectionVM(text: "4")
//        sectionVM4.itemVMs.add(itemVM4)
//        viewProxy.sectionVMs.add(sectionVM4)
//        
//        let itemVM5 = Demo1ItemVM(text: "51 计算字所占高度通常可通知创建一个模拟label的实际计算，注意这个模拟label的字体以及样式 比如，CollectionViewCell中有一个支持多行的label, 在sectionController的sizeForItem 中首先要手动计算这些字所占高度，再加上label上下间隙高度。有时候需要实现在tableViewCell中嵌入collectionView, 虽然tableViewCell可以实现自动高度，但因为collectionView是可以滚动的，虽然可以像textView一样禁掉滚动属性，但毕竟是collectionView, 有时候加载的东西比较多，实现不了像textView一样实时更新高度。如果collectionViewCell的item大小不确定，有什么办法实现tableViewCell的自动高度呢？")
//        itemVM5.didSelectItemBlock = { collectionView, indexPath, itemVM in
//            let vm = itemVM as? Demo1ItemVM
//            vm?.text = "1111111"
//            vm?.reloadViewBlock()
//        }
//        let sectionVM5 = Demo1SectionVM(text: "5")
//        sectionVM5.itemVMs.add(itemVM5)
//        viewProxy.sectionVMs.add(sectionVM5)
//        
//        let itemVM6 = Demo1ItemVM(text: "61 计算字所占高度通常可通知")
//        let sectionVM6 = Demo1SectionVM(text: "6")
//        sectionVM6.itemVMs.add(itemVM6)
//        viewProxy.sectionVMs.add(sectionVM6)
//        
//        let sectionVM7 = Demo1SectionVM(text: "7")
//        let itemVM7 = Demo1ItemVM(text: "71 计算字所占高度通常可通知创建一个模拟label的实际计算，注意这个模拟label的字体以及样式 比如，CollectionViewCell中有一个支持多行的label, 在sectionController的sizeForItem 中首先要手动计算这些字所占高度，再加上label上下间隙高度。有时候需要实现在tableViewCel")
//        itemVM7.didSelectItemBlock = { [weak sectionVM7] collectionView, indexPath, itemVM in
//            sectionVM7?.itemVMs.removeAllObjects()
//            collectionView.reloadData()
//        }
//        sectionVM7.itemVMs.add(itemVM7)
//        viewProxy.sectionVMs.add(sectionVM7)
//        
//        let sectionVM8 = Demo1SectionVM(text: "8")
//        let itemVM8 = Demo1ItemVM(text: "81 计算字所占高度通常可通知创建一个模拟label的实际计算，注意这个模拟label的字体以及样式 比如，CollectionViewCell中有一个支持多行的label, 在sectionController的sizeForItem 中首先要手动计算这些字所占高度，再加上label上下间隙高度。有时候需要实现在tableViewCell中嵌入collectionView")
//        itemVM8.didSelectItemBlock = { [weak sectionVM8] collectionView, indexPath, itemVM in
//            sectionVM8?.itemVMs.removeAllObjects()
//            collectionView.reloadData()
//        }
//        sectionVM8.itemVMs.add(itemVM8)
//        viewProxy.sectionVMs.add(sectionVM8)
//        
//    }
//}
//
//class Demo1ViewControlelr: UIViewController {
//    
//    lazy var listVM = Demo1ListVM()
//    
//    lazy var collectionView:UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.minimumLineSpacing = 10
//        layout.minimumInteritemSpacing = 10
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
////        layout.sectionHeadersPinToVisibleBounds = true
////        layout.sectionFootersPinToVisibleBounds = true
//        layout.scrollDirection = .vertical
//        layout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width, height: 50)
////        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
////        layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 50)
////        layout.footerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 50)
//        
//        let v = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
//        v.backgroundColor = UIColor.clear
//        v.backgroundColor = .random
//        v.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
//        v.contentInsetAdjustmentBehavior = .never
//        v.setupListVM(listVM)
//        v.setup(withViewProxy: listVM.viewProxy)
//
//        return v
//    }()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//
//        view.addSubview(collectionView)
//        
//        collectionView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
////        listVM.viewProxy.autoLayoutCell = .height
////        listVM.viewProxy.autoLayoutHeader = .height
////        listVM.viewProxy.autoLayoutFooter = .height
//        
////        listVM.viewProxy.autoLayoutCell = .width
////        listVM.viewProxy.autoLayoutCellMaxHeight = 60
////        listVM.viewProxy.autoLayoutHeader = .width
////        listVM.viewProxy.autoLayoutFooter = .width
//        
//        listVM.createData()
//        
//        listVM.reloadData()
//    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//    }
//}
