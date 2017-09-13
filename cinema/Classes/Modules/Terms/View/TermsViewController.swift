//
// Created by incetro on 25/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

class TermsViewController: ParentViewController {

    fileprivate let textView: UITextView = {

        let textView = UITextView()

        textView.showsVerticalScrollIndicator = false
        textView.clipsToBounds = false

        return textView
    }()

    fileprivate let confirmButton: GradientButton = {
        let confirmButton = GradientButton()
        confirmButton.setTitle(L10n.termsButtonTitle, for: .normal)
        confirmButton.isEnabled = false
        return confirmButton
    }()

    var output: TermsViewOutput!

    fileprivate let htmlFormatter: TextViewHTMLFormatter = TextViewHTMLFormatterImplementation()

    // MARK: - Life cycle

    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()

        setupBackButton()

        textView.delegate = self

        view.addSubview(textView.prepareForAutoLayout())

        textView.leadingAnchor ~= view.leadingAnchor + 13
        textView.trailingAnchor ~= view.trailingAnchor - 13
        textView.topAnchor ~= view.topAnchor

        setupTitle()

        setupGradient()

        view.addSubview(confirmButton.prepareForAutoLayout())

        confirmButton.leadingAnchor ~= view.leadingAnchor + 10
        confirmButton.trailingAnchor ~= view.trailingAnchor - 10
        confirmButton.bottomAnchor ~= view.bottomAnchor - 10
        confirmButton.heightAnchor ~= 48

        confirmButton.addTarget(self, action: #selector(didTapConfirmButton), for: .touchUpInside)

        textView.bottomAnchor ~= confirmButton.topAnchor - 30
    }

    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)
    }

    func setupBackButton() {

        guard let count = navigationController?.viewControllers.count, count > 1 else {

            return
        }

        let backButton = UIButton()
        backButton.setImage(Asset.NavBar.navBarArrowBack.image, for: .normal)
        backButton.addTarget(self, action: #selector(didTapLeftButton), for: .touchUpInside)
        backButton.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }

    func setupTitle() {

        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 240, height: 44))
        label.textColor = UIColor.fdlGreyishBrown
        label.font = UIFont.fdlGothamProMedium(size: 17)
        label.text = L10n.termsMainTitle
        label.textAlignment = .center
        navigationItem.titleView = label
    }

    func setupGradient() {

        let colour: UIColor = .white
        let colours: [CGColor] = [colour.withAlphaComponent(0.0).cgColor, colour.cgColor]
        let locations: [NSNumber] = [0, 0.4]

        let bottomGradientLayer = CAGradientLayer()
        bottomGradientLayer.colors = colours
        bottomGradientLayer.locations = locations
        bottomGradientLayer.frame = CGRect(x: 0, y: view.frame.height - 100, width: view.frame.width, height: 100)

        let topGradientLayer = CAGradientLayer()
        topGradientLayer.colors = [UIColor.white.cgColor, colour.withAlphaComponent(0.0).cgColor]
        topGradientLayer.locations = [0.65, 1]
        topGradientLayer.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 80)

        view.layer.addSublayer(bottomGradientLayer)
        view.layer.addSublayer(topGradientLayer)
    }

    // MARK: - Actions

    func didTapLeftButton() {

        output.backButtonTapped()
    }

    func didTapConfirmButton() {

        output.didTapConfirmButton()
    }
}

// MARK: - UIScrollView

extension TermsViewController: UITextViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height) {
            confirmButton.isEnabled = true
        }
    }
}

// MARK: - TermsViewInput

extension TermsViewController: TermsViewInput {

    func setupInitialState(withTerms terms: Terms) {

        htmlFormatter.setHTMLText(terms.text, toTextView: textView, withFont: UIFont.fdlSystemRegular(size: 15), textColor: .fdlWarmGrey)

        confirmButton.isEnabled = textView.contentSize.height <= textView.frame.height
    }
}
