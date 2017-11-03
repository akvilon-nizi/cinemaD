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

// swiftlint:disable superfluous_disable_command
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
  enum Kinobase {
    static let check = ImageAsset(name: "check")
    static let checkMini = ImageAsset(name: "checkMini")
    static let forward = ImageAsset(name: "forward")
    static let remove = ImageAsset(name: "remove")
    static let settings = ImageAsset(name: "settings")
    static let settingsUnselect = ImageAsset(name: "settingsUnselect")

  }
  enum Cinema {
    static let aqqa = ImageAsset(name: "aqqa")
    static let assa = ImageAsset(name: "assa")
    static let background = ImageAsset(name: "background")
    enum MainTab {
      static let chat = ImageAsset(name: "chat")
      static let kinobase = ImageAsset(name: "kinobase")
      static let reward = ImageAsset(name: "reward")
      static let tabBackground = ImageAsset(name: "tabBackground")
      static let tickets = ImageAsset(name: "tickets")
    }
    enum MainView {
      static let isClose = ImageAsset(name: "isClose")
      static let isOpen = ImageAsset(name: "isOpen")
    }
    static let play = ImageAsset(name: "play")
    static let selectStar = ImageAsset(name: "selectStar")
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
    static let unselectStar = ImageAsset(name: "unselectStar")
  }
  enum NavBar {
    static let navBarArrowBack = ImageAsset(name: "nav-bar-arrow-back")
    static let navBarList = ImageAsset(name: "nav-bar-list")
    static let navBarLogo = ImageAsset(name: "nav-bar-logo")
    static let navBarMap = ImageAsset(name: "nav-bar-map")
    static let navBarMenu = ImageAsset(name: "nav-bar-menu")
  }
  enum Search {
    static let search = ImageAsset(name: "search")
    static let type = ImageAsset(name: "type")
  }
  enum StartViews {
    static let auth = ImageAsset(name: "auth")
    enum Confirmation {
      static let lock = ImageAsset(name: "lock")
    }
    enum Help {
      static let phone = ImageAsset(name: "phone")
      static let post = ImageAsset(name: "post")
    }
    enum Start {
      static let background = ImageAsset(name: "background")
      static let forma = ImageAsset(name: "forma")
      static let shape = ImageAsset(name: "shape")
    }
  }

  // swiftlint:disable trailing_comma
  static let allColors: [ColorAsset] = [
  ]
  static let allImages: [ImageAsset] = [
    Kinobase.check,
    Kinobase.checkMini,
    Kinobase.forward,
    Kinobase.remove,
    Kinobase.settings,
    Kinobase.settingsUnselect,
    Cinema.MainTab.chat,
    Cinema.MainTab.kinobase,
    Cinema.MainTab.reward,
    Cinema.MainTab.tabBackground,
    Cinema.MainTab.tickets,
    Cinema.MainView.isClose,
    Cinema.MainView.isOpen,
    Cinema.play,
    Cinema.selectStar,
    Cinema.Slides.slide1Image,
    Cinema.Slides.slide2Image,
    Cinema.Slides.slide2Play,
    Cinema.Slides.slide3Image1,
    Cinema.Slides.slide3Image2,
    Cinema.Slides.slide3Image3,
    Cinema.Slides.slide3Image4,
    Cinema.Slides.slide3Image5,
    Cinema.unselectStar,
    NavBar.navBarArrowBack,
    NavBar.navBarList,
    NavBar.navBarLogo,
    NavBar.navBarMap,
    NavBar.navBarMenu,
    Search.search,
    Search.type,
    StartViews.auth,
    StartViews.Confirmation.lock,
    StartViews.Help.phone,
    StartViews.Help.post,
    StartViews.Start.background,
    StartViews.Start.forma,
    StartViews.Start.shape,
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
