package com.quicky.ridedriver

import android.content.Context
import android.view.View
import com.google.android.gms.maps.CameraUpdateFactory
import com.google.android.gms.maps.GoogleMap
import com.google.android.gms.maps.MapView
import com.google.android.gms.maps.MapsInitializer
import com.google.android.gms.maps.OnMapReadyCallback
import com.google.android.gms.maps.model.LatLng
import com.google.android.gms.maps.model.MarkerOptions
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import io.flutter.plugin.common.StandardMessageCodec

class NativeTurnByTurnNavFactory : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context, id: Int, args: Any?): PlatformView {
        val params = args as? Map<String, Any>
        return NativeTurnByTurnNav(context, params)
    }
}

class NativeTurnByTurnNav(context: Context, params: Map<String, Any>?) : PlatformView, OnMapReadyCallback {
    private val mapView: MapView = MapView(context)
    private var map: GoogleMap? = null
    private val dest: LatLng? = params?.let {
        val lat = it["destLat"] as? Double
        val lng = it["destLng"] as? Double
        if (lat != null && lng != null) LatLng(lat, lng) else null
    }

    init {
        mapView.onCreate(null)
        mapView.getMapAsync(this)
    }

    override fun getView(): View = mapView

    override fun dispose() {
        mapView.onDestroy()
    }

    override fun onMapReady(googleMap: GoogleMap) {
        MapsInitializer.initialize(mapView.context)
        map = googleMap
        map?.uiSettings?.isCompassEnabled = true
        map?.isMyLocationEnabled = true
        dest?.let {
            map?.addMarker(MarkerOptions().position(it))
            map?.moveCamera(CameraUpdateFactory.newLatLngZoom(it, 15f))
        }
    }
}
