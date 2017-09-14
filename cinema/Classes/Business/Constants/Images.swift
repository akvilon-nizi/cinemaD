// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSImage
  typealias AssetColorTypeAlias = NSColor
  typealias Image = NSImage
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIImage
  typealias AssetColorTypeAlias = UIColor
  typealias Image = UIImage
#endif

// swiftlint:disable file_length

@available(*, deprecated, renamed: "ImageAsset")
typealias AssetType = ImageAsset

struct ImageAsset {
  fileprivate var name: String

  var image: Image {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    let image = bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else { fatalError("Unable to load image named \(name).") }
    return result
  }
}

struct ColorAsset {
  fileprivate var name: String

  #if swift(>=3.2)
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, OSX 10.13, *)
  var color: AssetColorTypeAlias {
    return AssetColorTypeAlias(asset: self)
  }
  #endif
}

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
enum Asset {
  enum Auth {
    static let authClock = ImageAsset(name: "auth-clock")
    static let authClose = ImageAsset(name: "auth-close")
    static let authConfirmationImage = ImageAsset(name: "auth-confirmation-image")
    static let authImage = ImageAsset(name: "auth-image")
  }
  enum CardProduct {
    static let cardMinus = ImageAsset(name: "card-minus")
    static let cardPlus = ImageAsset(name: "card-plus")
    static let cardProductClose = ImageAsset(name: "card-product-close")
  }
  enum Cart {
    static let cartEmptyPlaceholder = ImageAsset(name: "cart-empty-placeholder")
    static let cartMinus = ImageAsset(name: "cart-minus")
    static let cartPlus = ImageAsset(name: "cart-plus")
  }
  enum Cinema {
    enum Slides {
      static let slide1Image = ImageAsset(name: "slide1-image")
      static let slide2Image = ImageAsset(name: "slide2-image")
      static let slide2Play = ImageAsset(name: "slide2-play")
      static let slide3Image1 = ImageAsset(name: "slide3-image1")
      static let slide3Image2 = ImageAsset(name: "slide3-image2")
      static let slide3Image3 = ImageAsset(name: "slide3-image3")
      static let slide3Image4 = ImageAsset(name: "slide3-image4")
      static let slide3Image5 = ImageAsset(name: "slide3-image5")
    }
  }
  static let fakeRestaurantPhoto = ImageAsset(name: "fake-restaurant-photo")
  enum Indicator {
    static let indicationIconError = ImageAsset(name: "indication-icon-error")
    static let indicationIconLoading = ImageAsset(name: "indication-icon-loading")
  }
  enum Map {
    static let mapButtonMyGeo = ImageAsset(name: "map-button-my-geo")
    static let mapPinIconMyGeo = ImageAsset(name: "map-pin-icon-my-geo")
    static let mapPinIconSelected = ImageAsset(name: "map-pin-icon-selected")
    static let mapPinIcon = ImageAsset(name: "map-pin-icon")
  }
  enum NavBar {
    static let navBarArrowBack = ImageAsset(name: "nav-bar-arrow-back")
    static let navBarList = ImageAsset(name: "nav-bar-list")
    static let navBarLogo = ImageAsset(name: "nav-bar-logo")
    static let navBarMap = ImageAsset(name: "nav-bar-map")
    static let navBarMenu = ImageAsset(name: "nav-bar-menu")
  }
  enum Profile {
    enum Profile {
      static let profileArrow = ImageAsset(name: "profile-arrow")
      static let profileCamera = ImageAsset(name: "profile-camera")
      static let profileEdit = ImageAsset(name: "profile-edit")
      static let profileHeader = ImageAsset(name: "profile-header")
      static let profilePlus = ImageAsset(name: "profile-plus")
    }
    static let profileArrow = ImageAsset(name: "profile-arrow")
    static let profileCamera = ImageAsset(name: "profile-camera")
    static let profileEdit = ImageAsset(name: "profile-edit")
    static let profileHeader = ImageAsset(name: "profile-header")
    static let profilePlus = ImageAsset(name: "profile-plus")
    enum RatingStar {
      static let ratingStarSmall = ImageAsset(name: "rating-star-small")
    }
    enum Region {
      static let regionCheckImage = ImageAsset(name: "region-check-image")
      static let regionMainImage = ImageAsset(name: "region-main-image")
    }
    enum Restaurant {
      static let restaurantInfoRatingStar = ImageAsset(name: "restaurant-info-rating-star")
      static let restaurantMenuArrow = ImageAsset(name: "restaurant-menu-arrow")
      static let restaurantMenuCart = ImageAsset(name: "restaurant-menu-cart")
      static let restaurantSpinner = ImageAsset(name: "restaurant-spinner")
    }
    enum Slide {
      static let slideImageFirst = ImageAsset(name: "slide-image-first")
      static let slideImageSecond = ImageAsset(name: "slide-image-second")
      static let slideImageThird = ImageAsset(name: "slide-image-third")
    }
  }
  enum RatingStar {
    static let ratingStarSmall = ImageAsset(name: "rating-star-small")
  }
  enum Region {
    static let regionCheckImage = ImageAsset(name: "region-check-image")
    static let regionMainImage = ImageAsset(name: "region-main-image")
  }
  enum Restaurant {
    static let restaurantInfoRatingStar = ImageAsset(name: "restaurant-info-rating-star")
    static let restaurantMenuArrow = ImageAsset(name: "restaurant-menu-arrow")
    static let restaurantMenuCart = ImageAsset(name: "restaurant-menu-cart")
    static let restaurantSpinner = ImageAsset(name: "restaurant-spinner")
  }
  enum Slide {
    static let slideImageFirst = ImageAsset(name: "slide-image-first")
    static let slideImageSecond = ImageAsset(name: "slide-image-second")
    static let slideImageThird = ImageAsset(name: "slide-image-third")
  }

  // swiftlint:disable trailing_comma
  static let allColors: [ColorAsset] = [
  ]
  static let allImages: [ImageAsset] = [
    Auth.authClock,
    Auth.authClose,
    Auth.authConfirmationImage,
    Auth.authImage,
    CardProduct.cardMinus,
    CardProduct.cardPlus,
    CardProduct.cardProductClose,
    Cart.cartEmptyPlaceholder,
    Cart.cartMinus,
    Cart.cartPlus,
    Cinema.Slides.slide1Image,
    Cinema.Slides.slide2Image,
    Cinema.Slides.slide2Play,
    Cinema.Slides.slide3Image1,
    Cinema.Slides.slide3Image2,
    Cinema.Slides.slide3Image3,
    Cinema.Slides.slide3Image4,
    Cinema.Slides.slide3Image5,
    fakeRestaurantPhoto,
    Indicator.indicationIconError,
    Indicator.indicationIconLoading,
    Map.mapButtonMyGeo,
    Map.mapPinIconMyGeo,
    Map.mapPinIconSelected,
    Map.mapPinIcon,
    NavBar.navBarArrowBack,
    NavBar.navBarList,
    NavBar.navBarLogo,
    NavBar.navBarMap,
    NavBar.navBarMenu,
    Profile.Profile.profileArrow,
    Profile.Profile.profileCamera,
    Profile.Profile.profileEdit,
    Profile.Profile.profileHeader,
    Profile.Profile.profilePlus,
    Profile.profileArrow,
    Profile.profileCamera,
    Profile.profileEdit,
    Profile.profileHeader,
    Profile.profilePlus,
    Profile.RatingStar.ratingStarSmall,
    Profile.Region.regionCheckImage,
    Profile.Region.regionMainImage,
    Profile.Restaurant.restaurantInfoRatingStar,
    Profile.Restaurant.restaurantMenuArrow,
    Profile.Restaurant.restaurantMenuCart,
    Profile.Restaurant.restaurantSpinner,
    Profile.Slide.slideImageFirst,
    Profile.Slide.slideImageSecond,
    Profile.Slide.slideImageThird,
    RatingStar.ratingStarSmall,
    Region.regionCheckImage,
    Region.regionMainImage,
    Restaurant.restaurantInfoRatingStar,
    Restaurant.restaurantMenuArrow,
    Restaurant.restaurantMenuCart,
    Restaurant.restaurantSpinner,
    Slide.slideImageFirst,
    Slide.slideImageSecond,
    Slide.slideImageThird,
  ]
  // swiftlint:enable trailing_comma
  @available(*, deprecated, renamed: "allImages")
  static let allValues: [AssetType] = allImages
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

extension Image {
  @available(iOS 1.0, tvOS 1.0, watchOS 1.0, *)
  @available(OSX, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init!(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = Bundle(for: BundleToken.self)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(OSX) || os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

extension AssetColorTypeAlias {
  #if swift(>=3.2)
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, OSX 10.13, *)
  convenience init!(asset: ColorAsset) {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    self.init(named: asset.name, bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
  #endif
}

private final class BundleToken {}
