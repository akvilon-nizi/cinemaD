// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// swiftlint:disable explicit_type_interface identifier_name line_length nesting type_body_length type_name
enum L10n {
  /// Отменить
  static let alertButtonCancel = L10n.tr("Localizable", "alert-button-cancel")
  /// ОК
  static let alertButtonOk = L10n.tr("Localizable", "alert-button-ok")
  /// Проверьте корректность введеных данных
  static let alertCinemaCorrectErrror = L10n.tr("Localizable", "alert-cinema-correct-errror")
  /// Сетевая ошибка
  static let alertCinemaNetworkErrror = L10n.tr("Localizable", "alert-cinema-network-errror")
  /// Коллекция добавлена
  static let alertCollectionsAdd = L10n.tr("Localizable", "alert-collections-add")
  /// Коллекция изменена
  static let alertCollectionsChange = L10n.tr("Localizable", "alert-collections-change")
  /// Коллекция удалена
  static let alertCollectionsRemove = L10n.tr("Localizable", "alert-collections-remove")
  /// Сетевая ошибка
  static let alertTitleNetworkError = L10n.tr("Localizable", "alert-title-network-error")
  /// Системная ошибка
  static let alertTitleSystemError = L10n.tr("Localizable", "alert-title-system-error")
  /// Свет, Камера, Мотор!
  static let authButtonText = L10n.tr("Localizable", "auth-button-text")
  /// Помощь со входом в систему
  static let authHelpButtonText = L10n.tr("Localizable", "auth-help-button-text")
  /// Пароль
  static let authPasswordPlaceholder = L10n.tr("Localizable", "auth-password-placeholder")
  /// Телефон
  static let authPhonePlaceholder = L10n.tr("Localizable", "auth-phone-placeholder")
  /// Забыли данные для входа?
  static let authRememberText = L10n.tr("Localizable", "auth-remember-text")
  /// Вход
  static let authTitleText = L10n.tr("Localizable", "auth-title-text")
  /// Справочный центр CinemaD
  static let authHelpCenterText = L10n.tr("Localizable", "authHelp-center-text")
  /// Отправить на Эл. почту
  static let authHelpPostButtonText = L10n.tr("Localizable", "authHelp-post-button-text")
  /// Отправить SMS код
  static let authHelpSmsButtonText = L10n.tr("Localizable", "authHelp-sms-button-text")
  /// Помощь при входе
  static let authHelpTitleText = L10n.tr("Localizable", "authHelp-title-text")
  /// collection updated
  static let collectionsUpdateMessage = L10n.tr("Localizable", "collections-update-message")
  /// Войдите
  static let confirmationButtonAuthText = L10n.tr("Localizable", "confirmation-button-auth-text")
  /// Код
  static let confirmationCodeText = L10n.tr("Localizable", "confirmation-code-text")
  /// У вас уже есть аккаунт?
  static let confirmationHaveAuthText = L10n.tr("Localizable", "confirmation-have-auth-text")
  /// Введите 6-значный код, который\nбыл отпрпавлен на номер\n%@
  static func confirmationInfoText(_ p1: String) -> String {
    return L10n.tr("Localizable", "confirmation-info-text", p1)
  }
  /// Запросить новый
  static let confirmationNewPasswordButton = L10n.tr("Localizable", "confirmation-new-password-button")
  /// Далее
  static let confirmationNextButtonText = L10n.tr("Localizable", "confirmation-next-button-text")
  /// Подтверждение
  static let confirmationTitleText = L10n.tr("Localizable", "confirmation-title-text")
  /// Награды и премии
  static let filmAdwardsText = L10n.tr("Localizable", "film-adwards-text")
  /// Возраст
  static let filmAgeText = L10n.tr("Localizable", "film-age-text")
  /// Бюджет
  static let filmBudjetText = L10n.tr("Localizable", "film-budjet-text")
  /// Сборы
  static let filmCashText = L10n.tr("Localizable", "film-cash-text")
  /// Изменения сохранены
  static let filmChangeStatusWatch = L10n.tr("Localizable", "film-change-status-watch")
  /// Сюжет:
  static let filmDescriptionText = L10n.tr("Localizable", "film-description-text")
  /// Длительность
  static let filmDurationText = L10n.tr("Localizable", "film-duration-text")
  /// Приласить на фильм
  static let filmInviteFilm = L10n.tr("Localizable", "film-invite-film")
  /// Актёры и режиссёры:
  static let filmMansText = L10n.tr("Localizable", "film-mans-text")
  ///   Читать дальше >
  static let filmMoreButton = L10n.tr("Localizable", "film-more-button")
  /// Купить билеты
  static let filmPayTicket = L10n.tr("Localizable", "film-pay-ticket")
  /// collection removed
  static let filmResponseDeleteCollection = L10n.tr("Localizable", "film-response-delete-collection")
  /// film removed from this collection
  static let filmResponseDeleteFilmCollection = L10n.tr("Localizable", "film-response-delete-film-collection")
  /// film append to this collection
  static let filmResponsePutCollection = L10n.tr("Localizable", "film-response-put-collection")
  /// film append to the 'watched'
  static let filmResponseWatched = L10n.tr("Localizable", "film-response-watched")
  /// film remove from the 'watched'
  static let filmResponseWatchedDelete = L10n.tr("Localizable", "film-response-watched-delete")
  /// film append to the 'will_watch'
  static let filmResponseWillWatch = L10n.tr("Localizable", "film-response-will_watch")
  /// film remove from the 'will_watch'
  static let filmResponseWillWatchDelete = L10n.tr("Localizable", "film-response-will_watch-delete")
  /// Поиск
  static let filmSearchPlaceholder = L10n.tr("Localizable", "film-search-placeholder")
  /// Рейтинг фильма:
  static let filmSetStatusRate = L10n.tr("Localizable", "film-set-status-rate")
  /// tMDB
  static let filmTmdbText = L10n.tr("Localizable", "film-tmdb-text")
  /// Поставьте оценку, и фильм появится в Кинобазе!
  static let filmWatchAlert = L10n.tr("Localizable", "film-watch-alert")
  /// Смотрел
  static let filmWatchedButton = L10n.tr("Localizable", "film-watched-button")
  /// Посмотрю
  static let filmWillWatchButton = L10n.tr("Localizable", "film-willWatch-button")
  /// Ваша оценка:
  static let filmYourStar = L10n.tr("Localizable", "film-your-star")
  /// Полный список
  static let filmsTitleText = L10n.tr("Localizable", "films-title-text")
  /// Год
  static let filterFilter1Title = L10n.tr("Localizable", "filter-filter1-title")
  /// Жанр
  static let filterFilter2Title = L10n.tr("Localizable", "filter-filter2-title")
  /// Фильтр
  static let filterTitleText = L10n.tr("Localizable", "filter-title-text")
  /// contest
  static let filtersNewsDrawing = L10n.tr("Localizable", "filters-news-drawing")
  /// free_cinema_session
  static let filtersNewsFree = L10n.tr("Localizable", "filters-news-free")
  /// events_about_the_actors
  static let filtersNewsMessageActors = L10n.tr("Localizable", "filters-news-message-actors")
  /// novelties
  static let filtersNewsNew = L10n.tr("Localizable", "filters-news-new")
  /// Полный список
  static let kinobaseCollectionText = L10n.tr("Localizable", "kinobase-collection-text")
  /// + Создать коллекцию
  static let kinobaseFavoritesTitle = L10n.tr("Localizable", "kinobase-favorites-title")
  /// Полный список
  static let kinobaseFullList = L10n.tr("Localizable", "kinobase-full-list")
  /// Полный список
  static let kinobaseMakeCollection = L10n.tr("Localizable", "kinobase-make-collection")
  /// Поиск
  static let kinobaseSearchText = L10n.tr("Localizable", "kinobase-search-text")
  /// Кинобаза
  static let kinobaseTitleText = L10n.tr("Localizable", "kinobase-title-text")
  /// Смотрел
  static let kinobaseWatchedButton = L10n.tr("Localizable", "kinobase-watched-button")
  /// Посмотрю
  static let kinobaseWillWatchButton = L10n.tr("Localizable", "kinobase-willWatch-button")
  /// Розыгрыши
  static let mainNewsDrawing = L10n.tr("Localizable", "main-news-drawing")
  /// Бесплатные сеансы
  static let mainNewsFree = L10n.tr("Localizable", "main-news-free")
  /// События о актерах
  static let mainNewsMessageActors = L10n.tr("Localizable", "main-news-message-actors")
  /// Новинки
  static let mainNewsNew = L10n.tr("Localizable", "main-news-new")
  /// Новости
  static let mainNewsTitle = L10n.tr("Localizable", "main-news-title")
  /// Подтверждение
  static let newPasswordConfirmPlaceholder = L10n.tr("Localizable", "newPassword-confirm-placeholder")
  /// Новый пароль
  static let newPasswordPasswordPlaceholder = L10n.tr("Localizable", "newPassword-password-placeholder")
  /// Готово
  static let newPasswordReadyButtonText = L10n.tr("Localizable", "newPassword-ready-button-text")
  /// Новый пароль
  static let newPasswordTitleText = L10n.tr("Localizable", "newPassword-title-text")
  /// Написать комментарий
  static let newsMessagePlaceholder = L10n.tr("Localizable", "news-message-placeholder")
  /// Новость
  static let newsTitleText = L10n.tr("Localizable", "news-title-text")
  /// На указанный номер телефона будет\nотправлено сообщение с кодом\nподтврждения
  static let phoneInfoText = L10n.tr("Localizable", "phone-info-text")
  /// Далее
  static let phoneNextButtonText = L10n.tr("Localizable", "phone-next-button-text")
  /// Ваш номер
  static let phonePhonePlaceholder = L10n.tr("Localizable", "phone-phone-placeholder")
  /// Номер телефона
  static let phoneTitleText = L10n.tr("Localizable", "phone-title-text")
  /// и
  static let regAndText = L10n.tr("Localizable", "reg-and-text")
  /// Свет, Камера, Мотор!
  static let regButtonText = L10n.tr("Localizable", "reg-button-text")
  /// Условия
  static let regConditionsButtonText = L10n.tr("Localizable", "reg-conditions-button-text")
  /// Регистрируясь, вы принимаете наши
  static let regInfoText = L10n.tr("Localizable", "reg-info-text")
  /// Имя
  static let regNamePlaceholder = L10n.tr("Localizable", "reg-name-placeholder")
  /// Пароль
  static let regPasswordPlaceholder = L10n.tr("Localizable", "reg-password-placeholder")
  /// Телефон
  static let regPhonePlaceholder = L10n.tr("Localizable", "reg-phone-placeholder")
  /// Политика конфиденциальности
  static let regRegulationsButtonText = L10n.tr("Localizable", "reg-regulations-button-text")
  /// Регистрация
  static let regTitleText = L10n.tr("Localizable", "reg-title-text")
  /// По геолокации
  static let rewardsLocationTitle = L10n.tr("Localizable", "rewards-location-title")
  /// За просмотры
  static let rewardsReviewsTitle = L10n.tr("Localizable", "rewards-reviews-title")
  /// Награды
  static let rewardsTitleText = L10n.tr("Localizable", "rewards-title-text")
  /// Поехали !
  static let slideMainButton = L10n.tr("Localizable", "slide-main-button")
  /// Купить билеты
  static let slide1ButtonText = L10n.tr("Localizable", "slide1-button-text")
  /// Покупай электронные билеты в кино\nпрямо из приложения
  static let slide1DescriptionText = L10n.tr("Localizable", "slide1-description-text")
  /// Покупай билеты
  static let slide1TitleText = L10n.tr("Localizable", "slide1-title-text")
  /// Пригласить на фильм
  static let slide2ButtonText = L10n.tr("Localizable", "slide2-button-text")
  /// Приглашайте друзей на фильм\nи делитесь впечатлениями
  static let slide2DescriptionText = L10n.tr("Localizable", "slide2-description-text")
  /// Создавайте встречи
  static let slide2TitleText = L10n.tr("Localizable", "slide2-title-text")
  /// Получайте награды за просмотры\nваших любимых фильмов
  static let slide3DescriptionText = L10n.tr("Localizable", "slide3-description-text")
  /// Легенда
  static let slide3LabelDescriptionText = L10n.tr("Localizable", "slide3-label-description-text")
  /// Вселенная Marvel
  static let slide3LabelTitleText = L10n.tr("Localizable", "slide3-label-title-text")
  /// Получайте награды
  static let slide3TitleText = L10n.tr("Localizable", "slide3-title-text")
  /// Войдите
  static let startButtonAuthText = L10n.tr("Localizable", "start-button-auth-text")
  /// Войти через Facebook
  static let startFacebookText = L10n.tr("Localizable", "start-facebook-text")
  /// У вас уже есть аккаунт?
  static let startHaveAuthText = L10n.tr("Localizable", "start-have-auth-text")
  /// Регистрация
  static let startRegistrationText = L10n.tr("Localizable", "start-registration-text")
  /// CINEMAD
  static let startTitleText = L10n.tr("Localizable", "start-title-text")
  /// Войти через Vkontakte
  static let startVkontakteText = L10n.tr("Localizable", "start-vkontakte-text")
}
// swiftlint:enable explicit_type_interface identifier_name line_length nesting type_body_length type_name

extension L10n {
  fileprivate static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
