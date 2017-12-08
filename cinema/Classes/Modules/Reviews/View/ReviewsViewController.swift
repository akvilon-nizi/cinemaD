//
// Created by Danila Lyahomskiy on 28/11/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

class ReviewsViewController: ParentViewController {

    var output: ReviewsViewOutput!

    let filmID: String

    let name: String

    let genres: String

    let tableView = UITableView(frame: CGRect.zero, style: .grouped)

    let reviewsHeader = ReviewsHeaderView()

    let addButton = UIButton()

    let messageView = MessageView()

    var constraintAddView: NSLayoutConstraint?

    var comments: [Comment] = []

    var myID: String = ""

    var currentDeleteIndex: Int = 0

    // MARK: - Life cycle

    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    init(filmID: String, name: String, genres: String) {
        self.filmID = filmID
        self.name = name
        self.genres = genres
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

        view.backgroundColor = .white

        let backButton = UIButton()
        backButton.setImage(Asset.NavBar.navBarArrowBack.image, for: .normal)
        backButton.addTarget(self, action: #selector(didTapLeftButton), for: .touchUpInside)
        backButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        var frame = backButton.frame
        frame.size = CGSize(width: 30, height: 100)
        backButton.frame = frame
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)

        let homeButton = UIButton()
        homeButton.setImage(Asset.Cinema.home.image, for: .normal)
        homeButton.addTarget(self, action: #selector(didTapHomeButton), for: .touchUpInside)
        homeButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        frame = homeButton.frame
        frame.origin.x -= 9
        frame.size = CGSize(width: 30, height: 100)
        homeButton.frame = frame
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: homeButton)

        titleViewLabel.text = L10n.reviewsTitleText
        titleViewLabel.font = UIFont.cnmFutura(size: 20)

        view.addSubview(tableView.prepareForAutoLayout())
        tableView.pinEdgesToSuperviewEdges()

        reviewsHeader.setParameters(name: name, genres: genres)

        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100.0
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.register(ReviewsCell.self, forCellReuseIdentifier: ReviewsCell.reuseIdentifier)
        tableView.reloadData()

        addAddView()

        addButton.layer.borderColor = UIColor(white: 0, alpha: 0.1).cgColor
        addButton.layer.borderWidth = 1

        activityVC.isHidden = false
        activityVC.startAnimating()
        view.bringSubview(toFront: activityVC)

        if let appDelegate = UIApplication.shared.delegate as? AppDelegate, let profile = appDelegate.profile {
            myID = profile.id
        }

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
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
        //addButton.isHidden = true

        messageView.delegate = self
        view.addSubview(messageView.prepareForAutoLayout())
        messageView.heightAnchor ~= 55
        messageView.widthAnchor ~= view.widthAnchor
        constraintAddView = messageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        constraintAddView?.isActive = true
        messageView.isHidden = true
    }

    // MARK: - Actions
    func didTapLeftButton() {
        output?.backTap()
    }

    func didTapHomeButton() {
        output?.homeTap()
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

// MARK: - ReviewsViewInput

extension ReviewsViewController: ReviewsViewInput {
    func openComments(_ comments: [Comment]) {
        self.comments = comments
        tableView.reloadData()
        activityVC.isHidden = true
        activityVC.stopAnimating()
    }

    func showNetworkError() {
        showAlert(message: L10n.alertCinemaNetworkErrror)
        activityVC.isHidden = true
        activityVC.stopAnimating()
    }

    func addComment(_ comment: Comment) {
        comments.append(comment)
        let indexPath = IndexPath(row: comments.count - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: .top)
        tableView.scrollToRow(at: indexPath, at: .top, animated: false)
        activityVC.isHidden = true
        activityVC.stopAnimating()
    }

    func setupInitialState() {
    }

    func deleteComment() {
        let indexPath = IndexPath(row: currentDeleteIndex, section: 0)
        comments.remove(at: currentDeleteIndex)
        tableView.reloadSections(IndexSet(integersIn: 0...0), with: UITableViewRowAnimation.none)
        activityVC.isHidden = true
        activityVC.stopAnimating()
    }
}

// MARK: - UITableViewDataSource

extension ReviewsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return comments.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReviewsCell.reuseIdentifier, for: indexPath)
        if let collCel = cell as? ReviewsCell {
            collCel.setComment(comments[indexPath.row])
            collCel.delegate = self
            collCel.indexRow = indexPath.row
            if myID == comments[indexPath.row].creator.id {
                collCel.isMain()
            }
        }
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

}

// MARK: - UITableViewDelegate

extension ReviewsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return reviewsHeader
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
}

// MARK: - UITextViewDelegate

extension ReviewsViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}

// MARK: - MessageViewDelegate

extension ReviewsViewController: MessageViewDelegate {
    func sendMessage(_ message: String) {
        closeMessageView()
        output?.sendReview(name: "", description: message)
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

// MARK: - ReviewsCellDelegate

extension ReviewsViewController: ReviewsCellDelegate {
    func deleteReview(indexRow: Int) {
        if activityVC.isHidden {
            output.deleteReview(id: comments[indexRow].id)
            currentDeleteIndex = indexRow
            activityVC.isHidden = false
            activityVC.startAnimating()
        }
    }
}
