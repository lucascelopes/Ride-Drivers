<?xml version="1.0" encoding="utf-8"?>
<FrameLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:id="@+id/root"
    android:layout_width="match_parent"
    android:layout_height="match_parent">

    <fragment
        android:id="@+id/map"
        android:name="com.google.android.gms.maps.SupportMapFragment"
        android:layout_width="match_parent"
        android:layout_height="match_parent"/>

    <!-- HUD -->
    <LinearLayout
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:orientation="horizontal"
        android:padding="12dp"
        android:gravity="center_vertical"
        android:background="#99000000">

        <ImageView
            android:layout_width="20dp"
            android:layout_height="20dp"
            android:src="@android:drawable/ic_dialog_map"
            android:tint="@android:color/white"/>

        <TextView
            android:id="@+id/tvStatus"
            android:layout_width="0dp"
            android:layout_height="wrap_content"
            android:layout_weight="1"
            android:textColor="@android:color/white"
            android:textSize="14sp"
            android:paddingStart="10dp"
            android:text="Inicializando..." />

        <ImageButton
            android:id="@+id/btnOverview"
            android:layout_width="40dp"
            android:layout_height="40dp"
            android:background="@android:color/transparent"
            android:src="@android:drawable/ic_menu_mapmode"
            android:tint="@android:color/white"/>

        <ImageButton
            android:id="@+id/btnCenter"
            android:layout_width="40dp"
            android:layout_height="40dp"
            android:background="@android:color/transparent"
            android:src="@android:drawable/ic_menu_mylocation"
            android:tint="@android:color/white"/>
    </LinearLayout>

    <com.google.android.material.floatingactionbutton.FloatingActionButton
        android:id="@+id/fabNav"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_margin="16dp"
        android:src="@android:drawable/ic_dialog_info"
        android:tint="@android:color/white"
        android:layout_gravity="bottom|end"
        android:contentDescription="Navegar"/>

</FrameLayout>
