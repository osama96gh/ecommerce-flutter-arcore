package com.og.ecommerce_arcore;

import android.content.Context;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

final class FileUtils {


    public static File writeTempFile(Context context, String fileName, byte[] data) {
        File f = new File(context.getCacheDir(), fileName);


        FileOutputStream fos = null;
        try {
            boolean isNotExistBefore = f.createNewFile();
            fos = new FileOutputStream(f);
            fos.write(data);
            fos.flush();
            fos.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return f;
    }
}
