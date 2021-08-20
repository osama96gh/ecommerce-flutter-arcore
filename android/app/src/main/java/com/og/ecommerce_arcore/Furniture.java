/*
 * Copyright 2018 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.og.ecommerce_arcore;

import android.content.Context;
import android.view.MotionEvent;
import android.view.View;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.TextView;

import com.google.ar.sceneform.FrameTime;
import com.google.ar.sceneform.HitTestResult;
import com.google.ar.sceneform.Node;
import com.google.ar.sceneform.math.Quaternion;
import com.google.ar.sceneform.math.Vector3;
import com.google.ar.sceneform.rendering.ModelRenderable;
import com.google.ar.sceneform.rendering.ViewRenderable;
import com.google.ar.sceneform.ux.ArFragment;
import com.google.ar.sceneform.ux.TransformableNode;
import com.google.ar.sceneform.ux.TransformationSystem;

/**
 * Node that represents a planet.
 *
 * <p>The planet creates two child nodes when it is activated:
 *
 * <ul>
 *   <li>The visual of the planet, rotates along it's own axis and renders the planet.
 *   <li>An info card, renders an Android View that displays the name of the planerendt. This can be
 *       toggled on and off.
 * </ul>
 * <p>
 * The planet is rendered by a child instead of this node so that the spinning of the planet doesn't
 * make the info card spin as well.
 */
public class Furniture extends TransformableNode implements Node.OnTapListener {
    private final String furnitureTitle;
    private final float planetScale;
    private final float orbitDegreesPerSecond;
    private final float axisTilt;
    private final ModelRenderable planetRenderable;
    private final SolarSettings solarSettings;

    private TransformableNode infoCard;
    private RotatingNode planetVisual;
    private final Context context;
    TransformationSystem transformationSystem;
    private static final float INFO_CARD_Y_POS_COEFF = 0.55f;
    ArFragment arFragment;

    public Furniture(ArFragment arFragment, TransformationSystem transformationSystem,
                     Context context,
                     String furnitureTitle,
                     float planetScale,
                     float orbitDegreesPerSecond,
                     float axisTilt,
                     ModelRenderable planetRenderable,
                     SolarSettings solarSettings) {
        super(transformationSystem);
        this.transformationSystem = transformationSystem;
        this.context = context;
        this.arFragment = arFragment;
        this.furnitureTitle = furnitureTitle;
        this.planetScale = planetScale;
        this.orbitDegreesPerSecond = orbitDegreesPerSecond;
        this.axisTilt = axisTilt;
        this.planetRenderable = planetRenderable;
        this.solarSettings = solarSettings;
        setOnTapListener(this);
    }

    private ViewRenderable controllRenderable;
    boolean lighting = true;

    @Override
    @SuppressWarnings({"AndroidApiChecker", "FutureReturnValueIgnored"})
    public void onActivate() {

        if (getScene() == null) {
            throw new IllegalStateException("Scene is null!");
        }
        setRenderable(planetRenderable);
        getScaleController().setEnabled(true);


        if (infoCard == null) {
            infoCard = new TransformableNode(transformationSystem);
            infoCard.setParent(this);
            infoCard.setEnabled(false);
            infoCard.setLocalPosition(new Vector3(0.0f, planetScale * INFO_CARD_Y_POS_COEFF, 0.0f));
            infoCard.getScaleController().setEnabled(false);

            ViewRenderable.builder()
                    .setView(context, R.layout.control_view)
                    .build()
                    .thenAccept(renderable -> {
                        infoCard.setRenderable(renderable);
                        controllRenderable = renderable;
//                        Slider rotationS = controllRenderable.getView().findViewById(R.id.rotation_slider);
//                        Slider scaleS = controllRenderable.getView().findViewById(R.id.scale_slider);
                        TextView titleTV = controllRenderable.getView().findViewById(R.id.title_tv);

                        titleTV.setText(furnitureTitle);
                        Button deleteB = controllRenderable.getView().findViewById(R.id.delete_b);
                        CheckBox lightingB = controllRenderable.getView().findViewById(R.id.lighting_cb);
                        lightingB.setChecked(lighting);
//                        rotationS.addOnChangeListener(new Slider.OnChangeListener() {
//                            @Override
//                            public void onValueChange(@NonNull Slider slider, float value, boolean fromUser) {
//                                setLocalRotation(Quaternion.eulerAngles(new Vector3(0, value, 0)));
//                            }
//                        });
//
//                        scaleS.addOnChangeListener(new Slider.OnChangeListener() {
//                            @Override
//                            public void onValueChange(@NonNull Slider slider, float value, boolean fromUser) {
//                                setLocalScale(new Vector3(value, value, value));
//                            }
//                        });

                        deleteB.setOnClickListener(new View.OnClickListener() {
                            @Override
                            public void onClick(View v) {
                                setParent(null);
                            }
                        });

                        lightingB.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
                            @Override
                            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                                lighting = isChecked;
                                arFragment.getArSceneView().setLightEstimationEnabled(lighting);
                                arFragment.getArSceneView().setLightDirectionUpdateEnabled(lighting);
                            }
                        });
                    });
            select();
        }


//        if (planetVisual == null) {
//            // Put a rotator to counter the effects of orbit, and allow the planet orientation to remain
//            // of planets like Uranus (which has high tilt) to keep tilted towards the same direction
//            // wherever it is in its orbit.
//            RotatingNode counterOrbit = new RotatingNode(solarSettings, true, true, 0f);
//            counterOrbit.setDegreesPerSecond(orbitDegreesPerSecond);
//            counterOrbit.setParent(this);
//
//            planetVisual = new RotatingNode(solarSettings, false, false, axisTilt);
//            planetVisual.setParent(counterOrbit);
//            planetVisual.setRenderable(planetRenderable);
//            planetVisual.setLocalScale(new Vector3(planetScale, planetScale, planetScale));
//        }
    }

    @Override
    public void onTap(HitTestResult hitTestResult, MotionEvent motionEvent) {
        if (infoCard == null) {
            return;
        }

        infoCard.setEnabled(!infoCard.isEnabled());
    }

    @Override
    public void onUpdate(FrameTime frameTime) {
        if (infoCard == null) {
            return;
        }

        // Typically, getScene() will never return null because onUpdate() is only called when the node
        // is in the scene.
        // However, if onUpdate is called explicitly or if the node is removed from the scene on a
        // different thread during onUpdate, then getScene may be null.
        if (getScene() == null) {
            return;
        }
        Vector3 cameraPosition = getScene().getCamera().getWorldPosition();
        Vector3 cardPosition = infoCard.getWorldPosition();
        Vector3 direction = Vector3.subtract(cardPosition, cameraPosition);
        direction.y = 0;
        Quaternion lookRotation = Quaternion.lookRotation(direction, Vector3.up());
        infoCard.setWorldRotation(lookRotation);
        infoCard.setWorldScale(new Vector3(0.5f, 0.5f, 0.5f));
    }
}
