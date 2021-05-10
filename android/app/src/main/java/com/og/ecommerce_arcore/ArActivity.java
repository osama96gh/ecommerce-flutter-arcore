package com.og.ecommerce_arcore;


import android.os.Bundle;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;

public class ArActivity extends AppCompatActivity {


    String url;
    ModelType modelType;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_ar);

        url = getIntent().getStringExtra("url");
        modelType = ModelType.values()[getIntent().getIntExtra("type", 1)];

        ((TextView) findViewById(R.id.text)).setText(url + (modelType == ModelType.GLB ? "GLB" : "GLTF"));
    }
}