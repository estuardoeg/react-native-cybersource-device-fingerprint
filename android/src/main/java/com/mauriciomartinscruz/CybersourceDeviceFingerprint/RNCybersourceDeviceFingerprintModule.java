
package com.mauriciomartinscruz.CybersourceDeviceFingerprint;

import android.app.Application;

import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableArray;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.bridge.WritableNativeMap;
import com.threatmetrix.TrustDefender.TMXProfiling;
import com.threatmetrix.TrustDefender.TMXConfig;
import com.threatmetrix.TrustDefender.TMXStatusCode;
import com.threatmetrix.TrustDefender.TMXProfilingOptions;
import com.threatmetrix.TrustDefender.TMXEndNotifier;
import com.threatmetrix.TrustDefender.TMXProfilingHandle.Result;

import java.util.ArrayList;
import java.util.List;


public class RNCybersourceDeviceFingerprintModule extends ReactContextBaseJavaModule {

    private static final String CYBERSOURCE_SDK = "RNCybersourceDeviceFingerprint";
    private TMXProfiling _defender = null;

    public RNCybersourceDeviceFingerprintModule(ReactApplicationContext reactContext) {
        super(reactContext);
    }

    @Override
    public String getName() {
        return CYBERSOURCE_SDK;
    }

    @ReactMethod
    public void configure(final String orgId, final Promise promise) {
        if (_defender != null) {
            promise.reject(CYBERSOURCE_SDK, "CyberSource SDK is already initialised");
            return;
        }

        _defender = TMXProfiling.getInstance();

        try {
            TMXConfig config = new TMXConfig()
                    .setOrgId(orgId)
                    .setContext(getReactApplicationContext());
            _defender.init(config);
        } catch (IllegalArgumentException exception) {
            promise.reject(CYBERSOURCE_SDK, "Invalid parameters");
        }
        promise.resolve(true);
    }

    @ReactMethod
    public void getSessionID(final ReadableArray attributes, final Promise promise) {
        if (_defender == null) {
            promise.reject(CYBERSOURCE_SDK, "CyberSource SDK is not yet initialised");
            return;
        }

        List<String> list = new ArrayList<>();

        int leni = attributes.size();
        for (int i = 0; i < leni; ++i) {
            String value = attributes.getString(i);
            if (value != null) {
                list.add(value);
            }
        }

        TMXProfilingOptions options = new TMXProfilingOptions().setCustomAttributes(list);
        TMXProfiling.getInstance().profile(options, new CompletionNotifier(promise));
    }

    private class CompletionNotifier implements TMXEndNotifier {
        private final Promise _promise;

        CompletionNotifier(Promise promise) {
            super();
            _promise = promise;
        }

        @Override
        public void complete(Result result) {
            WritableMap map = new WritableNativeMap();
            map.putString("sessionId", result.getSessionID());
            map.putInt("status", result.getStatus().ordinal());
            _promise.resolve(map);
        }
    }

}
