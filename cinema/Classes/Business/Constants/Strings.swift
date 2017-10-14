// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

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
  /// Сетевая ошибка
  static let alertTitleNetworkError = L10n.tr("Localizable", "alert-title-network-error")
  /// Системная ошибка
  static let alertTitleSystemError = L10n.tr("Localizable", "alert-title-system-error")
  /// Свет, Камера, Мотор!
  static let authButtonText = L10n.tr("Localizable", "auth-button-text")
  /// Изменить номер
  static let authChangeNumber = L10n.tr("Localizable", "auth-change-number")
  /// На номер %@ отправлен код
  static func authCodeSend(_ p1: String) -> String {
    return L10n.tr("Localizable", "auth-code-send", p1)
  }
  /// Подтвердите номер
  static let authConfirmNumber = L10n.tr("Localizable", "auth-confirm-number")
  /// Пожалуйста, введите номер своего телефона, чтоб авторизироваться
  static let authDescription = L10n.tr("Localizable", "auth-description")
  /// Помощь со входом в систему
  static let authHelpButtonText = L10n.tr("Localizable", "auth-help-button-text")
  /// Пароль
  static let authPasswordPlaceholder = L10n.tr("Localizable", "auth-password-placeholder")
  /// Телефон
  static let authPhonePlaceholder = L10n.tr("Localizable", "auth-phone-placeholder")
  /// Забыли данные для входа?
  static let authRememberText = L10n.tr("Localizable", "auth-remember-text")
  /// Повторить SMS
  static let authResendSms = L10n.tr("Localizable", "auth-resend-sms")
  /// Отправить потворно
  static let authRetrySms = L10n.tr("Localizable", "auth-retry-sms")
  /// Авторизируйтесь
  static let authTitle = L10n.tr("Localizable", "auth-title")
  /// Вход
  static let authTitleText = L10n.tr("Localizable", "auth-title-text")
  /// Через %@
  static func authWaitTitle(_ p1: String) -> String {
    return L10n.tr("Localizable", "auth-wait-title", p1)
  }
  /// Справочный центр CinemaD
  static let authHelpCenterText = L10n.tr("Localizable", "authHelp-center-text")
  /// Отправить на Эл. почту
  static let authHelpPostButtonText = L10n.tr("Localizable", "authHelp-post-button-text")
  /// Отправить SMS код
  static let authHelpSmsButtonText = L10n.tr("Localizable", "authHelp-sms-button-text")
  /// Помощь при входе
  static let authHelpTitleText = L10n.tr("Localizable", "authHelp-title-text")
  /// Добавить
  static let cardProductButtonAdd = L10n.tr("Localizable", "card-product-button-add")
  /// Тесто, пицца соус, сыр моцарелла, свинина, ветчина, кура, пепперони, помидоры, шампиньоны, огурцы маринованные, лук красный Тесто, пицца соус, сыр моцарелла, свинина, ветчина, кура, пепперони, помидоры, шампиньоны, огурцы маринованные, лук красныйТесто, пицца соус, сыр моцарелла, свинина, ветчина, кура, пепперони, помидоры, шампиньоны, огурцы маринованные, лук красныйТесто, пицца соус, сыр моцарелла, свинина, ветчина, кура, пепперони, помидоры, шампиньоны, огурцы маринованные, лук красный Тесто, пицца соус, сыр моцарелла, свинина, ветчина, кура, пепперони, помидоры, шампиньоны, огурцы маринованные, лук красныйТесто, пицца соус, сыр моцарелла, свинина, ветчина, кура, пепперони, помидоры, шампиньоны, огурцы маринованные, лук красныйТесто, пицца соус, сыр моцарелла, свинина, ветчина, кура, пепперони, помидоры, шампиньоны, огурцы маринованные, лук красный Тесто, пицца соус, сыр моцарелла, свинина, ветчина, кура, пепперони, помидоры, шампиньоны, огурцы маринованные, лук красныйТесто, пицца соус, сыр моцарелла, свинина, ветчина, кура, пепперони, помидоры, шампиньоны, огурцы маринованные, лук красный
  static let cardProductFakeDescription = L10n.tr("Localizable", "card-product-fake-description")
  /// %@ г\n%@ кКал/100 г
  static func cardProductInfo(_ p1: String, _ p2: String) -> String {
    return L10n.tr("Localizable", "card-product-info", p1, p2)
  }
  /// %@ ₽
  static func cardProductPrice(_ p1: String) -> String {
    return L10n.tr("Localizable", "card-product-price", p1)
  }
  /// К РЕСТОРАНАМ
  static let cartButtonTitle = L10n.tr("Localizable", "cart-button-title")
  /// Очистить
  static let cartClearTitle = L10n.tr("Localizable", "cart-clear-title")
  /// ОФОРМИТЬ
  static let cartConfirmButtonTitle = L10n.tr("Localizable", "cart-confirm-button-title")
  /// Какой-то текст
  static let cartEmptyMessage = L10n.tr("Localizable", "cart-empty-message")
  /// Корзина пуста
  static let cartEmptyTitle = L10n.tr("Localizable", "cart-empty-title")
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
  /// Обновить
  static let indicationButtonReload = L10n.tr("Localizable", "indication-button-reload")
  /// Что-то пошло не так
  static let indicationTitleError = L10n.tr("Localizable", "indication-title-error")
  /// Загружается...
  static let indicationTitleLoading = L10n.tr("Localizable", "indication-title-loading")
  /// Бронь № %@
  static func myOrdersBooking(_ p1: String) -> String {
    return L10n.tr("Localizable", "my-orders-booking", p1)
  }
  /// Текущие
  static let myOrdersCurrent = L10n.tr("Localizable", "my-orders-current")
  /// Самовывоз № %@
  static func myOrdersExport(_ p1: String) -> String {
    return L10n.tr("Localizable", "my-orders-export", p1)
  }
  /// в %@
  static func myOrdersInTime(_ p1: String) -> String {
    return L10n.tr("Localizable", "my-orders-in-time", p1)
  }
  /// Мои заказы
  static let myOrdersMainTitle = L10n.tr("Localizable", "my-orders-main-title")
  /// на %@
  static func myOrdersOnPersons(_ p1: String) -> String {
    return L10n.tr("Localizable", "my-orders-on-persons", p1)
  }
  /// Прошедшие
  static let myOrdersPast = L10n.tr("Localizable", "my-orders-past")
  /// %@ ₽
  static func myOrdersPrice(_ p1: String) -> String {
    return L10n.tr("Localizable", "my-orders-price", p1)
  }
  /// Сегодня
  static let myOrdersToday = L10n.tr("Localizable", "my-orders-today")
  /// Завтра
  static let myOrdersTomorrow = L10n.tr("Localizable", "my-orders-tomorrow")
  /// Предстоящие
  static let myOrdersUpcoming = L10n.tr("Localizable", "my-orders-upcoming")
  /// Подтверждение
  static let newPasswordConfirmPlaceholder = L10n.tr("Localizable", "newPassword-confirm-placeholder")
  /// Новый пароль
  static let newPasswordPasswordPlaceholder = L10n.tr("Localizable", "newPassword-password-placeholder")
  /// Готово
  static let newPasswordReadyButtonText = L10n.tr("Localizable", "newPassword-ready-button-text")
  /// Новый пароль
  static let newPasswordTitleText = L10n.tr("Localizable", "newPassword-title-text")
  /// На указанный номер телефона будет\nотправлено сообщение с кодом\nподтврждения
  static let phoneInfoText = L10n.tr("Localizable", "phone-info-text")
  /// Далее
  static let phoneNextButtonText = L10n.tr("Localizable", "phone-next-button-text")
  /// Ваш номер
  static let phonePhonePlaceholder = L10n.tr("Localizable", "phone-phone-placeholder")
  /// Номер телефона
  static let phoneTitleText = L10n.tr("Localizable", "phone-title-text")
  /// Для открытия камеры необходимо разрешить доступ в настройках
  static let profileCameraAccessDenied = L10n.tr("Localizable", "profile-camera-access-denied")
  /// Камера
  static let profileCameraTitle = L10n.tr("Localizable", "profile-camera-title")
  /// Отмена
  static let profileCancelTitle = L10n.tr("Localizable", "profile-cancel-title")
  /// Ваш регион
  static let profileCityPlaceholder = L10n.tr("Localizable", "profile-city-placeholder")
  /// Город не может быть пустым
  static let profileCityValidationText = L10n.tr("Localizable", "profile-city-validation-text")
  /// Электронная почта
  static let profileEmailPlaceholder = L10n.tr("Localizable", "profile-email-placeholder")
  /// Некорректный email
  static let profileEmailValidationText = L10n.tr("Localizable", "profile-email-validation-text")
  /// Для открытия галереи необходимо разрешить доступ в настройках
  static let profileGalleryAccessDenied = L10n.tr("Localizable", "profile-gallery-access-denied")
  /// Галерея
  static let profileGalleryTitle = L10n.tr("Localizable", "profile-gallery-title")
  /// Ваш регион
  static let profileInfoCityPlaceholder = L10n.tr("Localizable", "profile-info-city-placeholder")
  /// E-mail
  static let profileInfoEmailPlaceholder = L10n.tr("Localizable", "profile-info-email-placeholder")
  /// Имя
  static let profileInfoNamePlaceholder = L10n.tr("Localizable", "profile-info-name-placeholder")
  /// Телефон
  static let profileInfoPhonePlaceholder = L10n.tr("Localizable", "profile-info-phone-placeholder")
  /// Введите
  static let profileInfoPrePlaceholder = L10n.tr("Localizable", "profile-info-pre-placeholder")
  /// Имя
  static let profileNamePlaceholder = L10n.tr("Localizable", "profile-name-placeholder")
  /// Некорректное имя
  static let profileNameValidationText = L10n.tr("Localizable", "profile-name-validation-text")
  /// Телефон
  static let profilePhonePlaceholder = L10n.tr("Localizable", "profile-phone-placeholder")
  /// Некорректный номер
  static let profilePhoneValidationText = L10n.tr("Localizable", "profile-phone-validation-text")
  /// Получать push-уведомления
  static let profilePushNotificationsPlaceholder = L10n.tr("Localizable", "profile-push-notifications-placeholder")
  /// Удалить
  static let profileRemoveTitle = L10n.tr("Localizable", "profile-remove-title")
  /// СОХРАНИТЬ
  static let profileSaveButtonTitle = L10n.tr("Localizable", "profile-save-button-title")
  /// Настройки
  static let profileSettingsTitle = L10n.tr("Localizable", "profile-settings-title")
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
  /// ДАЛЕЕ
  static let regionButtonTitle = L10n.tr("Localizable", "region-button-title")
  /// ВЫБРАТЬ
  static let regionChooseButtonTitle = L10n.tr("Localizable", "region-choose-button-title")
  /// Укажите ваше место расположения, от этого зависит список ресторанов.
  static let regionMainDescription = L10n.tr("Localizable", "region-main-description")
  /// Ваш регион
  static let regionMainTitle = L10n.tr("Localizable", "region-main-title")
  /// Добавить
  static let restaurantFavoriteButtonTitle = L10n.tr("Localizable", "restaurant-favorite-button-title")
  /// Любимые блюда
  static let restaurantFavoriteMealsTitle = L10n.tr("Localizable", "restaurant-favorite-meals-title")
  /// Меню ресторана
  static let restaurantMenuTitle = L10n.tr("Localizable", "restaurant-menu-title")
  /// Минимальная сумма заказа
  static let restaurantPriceTitle = L10n.tr("Localizable", "restaurant-price-title")
  /// Рейтинг ресторана
  static let restaurantRatingTitle = L10n.tr("Localizable", "restaurant-rating-title")
  /// Есть столик
  static let restaurantTableTitleAble = L10n.tr("Localizable", "restaurant-table-title-able")
  /// Проверить столик
  static let restaurantTableTitleCheck = L10n.tr("Localizable", "restaurant-table-title-check")
  /// Только самовывоз
  static let restaurantTableTitlePickup = L10n.tr("Localizable", "restaurant-table-title-pickup")
  /// Вы всегда сможете проверить\nналичие свободных столиков\nв любом из ресторанов
  static let slideFirstDescription = L10n.tr("Localizable", "slide-first-description")
  /// Наличие столиков
  static let slideFirstTitle = L10n.tr("Localizable", "slide-first-title")
  /// Поехали !
  static let slideMainButton = L10n.tr("Localizable", "slide-main-button")
  /// Делайте заказ до того,\nкак прибыли в ресторан,\nэкономьте свое время.
  static let slideSecondDescription = L10n.tr("Localizable", "slide-second-description")
  /// Закажите заранее
  static let slideSecondTitle = L10n.tr("Localizable", "slide-second-title")
  /// Оплачивайте заказ\nчерез приложение.\nЭто удобно и безопасно.
  static let slideThirdDescription = L10n.tr("Localizable", "slide-third-description")
  /// Оплата без рисков
  static let slideThirdTitle = L10n.tr("Localizable", "slide-third-title")
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
  /// Пропустить
  static let slidesNextButtonTitle = L10n.tr("Localizable", "slides-next-button-title")
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
  /// ПРИНИМАЮ
  static let termsButtonTitle = L10n.tr("Localizable", "terms-button-title")
  /// Условия использования
  static let termsMainTitle = L10n.tr("Localizable", "terms-main-title")
}
// swiftlint:enable explicit_type_interface identifier_name line_length nesting type_body_length type_name

extension L10n {
  fileprivate static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
