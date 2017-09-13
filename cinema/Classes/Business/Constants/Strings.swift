// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable file_length

// swiftlint:disable explicit_type_interface identifier_name line_length nesting type_body_length type_name
enum L10n {
  /// Отменить
  static let alertButtonCancel = L10n.tr("Localizable", "alert-button-cancel")
  /// ОК
  static let alertButtonOk = L10n.tr("Localizable", "alert-button-ok")
  /// Сетевая ошибка
  static let alertTitleNetworkError = L10n.tr("Localizable", "alert-title-network-error")
  /// Системная ошибка
  static let alertTitleSystemError = L10n.tr("Localizable", "alert-title-system-error")
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
  /// Повторить SMS
  static let authResendSms = L10n.tr("Localizable", "auth-resend-sms")
  /// Отправить потворно
  static let authRetrySms = L10n.tr("Localizable", "auth-retry-sms")
  /// Авторизируйтесь
  static let authTitle = L10n.tr("Localizable", "auth-title")
  /// Через %@
  static func authWaitTitle(_ p1: String) -> String {
    return L10n.tr("Localizable", "auth-wait-title", p1)
  }
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
  /// Делайте заказ до того,\nкак прибыли в ресторан,\nэкономьте свое время.
  static let slideSecondDescription = L10n.tr("Localizable", "slide-second-description")
  /// Закажите заранее
  static let slideSecondTitle = L10n.tr("Localizable", "slide-second-title")
  /// Оплачивайте заказ\nчерез приложение.\nЭто удобно и безопасно.
  static let slideThirdDescription = L10n.tr("Localizable", "slide-third-description")
  /// Оплата без рисков
  static let slideThirdTitle = L10n.tr("Localizable", "slide-third-title")
  /// Пропустить
  static let slidesNextButtonTitle = L10n.tr("Localizable", "slides-next-button-title")
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
