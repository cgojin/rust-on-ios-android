package com.gongjin.rustonandroid;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import com.gongjin.rustonandroid.databinding.ActivityMainBinding;

public class MainActivity extends AppCompatActivity {

    // Used to load the 'rustonandroid' library on application startup.
    static {
        System.loadLibrary("rustonandroid");
    }

    private ActivityMainBinding binding;
    private int sum = 0;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        binding = ActivityMainBinding.inflate(getLayoutInflater());
        setContentView(binding.getRoot());

        // Example of a call to a native method
        TextView tv = binding.sampleText;
        tv.setText(stringFromJNI());

        binding.callRust.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                sum = add(sum, 1);
                tv.setText(String.valueOf(sum));
            }
        });
    }

    /**
     * A native method that is implemented by the 'rustonandroid' native library,
     * which is packaged with this application.
     */
    public native String stringFromJNI();
    public native int add(int left, int right);
}