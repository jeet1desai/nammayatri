package in.juspay.mobility;

import static android.app.Activity.RESULT_OK;

import static in.juspay.mobility.BuildConfig.MERCHANT_TYPE;
import static in.juspay.mobility.common.MobilityCommonBridge.isClassAvailable;

import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.util.Log;

import androidx.activity.result.ActivityResult;
import androidx.activity.result.ActivityResultLauncher;

import com.google.android.play.core.splitinstall.SplitInstallManager;
import com.google.android.play.core.splitinstall.SplitInstallManagerFactory;
import com.google.android.play.core.splitinstall.SplitInstallRequest;
import com.google.android.play.core.splitinstall.SplitInstallStateUpdatedListener;
import com.google.android.play.core.splitinstall.model.SplitInstallErrorCode;
import com.google.android.play.core.splitinstall.model.SplitInstallSessionStatus;
import com.google.firebase.crashlytics.FirebaseCrashlytics;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.UUID;

import in.juspay.hypersdk.core.PaymentConstants;
import in.juspay.hypersdk.data.KeyValueStore;
import in.juspay.services.HyperServices;

public class Utils {

    public static void onGullakEvent(JSONObject jsonObject, Context context, SharedPreferences sharedPref, ActivityResultLauncher<Intent> activityResultLauncher){
        if (!isClassAvailable("in.juspay.mobility.dynamicfeature.DynamicActivity")) return;
        try {
            if (jsonObject.has("action") && jsonObject.has("innerPayload")) {
                JSONObject innerPayload = new JSONObject(jsonObject.getString("innerPayload"));
                String token = innerPayload.getString("param1");
                String cbIdentifier = jsonObject.getString("action");
                boolean installOnly = innerPayload.getString("param2").equals("true");
                if (sharedPref != null && sharedPref.getBoolean("GLSDK_INSTALLED", false) && !installOnly){
                    Intent intent = new Intent();
                    intent.putExtra("token", token);
                    intent.putExtra("cbIdentifier", cbIdentifier);
                    intent.setClassName(context.getPackageName(), "in.juspay.mobility.dynamicfeature.DynamicActivity");
                    activityResultLauncher.launch(intent);
                }else {
                    initGlSdk(cbIdentifier,token, installOnly, context, activityResultLauncher, sharedPref);
                }
            }
        } catch (Exception exception) {
            FirebaseCrashlytics.getInstance().recordException(exception);
            exception.printStackTrace();
        }
    }


    public static void handleGlResp(ActivityResult result, HyperServices hyperServices, Context context){
        if (result.getResultCode() == RESULT_OK) {
            Intent data = result.getData();
            if (data != null) {
                String responseJson = data.getStringExtra("responseJson"); // Parse the string response to a java class
                String cbIdentifier = data.getStringExtra("cbIdentifier");
                try {
                    JSONObject processPL = new JSONObject();
                    JSONObject innerPayload = getInnerPayload(new JSONObject(),"gl_process", context);
                    innerPayload.put("callback", cbIdentifier)
                            .put("value", responseJson);
                    processPL.put(PaymentConstants.PAYLOAD, innerPayload)
                            .put("requestId", UUID.randomUUID())
                            .put("service", getService());
                    hyperServices.process(processPL);
                } catch (JSONException e) {
                    FirebaseCrashlytics.getInstance().recordException(e);
                }
            }
        }
    }

    public static String getService() {
        if (MERCHANT_TYPE.equals("USER")) {
            return "in.yatri.consumer";
        } else {
            return "in.yatri.provider";
        }
    }

    public static JSONObject getInnerPayload(JSONObject payload, String action, Context context) throws JSONException{
        String appName = "";
        boolean loadDynamicModule = BuildConfig.includeDynamicFeature && isClassAvailable("in.juspay.mobility.dynamicfeature.DynamicActivity");
        try{
            appName = context.getApplicationInfo().loadLabel(context.getPackageManager()).toString();
        }catch (Exception e){
            e.printStackTrace();
        }
        payload.put("clientId", context.getResources().getString(R.string.client_id));
        payload.put("merchantId", context.getResources().getString(R.string.merchant_id));
        payload.put("appName", appName);
        payload.put("action", action);
        payload.put("logLevel",1);
        payload.put("isBootable",true);
        payload.put(PaymentConstants.ENV, "prod");
        int bundleTimeOut = Integer.parseInt(KeyValueStore.read(context,context.getString(in.juspay.mobility.app.R.string.preference_file_key),"BUNDLE_TIME_OUT","500"));
        payload.put("bundleTimeOut",bundleTimeOut);
        payload.put("loadDynamicModule", loadDynamicModule);
        return payload;
    }

    public static void initGlSdk(String cbIdentifier, String token, boolean installOnly, Context context, ActivityResultLauncher<Intent> activityResultLauncher, SharedPreferences sharedPref){
        SplitInstallManager splitInstallManager =
                SplitInstallManagerFactory.create(context);


// Creates a request to install a module.
        SplitInstallRequest request =
                SplitInstallRequest
                        .newBuilder()
                        .addModule("dynamicfeature")
                        .build();

// Initializes a variable to later track the session ID for a given request.
        int mSessionId = 0;

// Creates a listener for request status updates.
        SplitInstallStateUpdatedListener listener = state -> {
            if (state.sessionId() == mSessionId) {
                // Read the status of the request to handle the state update.
                if (state.status() == SplitInstallSessionStatus.FAILED
                        && state.errorCode() == SplitInstallErrorCode.SERVICE_DIED) {
                    // Retry the request.
                    return;
                }
                if (state.sessionId() == mSessionId) {
                    switch (state.status()) {
                        case SplitInstallSessionStatus.DOWNLOADING:
                            long totalBytes = state.totalBytesToDownload();
                            long progress = state.bytesDownloaded();
                            // Update progress bar.
                            Log.d("SplitInstallSessionStatus", "totalbytes->"+totalBytes+" progress->"+progress);
                            break;

                        case SplitInstallSessionStatus.INSTALLED:
                            if (sharedPref!= null) sharedPref.edit().putBoolean("GLSDK_INSTALLED", true).apply();
                            if (!installOnly){
                                Intent intent = new Intent();
                                intent.putExtra("token", token);
                                intent.setClassName(context.getPackageName(), "in.juspay.mobility.dynamicfeature.DynamicActivity");
                                intent.putExtra("cbIdentifier", cbIdentifier);
                                activityResultLauncher.launch(intent);
                            }
                            break;
                    }
                }
            }
        };

        // Registers the listener.
        splitInstallManager.registerListener(listener);
        splitInstallManager
                .startInstall(request)
                .addOnSuccessListener(sessionId -> Log.d("successSessionId", "" + sessionId))
                .addOnFailureListener(exception -> FirebaseCrashlytics.getInstance().recordException(exception));
    }
}
