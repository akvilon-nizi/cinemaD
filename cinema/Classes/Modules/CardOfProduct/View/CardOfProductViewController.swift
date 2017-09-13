//
// Created by DanilaLyahomskiy on 01/09/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

class CardOfProductViewController: ParentViewController {

    var output: CardOfProductViewOutput!

    let scrollView: UIScrollView = UIScrollView()
    let window = UIWindow(frame: UIScreen.main.bounds)
    let contentView = UIView()
    let imageView = ImageView()
    let backNavView: UIView = UIView()

    fileprivate let indication: Indication = {
        let indication = Indication()
        indication.register(view: IndicationLoadView(), for: .load)
        indication.register(view: IndicationErrorView(), for: .error)
        return indication
    }()

    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.tintColor = UIColor.fdlGreyishBrown
        titleLabel.font = UIFont.fdlGothamProMedium(size: 20)
        titleLabel.numberOfLines = 0
        return titleLabel
    } ()

    let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.tintColor = UIColor.fdlWarmGrey
        descriptionLabel.font = UIFont.systemFont(ofSize: 15)
        descriptionLabel.numberOfLines = 0
        return descriptionLabel
    } ()

    let infoLabel: UILabel = {
        let infoLabel = UILabel()
        infoLabel.tintColor = UIColor.fdlWarmGrey
        infoLabel.font = UIFont.fdlSystemRegular(size: 13)
        infoLabel.numberOfLines = 2
        infoLabel.textAlignment = .left
        return infoLabel
    } ()

    let priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.tintColor = UIColor.fdlGreyishBrown
        priceLabel.font = UIFont.fdlGothamProMedium(size: 24)
        priceLabel.numberOfLines = 0
        priceLabel.textAlignment = .right
        return priceLabel
    } ()

    private let addButton: UIButton = {
        let addButton = UIButton()
        addButton.setTitleColor(UIColor.fdlWarmGrey, for: .normal)
        addButton.titleLabel?.font = UIFont.fdlSystemMedium(size: 15)
        addButton.layer.cornerRadius = 6
        addButton.backgroundColor = UIColor.fdlPaleGrey
        addButton.titleLabel?.contentMode = .center
        addButton.setTitle(L10n.cardProductButtonAdd, for: .normal)
        return addButton
    } ()

    private let minusButton: UIButton = {
        let minusButton = UIButton()
        minusButton.setImage(Asset.CardProduct.cardMinus.image, for: .normal)
        minusButton.heightAnchor ~= 46
        minusButton.widthAnchor ~= 52
        return minusButton
    } ()

    private let plusButton: UIButton = {
        let plusButton = UIButton()
        plusButton.setImage(Asset.CardProduct.cardPlus.image, for: .normal)
        plusButton.heightAnchor ~= 46
        plusButton.widthAnchor ~= 52
        return plusButton
    } ()

    private let countLabel: UILabel = {
        let countLabel = UILabel()
        countLabel.tintColor = UIColor.fdlGreyishBrown
        countLabel.font = UIFont.fdlGothamProMedium(size: 17)
        countLabel.textAlignment = .center
        countLabel.text = "0"
        return countLabel
    } ()

    private var countProduct: Int = 0 {
        didSet {
            countLabel.text = String(countProduct)
        }
    }

    let menuButton = UIButton(type: .system)

    // MARK: - Life cycle

    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.navigationController?.navigationBar.barStyle = .black
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        indication.output = self
        indication.insets = UIEdgeInsets(top: 44, left: 0, bottom: 0, right: 0)
        view.register(indication: indication)

        output.viewIsReady()

        menuButton.setImage(Asset.CardProduct.cardProductClose.image.withRenderingMode(.alwaysTemplate), for: .normal)
        menuButton.addTarget(self, action: #selector(handleTapCloseButton), for: .touchUpInside)
        menuButton.sizeToFit()
        menuButton.addTarget(self, action: #selector(handleTapCloseButton), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuButton)

        view.addSubview(scrollView.prepareForAutoLayout())
        scrollView.pin(to: view, edgesInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        scrollView.backgroundColor = .white
        scrollView.delegate = self

        backNavView.backgroundColor = .white
        backNavView.alpha = 0
        view.addSubview(backNavView.prepareForAutoLayout())

        backNavView.topAnchor ~= view.topAnchor
        backNavView.leadingAnchor ~= view.leadingAnchor
        backNavView.trailingAnchor ~= view.trailingAnchor
        backNavView.heightAnchor ~= 64

        addContentView()

    }

    private func addContentView() {
        scrollView.addSubview(contentView.prepareForAutoLayout())

        contentView.topAnchor ~= scrollView.topAnchor
        contentView.leadingAnchor ~= view.leadingAnchor
        contentView.trailingAnchor ~= view.trailingAnchor

        addTopElements()
        addBottomElements()

        scrollView.isHidden = true
    }

    private func addTopElements() {
        imageView.heightAnchor ~= window.bounds.width / 8 * 5
        imageView.widthAnchor ~= window.bounds.width

        contentView.addSubview(imageView.prepareForAutoLayout())
        imageView.topAnchor ~= contentView.topAnchor
        imageView.leadingAnchor ~= contentView.leadingAnchor

        contentView.addSubview(titleLabel.prepareForAutoLayout())
        titleLabel.topAnchor ~= imageView.bottomAnchor + 32
        titleLabel.leadingAnchor ~= contentView.leadingAnchor + 24
        titleLabel.widthAnchor ~= window.frame.width - 52

        contentView.addSubview(descriptionLabel.prepareForAutoLayout())
        descriptionLabel.topAnchor ~= titleLabel.bottomAnchor + 16
        descriptionLabel.leadingAnchor ~= contentView.leadingAnchor + 24
        descriptionLabel.widthAnchor ~= window.frame.width - 52
    }

    private func addBottomElements() {

        let priceView = UIView()
        contentView.addSubview(priceView.prepareForAutoLayout())
        priceView.topAnchor >= descriptionLabel.bottomAnchor + 28
        priceView.leadingAnchor ~= contentView.leadingAnchor + 24
        priceView.widthAnchor ~= window.frame.width - 52
        priceView.heightAnchor ~= 36

        priceView.addSubview(infoLabel.prepareForAutoLayout())
        infoLabel.topAnchor ~= priceView.topAnchor
        infoLabel.leadingAnchor ~= priceView.leadingAnchor
        infoLabel.widthAnchor ~= 120

        priceView.addSubview(priceLabel.prepareForAutoLayout())
        priceLabel.bottomAnchor ~= priceView.bottomAnchor
        priceLabel.trailingAnchor ~= priceView.trailingAnchor
        priceLabel.leadingAnchor ~= infoLabel.leadingAnchor

        let buttonsView = UIView()
        contentView.addSubview(buttonsView.prepareForAutoLayout())
        buttonsView.topAnchor ~= priceView.bottomAnchor + 28
        buttonsView.bottomAnchor ~= contentView.bottomAnchor - 17
        buttonsView.leadingAnchor ~= contentView.leadingAnchor + 24
        buttonsView.widthAnchor ~= window.frame.width - 52
        buttonsView.heightAnchor ~= 46

        buttonsView.addSubview(countLabel.prepareForAutoLayout())
        countLabel.centerXAnchor ~= buttonsView.centerXAnchor
        countLabel.centerYAnchor ~= buttonsView.centerYAnchor

        buttonsView.addSubview(minusButton.prepareForAutoLayout())
        minusButton.centerYAnchor ~= buttonsView.centerYAnchor
        minusButton.trailingAnchor ~= countLabel.leadingAnchor - 30
        minusButton.addTarget(self, action: #selector(handleTapMinusButton), for: .touchUpInside)

        buttonsView.addSubview(plusButton.prepareForAutoLayout())
        plusButton.centerYAnchor ~= buttonsView.centerYAnchor
        plusButton.leadingAnchor ~= countLabel.trailingAnchor + 30
        plusButton.addTarget(self, action: #selector(handleTapPlusButton), for: .touchUpInside)

        buttonsView.addSubview(addButton.prepareForAutoLayout())
        addButton.pinEdgesToSuperviewEdges()
        addButton.addTarget(self, action: #selector(handleTapAddButton), for: .touchUpInside)
    }

    // MARK: - Actions

    func handleTapAddButton() {
        addButton.isHidden = true
    }

    func handleTapMinusButton() {
        if countProduct > 0 {
            countProduct -= 1
        }
    }

    func handleTapPlusButton() {
            countProduct += 1
    }

    func handleTapCloseButton() {
        output.close()
    }

}

// MARK: - CardOfProductViewInput

extension CardOfProductViewController: CardOfProductViewInput {

    func setupInitialState(withProduct product: Product) {
        imageView.setImage(with: URL(string: product.image))
        titleLabel.text = product.name
        infoLabel.text = L10n.cardProductInfo(String(product.weight), "248")
        priceLabel.text = L10n.cardProductPrice(String(product.price))
//        if let ingredients = product.ingredients, !ingredients.isEmpty {
//            descriptionLabel.text = ingredients.flatMap({$0.name}).joined(separator:",").capitalized
//        }
        descriptionLabel.text = L10n.cardProductFakeDescription

        scrollView.layoutSubviews()
        scrollView.layoutIfNeeded()

        if contentView.frame.height < window.bounds.height {
            contentView.heightAnchor ~= window.bounds.height
            scrollView.contentSize = CGSize(width: window.frame.width, height: contentView.frame.height)
        } else {
            scrollView.contentSize = CGSize(width: window.frame.width, height: contentView.frame.height)
        }

        scrollView.isHidden = false

        indication.hide(animated: true)
    }

    func showEmptyLoading() {
        indication.show(type: .load, animated: true)
    }

    func show(error: String) {
        indication.updateError(message: error)
        indication.show(type: .error, animated: true)
    }
}

// MARK: - CardOfProductViewInput

extension CardOfProductViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            scrollView.contentOffset.y = 0
        } else if scrollView.contentOffset.y + 64 * 2 < window.bounds.width / 8 * 5 {
            backNavView.alpha = 0
            menuButton.tintColor = .white
            self.navigationController?.navigationBar.barStyle = .black
        } else if scrollView.contentOffset.y + 64 * 2 > window.bounds.width / 8 * 5 {
            self.navigationController?.navigationBar.barStyle = .default
            var alpha = (scrollView.contentOffset.y + 64 * 2 - window.bounds.width / 8 * 5) / 64
            if alpha < 0 {
                alpha = 0
            } else if alpha > 1 {
                UIApplication.shared.statusBarStyle = .lightContent
                alpha = 1
            }
            backNavView.alpha = alpha
            menuButton.tintColor = UIColor(white: 255.0 * (1 - alpha) / 255.0, alpha: 1.0)
        }
    }
}

// MARK: - IndicationOutput

extension CardOfProductViewController: IndicationOutput {

    func reloadPressed(in indication: Indication) {
        output.reloadData()
    }
}
