import Flutter
import UIKit
import MapKit

class NativeTurnByTurnNavFactory: NSObject, FlutterPlatformViewFactory {
  private var messenger: FlutterBinaryMessenger

  init(messenger: FlutterBinaryMessenger) {
    self.messenger = messenger
    super.init()
  }

  func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
    return NativeTurnByTurnNav(frame: frame, viewId: viewId, messenger: messenger, args: args)
  }
}

class NativeTurnByTurnNav: NSObject, FlutterPlatformView {
  private var mapView: MKMapView

  init(frame: CGRect, viewId: Int64, messenger: FlutterBinaryMessenger, args: Any?) {
    mapView = MKMapView(frame: frame)
    mapView.showsUserLocation = true
    mapView.showsCompass = true
    if let dict = args as? [String: Any],
       let lat = dict["destLat"] as? Double,
       let lng = dict["destLng"] as? Double {
      let dest = CLLocationCoordinate2D(latitude: lat, longitude: lng)
      let annotation = MKPointAnnotation()
      annotation.coordinate = dest
      mapView.addAnnotation(annotation)
      mapView.setRegion(MKCoordinateRegion(center: dest, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)), animated: false)
    }
    super.init()
  }

  func view() -> UIView {
    return mapView
  }
}
