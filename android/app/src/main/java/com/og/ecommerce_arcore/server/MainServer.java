package com.og.ecommerce_arcore.server;

import okhttp3.RequestBody;
import okhttp3.ResponseBody;
import retrofit2.Call;
import retrofit2.http.Multipart;
import retrofit2.http.POST;
import retrofit2.http.Part;

public interface MainServer {

    @Multipart
    @POST("add_user_preference")
    Call<ResponseBody> uploadImage(
            @Part("file\"; filename=\"pp.jpg\" ") RequestBody file,
            @Part("file_name") RequestBody fullName
//            @Part MultipartBody.Part image
    );
}
