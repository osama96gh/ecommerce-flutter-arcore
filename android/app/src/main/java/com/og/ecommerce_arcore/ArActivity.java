package com.og.ecommerce_arcore;


import android.app.Activity;
import android.app.ActivityManager;
import android.content.Context;
import android.content.Intent;
import android.media.Image;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.util.Log;
import android.view.Gravity;
import android.view.MotionEvent;
import android.view.View;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

import com.google.ar.core.Anchor;
import com.google.ar.core.HitResult;
import com.google.ar.core.Plane;
import com.google.ar.core.exceptions.NotYetAvailableException;
import com.google.ar.sceneform.AnchorNode;
import com.google.ar.sceneform.assets.RenderableSource;
import com.google.ar.sceneform.math.Vector3;
import com.google.ar.sceneform.rendering.Color;
import com.google.ar.sceneform.rendering.MaterialFactory;
import com.google.ar.sceneform.rendering.ModelRenderable;
import com.google.ar.sceneform.rendering.ShapeFactory;
import com.google.ar.sceneform.rendering.ViewRenderable;
import com.google.ar.sceneform.ux.ArFragment;
import com.google.ar.sceneform.ux.TransformableNode;
import com.og.ecommerce_arcore.server.MainServer;

import java.io.File;
import java.io.IOException;
import java.util.concurrent.TimeUnit;

import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.RequestBody;
import okhttp3.ResponseBody;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;
import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;

public class ArActivity extends AppCompatActivity {

    private static final String TAG = ArActivity.class.getSimpleName();
    private static final double MIN_OPENGL_VERSION = 3.0;

    private ArFragment arFragment;
    private ModelRenderable andyRenderable;
    private ViewRenderable controllRenderable;
    private ModelRenderable redSphereRenderable;
    private static String GLTF_ASSET;
    float rl = 0;

    private final SolarSettings solarSettings = new SolarSettings();

    String url, title;
    ModelType modelType;
    TransformableNode layoutNode;

    public static boolean checkIsSupportedDeviceOrFinish(final Activity activity) {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.N) {
            Log.e(TAG, "Sceneform requires Android N or later");
            Toast.makeText(activity, "Sceneform requires Android N or later", Toast.LENGTH_LONG).show();
            activity.finish();
            return false;
        }
        String openGlVersionString =
                ((ActivityManager) activity.getSystemService(Context.ACTIVITY_SERVICE))
                        .getDeviceConfigurationInfo()
                        .getGlEsVersion();
        if (Double.parseDouble(openGlVersionString) < MIN_OPENGL_VERSION) {
            Log.e(TAG, "Sceneform requires OpenGL ES 3.0 later");
            Toast.makeText(activity, "Sceneform requires OpenGL ES 3.0 or later", Toast.LENGTH_LONG)
                    .show();
            activity.finish();
            return false;
        }
        return true;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);


        if (!checkIsSupportedDeviceOrFinish(this)) {
            return;
        }

        setContentView(R.layout.activity_ar);
        Intent intent = getIntent();
        title = intent.getStringExtra("title");
        url = intent.getStringExtra("url");
        modelType = ModelType.values()[intent.getIntExtra("type", 1)];


        arFragment = (ArFragment) getSupportFragmentManager().findFragmentById(R.id.ux_fragment);
        Log.e(TAG, "onCreate: " + arFragment.getArSceneView().getCameraStreamRenderPriority()
        );
        // When you build a Renderable, Sceneform loads its resources in the background while returning
        // a CompletableFuture. Call thenAccept(), handle(), or check isDone() before calling get().

//
//        ViewRenderable.builder()
//                .setView(this, R.layout.control_view)
//                .build()
//                .thenAccept(renderable -> {
//                    controllRenderable = renderable;
//                });

        MaterialFactory.makeOpaqueWithColor(this, new Color(android.graphics.Color.RED))
                .thenAccept(
                        material -> {
                            redSphereRenderable =
                                    ShapeFactory.makeSphere(0.1f, new Vector3(0.0f, 0.15f, 0.0f), material);
                        });
        arFragment.setOnTapArPlaneListener(
                (HitResult hitResult, Plane plane, MotionEvent motionEvent) -> {
                    if (andyRenderable == null) {
                        Toast.makeText(this, "model not loaded yet!", Toast.LENGTH_SHORT).show();
                        return;
                    }

                    if (arFragment.getArSceneView().getScene().getChildren().size() > 2) {
                        arFragment.getArSceneView().getScene().removeChild(arFragment.getArSceneView().getScene().getChildren().get(arFragment.getArSceneView().getScene().getChildren().size() - 1));
                    }


                    // Create the Anchor.
                    Anchor anchor = hitResult.createAnchor();
                    AnchorNode anchorNode = new AnchorNode(anchor);
                    anchorNode.setParent(arFragment.getArSceneView().getScene());

                    Furniture planet =
                            new Furniture(arFragment, arFragment.getTransformationSystem(),
                                    this, title, 1.0f, 0.0f, 0.03f, andyRenderable, solarSettings);
                    planet.setParent(anchorNode);

//                    // Create the transformable andy and add it to the anchor.
//                    TransformableNode furniture = new TransformableNode(arFragment.getTransformationSystem());
//                    furniture.setParent(anchorNode);
//                    furniture.setRenderable(andyRenderable);
//                    furniture.getScaleController().setEnabled(false);
//                    furniture.setOnTapListener(new Node.OnTapListener() {
//                        @Override
//                        public void onTap(HitTestResult hitTestResult, MotionEvent motionEvent) {
//
//                            if (furniture.getChildren().size() > 1) {
//                                furniture.removeChild(furniture.getChildren().get(1));
//                                Toast.makeText(ArActivity.this, "remove", Toast.LENGTH_SHORT).show();
//
//                                return;
//                            }
//                            Toast.makeText(ArActivity.this, "add", Toast.LENGTH_SHORT).show();
//
//                            TransformableNode layoutNode = new TransformableNode(arFragment.getTransformationSystem());
//                            layoutNode.setParent(furniture);
//                            layoutNode.setRenderable(controllRenderable);
//                            layoutNode.getScaleController().setEnabled(true);
//                            layoutNode.setLocalPosition(new Vector3(0, 0.4f, -0.1f));
//                            Slider rotationS = controllRenderable.getView().findViewById(R.id.rotation_slider);
//                            Slider scaleS = controllRenderable.getView().findViewById(R.id.scale_slider);
//                            Button deleteB = controllRenderable.getView().findViewById(R.id.delete_b);
//                            CheckBox lightingB = controllRenderable.getView().findViewById(R.id.lighting_cb);
//                            lightingB.setChecked(lighting);
//                            rotationS.addOnChangeListener(new Slider.OnChangeListener() {
//                                @Override
//                                public void onValueChange(@NonNull Slider slider, float value, boolean fromUser) {
//                                    furniture.setLocalRotation(Quaternion.eulerAngles(new Vector3(0, value, 0)));
//                                }
//                            });
//
//                            scaleS.addOnChangeListener(new Slider.OnChangeListener() {
//                                @Override
//                                public void onValueChange(@NonNull Slider slider, float value, boolean fromUser) {
//                                    furniture.setLocalScale(new Vector3(value, value, value));
//                                }
//                            });
//
//                            deleteB.setOnClickListener(new View.OnClickListener() {
//                                @Override
//                                public void onClick(View v) {
//                                    anchorNode.removeChild(furniture);
//
//
//                                }
//                            });
//
//                            lightingB.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
//                                @Override
//                                public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
//                                    lighting = isChecked;
//                                    arFragment.getArSceneView().setLightEstimationEnabled(lighting);
//                                    arFragment.getArSceneView().setLightDirectionUpdateEnabled(lighting);
//                                }
//                            });
//
//
//                        }
//                    });
//                    furniture.select();
                });

    }

    MainServer service;

    @Override
    protected void onStart() {
        super.onStart();
        downlaodModel(url, modelType);

        OkHttpClient.Builder okHttpClient = new OkHttpClient().newBuilder()
                .connectTimeout(75, TimeUnit.SECONDS)
                .readTimeout(75, TimeUnit.SECONDS)
                .writeTimeout(75, TimeUnit.SECONDS);

        Retrofit retrofit = new Retrofit.Builder()
                .baseUrl("http://192.168.1.5:9000/")
                .client(okHttpClient.build())
                .addConverterFactory(GsonConverterFactory.create())
                .build();

        service = retrofit.create(MainServer.class);


    }

    Handler handler = new Handler();
    Runnable runnable;
    int delay = 15 * 1000; //Delay for 15 seconds.  One second = 1000 milliseconds.
    boolean isWaiting = false;

    @Override
    protected void onResume() {
        //start handler as activity become visible

        handler.postDelayed(runnable = new Runnable() {
            public void run() {
                if (!isWaiting)
                    getFrame(null);
                //do something
                handler.postDelayed(runnable, delay);
            }
        }, delay);

        super.onResume();
    }

// If onPause() is not included the threads will double up when you
// reload the activity

    @Override
    protected void onPause() {
        handler.removeCallbacks(runnable); //stop handler when activity not visible
        super.onPause();
    }

    void sendImage(File imageFile) {
        isWaiting = true;

        RequestBody fbody = RequestBody.create(MediaType.parse("image/*"), imageFile);

        RequestBody name = RequestBody.create(MediaType.parse("text/plain"), imageFile.getName());

//        RequestBody requestFile =
//                RequestBody.create(MediaType.parse("multipart/form-data"), f);
//
//// MultipartBody.Part is used to send also the actual file name
//        MultipartBody.Part body =
//                MultipartBody.Part.createFormData("user_photo[image]", f.getName(), requestFile);
//
//// add another part within the multipart request
//        String descriptionString = "hello, this is description speaking";
//        RequestBody fullName =
//                RequestBody.create(MediaType.parse("multipart/form-data"), descriptionString);

        Call<ResponseBody> call = service.uploadImage(fbody, name);
        call.enqueue(new Callback<ResponseBody>() {
            @Override
            public void onResponse(Call<ResponseBody> call, Response<ResponseBody> response) {
                isWaiting = false;
                try {
                    Log.e(TAG, "onResponse: " + response.body().string());
                } catch (IOException e) {
                    Log.e(TAG, "onResponse: " + e.getMessage());
                    e.printStackTrace();
                }

            }

            @Override
            public void onFailure(Call<ResponseBody> call, Throwable t) {
                isWaiting = false;
                Log.e(TAG, "onFailure: " + t.getMessage());
            }
        });
    }

//    public static boolean checkIsSupportedDeviceOrFinish(final Activity activity) {
//        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.N) {
//            Log.e(TAG, "Sceneform requires Android N or later");
//            Toast.makeText(activity, "Sceneform requires Android N or later", Toast.LENGTH_LONG).show();
//            activity.finish();
//            return false;
//        }
//        String openGlVersionString =
//                ((ActivityManager) activity.getSystemService(Context.ACTIVITY_SERVICE))
//                        .getDeviceConfigurationInfo()
//                        .getGlEsVersion();
//        if (Double.parseDouble(openGlVersionString) < MIN_OPENGL_VERSION) {
//            Log.e(TAG, "Sceneform requires OpenGL ES 3.0 later");
//            Toast.makeText(activity, "Sceneform requires OpenGL ES 3.0 or later", Toast.LENGTH_LONG)
//                    .show();
//            activity.finish();
//            return false;
//        }
//        return true;
//    }

    public void downlaodModel(String url, ModelType modelType) {

        if (url.trim().isEmpty()) {
            Toast.makeText(this, "model url is empty!", Toast.LENGTH_SHORT).show();
            return;
        }

        boolean isGlb = modelType == ModelType.GLB;

        GLTF_ASSET = url;

        findViewById(R.id.progress_circular).setVisibility(View.VISIBLE);


        ModelRenderable.builder()
                .setSource(this, RenderableSource.builder().setSource(
                        this,
                        Uri.parse(GLTF_ASSET),
                        isGlb ? RenderableSource.SourceType.GLB : RenderableSource.SourceType.GLTF2)
                        .setScale(0.5f)  // Scale the original model to 50%.
                        .setRecenterMode(RenderableSource.RecenterMode.ROOT)
                        .build())
                .setRegistryId(GLTF_ASSET)
                .build()
                .thenAccept(renderable -> {
                    andyRenderable = renderable;
                    findViewById(R.id.progress_circular).setVisibility(View.GONE);

                    Toast.makeText(this, "Loading Done", Toast.LENGTH_SHORT).show();
                })

                .exceptionally(
                        throwable -> {
                            findViewById(R.id.progress_circular).setVisibility(View.GONE);
                            Toast toast =
                                    Toast.makeText(this, "Unable to load andy renderable", Toast.LENGTH_LONG);
                            toast.setGravity(Gravity.CENTER, 0, 0);
                            toast.show();
                            return null;
                        });


    }


    public void getFrame(View view) {
        try {
            Image image = arFragment.getArSceneView().getArFrame().acquireCameraImage();
            byte[] bytesImage = ImageUtils.imageToByteArray(image);
            image.close();
            File fileImage = FileUtils.writeTempFile(ArActivity.this, "temp.jpg", bytesImage);
//            Bitmap bImage = BitmapFactory.decodeFile(fileImage.getAbsolutePath());
//            ((ImageView) findViewById(R.id.image_preview)).setImageBitmap(bImage);
            sendImage(fileImage);
        } catch (NotYetAvailableException e) {
            Log.println(Log.ASSERT, "error", "error:" + e.getMessage());
            e.printStackTrace();
        }
    }
}