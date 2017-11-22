//
// Created by akvilon-nizi on 16/11/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit
import RxMoya
import VKSdkFramework

enum NewsType {
    case common
    case images
    case video
}

class NewsViewController: ParentViewController {

    var output: NewsViewOutput!

    let tableView = UITableView(frame: CGRect.zero, style: .grouped)

    var newsType: NewsType = .common

    var news: News?

    let bottomView = UIView()

    let addView = UIView()

    let textView = UITextView()

    let addButton = UIButton()

    var constraintAddView: NSLayoutConstraint?

    // MARK: - Life cycle

    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()

        let backButton = UIButton()
        backButton.setImage(Asset.NavBar.navBarArrowBack.image, for: .normal)
        backButton.addTarget(self, action: #selector(didTapLeftButton), for: .touchUpInside)
        backButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        var frame = backButton.frame
        frame.size = CGSize(width: 30, height: 100)
        backButton.frame = frame
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)

        titleViewLabel.text = L10n.newsTitleText
        titleViewLabel.font = UIFont.cnmFutura(size: 20)

        tableView.backgroundColor = .white
        view.addSubview(tableView.prepareForAutoLayout())
        tableView.pinEdgesToSuperviewEdges()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        tableView.separatorStyle = .none

        addAddView()

        addButton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
        addButton.setImage(Asset.Cinema.plus.image, for: .normal)
        addButton.heightAnchor ~= 69
        addButton.widthAnchor ~= 69
        addButton.layer.cornerRadius = 69 / 2
        view.addSubview(addButton.prepareForAutoLayout())
        addButton.bottomAnchor ~= view.bottomAnchor - 12
        addButton.trailingAnchor ~= view.trailingAnchor - 12
        addButton.backgroundColor = UIColor(white: 1, alpha: 0.5)

        addButton.layer.borderColor = UIColor(white: 0, alpha: 0.1).cgColor
        addButton.layer.borderWidth = 1

        addButton.layoutSubviews()
        addButton.layoutIfNeeded()

        activityVC.isHidden = false
        activityVC.startAnimating()

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    private func addAddView() {
        view.addSubview(addView.prepareForAutoLayout())
        addView.heightAnchor ~= 55
        addView.widthAnchor ~= view.widthAnchor
        addView.backgroundColor = .red
        constraintAddView = addView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        constraintAddView?.isActive = true

        textView.delegate = self
        addView.addSubview(textView.prepareForAutoLayout())
        textView.pin(to: addView, top: 3, left: 30, right: 30, bottom: 3)
    }

    func loadData(_ news: News) {
        self.news = news
        if news.type == "common" {
            newsType = .common
        } else {
            newsType = .images
        }
        tableView.reloadData()
    }

    func shareNews(imageShare: UIImage?) {
        if let newsShare = news {
            let vkShare = VKShareDialogController()
//            var text = newsShare.description.components(separatedBy: ".")
            let string: String = newsShare.name + ". " + newsShare.description
            vkShare.text = string
            if let image = imageShare {
                let img = VKUploadImage(image: image, andParams: nil)
                vkShare.uploadImages = [img as Any]
            }
            let link = URL(string: Configurations.linkShare)
            vkShare.shareLink = VKShareLink(title: "Cinemad", link: link)

            vkShare.completionHandler = { result, str  in
                self.dismiss(animated: true, completion: nil)
            }

            present(vkShare, animated: true, completion: nil)
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Actions
    func didTapLeftButton() {
        output?.backButtonTap()
    }

    func didTapAddButton() {
        print()
    }

    func keyboardWillShow(notification: NSNotification) {

//        if let keyboardSize1 = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? CGRect {
//
//            print()
//        }

                if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                    if constraintAddView?.constant == 0 {
                        constraintAddView?.constant = -keyboardSize.size.height + 80
                        UIView.animate(withDuration: 0.5) {
                            self.view.layoutIfNeeded()
                        }
                    }
//        if self.view.frame.origin.y == 0 {
//            self.view.frame.origin.y -= 100
//        }
                }

    }

    func keyboardWillHide(notification: NSNotification) {

                    if constraintAddView?.constant != 0 {
                        constraintAddView?.constant = 0
                        UIView.animate(withDuration: 0.5) {
                            self.view.layoutIfNeeded()
                        }
                    }
//        if self.view.frame.origin.y != 0 {
//            self.view.frame.origin.y += 100
//
//        }
       // }
    }
}

// MARK: - UITableViewDataSource

extension NewsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
//        let cell = tableView.dequeueReusableCell(withIdentifier: FilterCell.reuseIdentifier, for: indexPath)
//        if let collCel = cell as? FilterCell {
//
//        }
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let collectionCell = tableView.cellForRow(at: indexPath) as? FilterCell {
//        }
    }

}

// MARK: - ImageNewsHeaderDelegate

extension NewsViewController: ImageNewsHeaderDelegate {
    func openShare(image: UIImage?) {
        shareNews(imageShare: image)
    }
}

// MARK: - SimpleNewsHeaderDelegate
extension NewsViewController: SimpleNewsHeaderDelegate {
    func openShareSimple() {
        shareNews(imageShare: nil)
    }
}

// MARK: - UITableViewDelegate

extension NewsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let newsA = news {
            if newsType == .common {
                let view = SimpleNewsHeader()
                view.setNews(newsA)
                view.delegate = self
                return view
            } else {
                let view = ImageNewsHeader()
                view.setNews(newsA)
                view.delegate = self
                return view
            }
        }
        return nil
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
}

// MARK: - NewsViewInput

extension NewsViewController: NewsViewInput {
    func openNews(_ news: News) {
        activityVC.isHidden = true
        activityVC.stopAnimating()
        loadData(news)
    }

    func showNetworkError() {
        showAlert(message: L10n.alertCinemaNetworkErrror)
        activityVC.isHidden = true
        activityVC.stopAnimating()
    }

    func setupInitialState() {

    }
}

// MARK: - UITextViewDelegate

extension NewsViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
