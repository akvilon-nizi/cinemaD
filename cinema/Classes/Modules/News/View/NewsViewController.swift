//
// Created by akvilon-nizi on 16/11/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit
import RxMoya
import VKSdkFramework

struct NewsData {
    var news: News?
    var comments: [Comment] = []
}

enum NewsType {
    case common
    case images
    case video
}

class NewsViewController: ParentViewController {

    var output: NewsViewOutput!

    let tableView = UITableView(frame: CGRect.zero, style: .grouped)

    var newsType: NewsType = .common

    var newsData = NewsData()

    let bottomView = UIView()

    let messageView = MessageView()

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
        backButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        var frame = backButton.frame
        frame.size = CGSize(width: 30, height: 100)
        backButton.frame = frame
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)

//        let homeButton = UIButton()
//        homeButton.setImage(Asset.Cinema.home.image, for: .normal)
//        homeButton.addTarget(self, action: #selector(didTapHomeButton), for: .touchUpInside)
//        homeButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -20)
//        frame = homeButton.frame
//        frame.size = CGSize(width: 30, height: 100)
//        homeButton.frame = frame
//        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: homeButton)

        titleViewLabel.text = L10n.newsTitleText
        titleViewLabel.font = UIFont.cnmFutura(size: 20)

        tableView.backgroundColor = .white
        view.addSubview(tableView.prepareForAutoLayout())
        tableView.pinEdgesToSuperviewEdges()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableViewRegister()

        addAddView()

        activityVC.isHidden = false
        activityVC.startAnimating()
        view.bringSubview(toFront: activityVC)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    private func tableViewRegister() {
        tableView.register(CommentCell.self, forCellReuseIdentifier: CommentCell.reuseIdentifier)
    }

    private func addAddView() {

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
        addButton.isHidden = true

        messageView.delegate = self
        view.addSubview(messageView.prepareForAutoLayout())
        messageView.heightAnchor ~= 55
        messageView.widthAnchor ~= view.widthAnchor
        constraintAddView = messageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        constraintAddView?.isActive = true
        messageView.isHidden = true
    }

    func loadData(_ news: News) {
        if news.type == "common" {
            newsType = .common
        } else {
            newsType = .images
        }
        addButton.isHidden = false
        tableView.reloadData()
    }

    func shareNews(imageShare: UIImage?) {
        if let newsShare = newsData.news {
            let vkShare = VKShareDialogController()
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

    func didTapHomeButton() {
        output?.homeButtonTap()
    }

    func didTapAddButton() {
        addButton.isHidden = true
        messageView.isHidden = false
    }

    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if constraintAddView?.constant == 0 {
                constraintAddView?.constant = -keyboardSize.size.height + 80
                UIView.animate(withDuration: 0) {
                    self.view.layoutIfNeeded()
                }
            }
        }
    }

    func keyboardWillHide(notification: NSNotification) {
        if constraintAddView?.constant != 0 {
            constraintAddView?.constant = 0
            UIView.animate(withDuration: 0) {
                self.view.layoutIfNeeded()
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension NewsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsData.comments.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentCell.reuseIdentifier, for: indexPath)
        if let collCel = cell as? CommentCell {
            collCel.setComment(newsData.comments[indexPath.row])
            return collCel
        }
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
        if let newsA = newsData.news {
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
        //return 200
        return UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
}

// MARK: - NewsViewInput

extension NewsViewController: NewsViewInput {

    func addComment(_ comment: Comment) {
        newsData.comments.append(comment)
        let indexPath = IndexPath(row: newsData.comments.count - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: .top)
        tableView.scrollToRow(at: indexPath, at: .top, animated: false)
        activityVC.isHidden = true
        activityVC.stopAnimating()
    }

    func openNews(_ newsData: NewsData) {
        activityVC.isHidden = true
        activityVC.stopAnimating()
        self.newsData = newsData
        if let news = newsData.news {
            loadData(news)
        }
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
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}

// MARK: - MessageViewDelegate

extension NewsViewController: MessageViewDelegate {
    func sendMessage(_ message: String) {
        closeMessageView()
        output?.sendMessage(message: message)
        activityVC.isHidden = false
        activityVC.startAnimating()
    }

    func close() {
        closeMessageView()
    }

    func closeMessageView() {
        view.endEditing(true)
        messageView.isHidden = true
        addButton.isHidden = false
    }
}
