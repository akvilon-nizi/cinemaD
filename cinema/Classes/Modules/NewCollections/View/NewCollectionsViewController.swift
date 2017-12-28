//
// Created by akvilon-nizi on 31/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

class NewCollectionsViewController: ParentViewController {

    var output: NewCollectionsViewOutput!

    var nameCollections: String = ""

    var watched: [Film] = []

    var collections: [Film] = []

    let headerCollectionsView = HeaderCollectionsView()

    let searchFilms = FilmGroup()

    let scrollView = UIScrollView()

    let windowWidth = UIWindow(frame: UIScreen.main.bounds).bounds.width - 80

    var currentHeight: CGFloat = 0

    var heightLayout: NSLayoutConstraint?

    var searchHeightLayout: NSLayoutConstraint?

    let saveButton = UIButton()

    var heightFilmGroup: CGFloat = 0

    var stackView = UIStackView()

    var query: String = ""

    let headerSearchView = SearchCommonView()

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

        view.backgroundColor = .white

        let backButton = UIButton()
        backButton.setImage(Asset.NavBar.navBarArrowBack.image, for: .normal)
        backButton.addTarget(self, action: #selector(didTapLeftButton), for: .touchUpInside)
        backButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        var frame = backButton.frame
        frame.size = CGSize(width: 30, height: 100)
        backButton.frame = frame
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)

        saveButton.setImage(Asset.Kinobase.checkMini.image, for: .normal)
        saveButton.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
        saveButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        frame = saveButton.frame
        frame.size = CGSize(width: 30, height: 100)
        frame.origin.x -= 9
        saveButton.frame = frame
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveButton)

        titleViewLabel.text = nameCollections == "" ? "Новая коллекция" : nameCollections
        titleViewLabel.font = UIFont.cnmFutura(size: 20)

        scrollView.backgroundColor = .white
        view.addSubview(scrollView.prepareForAutoLayout())
        scrollView.pinEdgesToSuperviewEdges()

        if nameCollections != "" {
            activityVC.isHidden = false
            activityVC.startAnimating()
        }
        view.bringSubview(toFront: activityVC)
    }

    func setStackView() {
        currentHeight = 88

        var viewsArray: [UIView] = []
        viewsArray.append(headerCollectionsView)

        if !nameCollections.isEmpty {
            headerCollectionsView.title = nameCollections
        }

        headerCollectionsView.heightAnchor ~= currentHeight

        heightFilmGroup = windowWidth / 4 * 3 - 43.5

        headerSearchView.delegate = self
        headerSearchView.heightAnchor ~= 48
        currentHeight += 48
        viewsArray.append(headerSearchView)

        viewsArray.append(searchFilms)
        searchFilms.isCollections = true
        searchFilms.isAdd = true
        searchFilms.delegate = self

        if nameCollections != "" {
            let titleView = HeaderViewTitle()
            titleView.title = "Коллекция"
            titleView.heightAnchor ~= 44
            viewsArray.append(titleView)

            currentHeight += 44

            let filmGroup = FilmGroup()
            filmGroup.films = collections
            filmGroup.isCollections = true
            filmGroup.isAdd = false
            filmGroup.heightAnchor ~= heightFilmGroup
            viewsArray.append(filmGroup)

            currentHeight += heightFilmGroup
        }

        searchHeightLayout = searchFilms.heightAnchor.constraint(equalToConstant: 0)
        searchHeightLayout?.isActive = true

        if nameCollections != "" {
            let deleteFooter = DeleteFooter()
            deleteFooter.deleteButton.addTarget(self, action: #selector(didTapDeleteButton), for: .touchUpInside)
            deleteFooter.heightAnchor ~= 66
            viewsArray.append(deleteFooter)
            currentHeight += 66
        }

        stackView = createStackView(.vertical, .fill, .fill, 0, with: viewsArray)
        stackView.widthAnchor ~= UIWindow(frame: UIScreen.main.bounds).bounds.width
        heightLayout = stackView.heightAnchor.constraint(equalToConstant: currentHeight)
        heightLayout?.isActive = true
        stackView.frame = CGRect(x: 0, y: 0, width: UIWindow(frame: UIScreen.main.bounds).bounds.width, height: currentHeight)
        scrollView.addSubview(stackView.prepareForAutoLayout())
        stackView.pinEdgesToSuperviewEdges()
        scrollView.contentSize = stackView.frame.size

    }

    func getSearch(_ films: [Film]) {

        headerSearchView.hiddenActivityVC()

        var filmsArray: [Film] = []

        for film in films {
            let col = collections.filter{ $0.id == film.id }
            if col.isEmpty {
                let col1 = watched.filter{ $0.id == film.id }
                if !col1.isEmpty {
                    film.add = true
                }
                filmsArray.append(film)
            }
        }

        if searchFilms.films.isEmpty && !filmsArray.isEmpty {
            searchHeightLayout?.constant = heightFilmGroup
            UIView.animate(withDuration: 0) {
                self.stackView.layoutIfNeeded()
            }
            currentHeight += heightFilmGroup
            setStackViewHeight()
        }

        if !searchFilms.films.isEmpty && filmsArray.isEmpty {
            searchHeightLayout?.constant = 0
            UIView.animate(withDuration: 0) {
               self.stackView.layoutIfNeeded()
            }
            currentHeight -= heightFilmGroup
            setStackViewHeight()
        }

        searchFilms.films = filmsArray

    }

    func setStackViewHeight() {
        heightLayout?.constant = currentHeight
        UIView.animate(withDuration: 0) {
            self.stackView.layoutIfNeeded()
        }
        scrollView.contentSize = CGSize(width: UIWindow(frame: UIScreen.main.bounds).bounds.width, height: currentHeight)
    }

    // MARK: - Actions
    func didTapLeftButton() {
        output?.backButtonTap()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    func didTapSaveButton() {
        let filteredWatched = watched.filter {
            $0.add == true
        }
        let filteredAnWatched = collections.filter {
            $0.delete == false
        }

        let films = filteredWatched + filteredAnWatched

        if nameCollections.isEmpty {
            if filteredWatched.isEmpty {
                 showAlert(message: "Выберите фильмы")
            } else {
                if  !headerCollectionsView.returnTitle().isEmpty {
                 output?.addNewFilm(name: headerCollectionsView.returnTitle(), films: filteredWatched)
                saveButton.isEnabled = false
                activityVC.isHidden = false
                activityVC.startAnimating()
                view.bringSubview(toFront: activityVC)
                } else {
                    showAlert(message: "Название не может быть пустым")
                }
            }
        } else {
                if films.isEmpty {
                    showAlert(message: "Коллекция не может быть пустой")
                } else {
                    if  !headerCollectionsView.returnTitle().isEmpty {
                        saveButton.isEnabled = false
                        activityVC.isHidden = false
                        activityVC.startAnimating()
                        output?.patchCollections(name: headerCollectionsView.returnTitle(), films: films)
                    } else {
                        showAlert(message: "Название не может быть пустым")
                    }
                }
        }
    }

    func didTapDeleteButton() {
        output?.deleteCollections()
    }
}

// MARK: - NewCollectionsViewInput

extension NewCollectionsViewController: NewCollectionsViewInput {

    func setupInitialState() {

    }

    func getError() {
        showAlert(message: L10n.alertCinemaNetworkErrror)
         view.isUserInteractionEnabled = true
        saveButton.isEnabled = true
        activityVC.isHidden = true
        activityVC.stopAnimating()
    }

    func setCollections(collections: [Film]) {
        self.collections = collections
        setStackView()
        activityVC.isHidden = true
        activityVC.stopAnimating()
    }

    func getSeccess(message: String) {
        showAlert(message: message)
    }
}

// MARK: - SearchCommonDelegate

extension NewCollectionsViewController: SearchCommonDelegate {
    func changeText(_ text: String) {
        if text.count >= 1 {
            if text != query {
                output?.getQuery(text)
            }
        } else {
            getSearch([])
            if text != query {
                output?.getQuery(text)
            }
        }
        query = text
    }
    func tapFilter() {
    }
}

// MARK: - FilmGroupDelegate
extension NewCollectionsViewController: FilmGroupDelegate {
    func openFilmID(_ filmID: String, name: String) {
        //output?.openFilm(videoID: filmID, name: name)
    }

    func changeStatusFilm(_ film: Film, isAdd: Bool) {
        if isAdd {
            watched.append(film)
        } else {
           watched = watched.filter{ $0.id != film.id }
        }
    }
}
