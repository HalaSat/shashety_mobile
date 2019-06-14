package net.halasat.tv;

import android.content.pm.ActivityInfo;
import android.content.res.Configuration;
import android.graphics.Color;
import android.graphics.drawable.Drawable;
import android.net.Uri;
import android.os.Bundle;
import android.view.OrientationEventListener;
import android.view.View;
import android.view.ViewGroup;
import android.view.WindowManager;
import android.widget.FrameLayout;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;
import androidx.core.content.ContextCompat;
import androidx.mediarouter.app.MediaRouteButton;

import com.google.android.exoplayer2.DefaultLoadControl;
import com.google.android.exoplayer2.ExoPlayerFactory;
import com.google.android.exoplayer2.LoadControl;
import com.google.android.exoplayer2.Player;
import com.google.android.exoplayer2.SimpleExoPlayer;
import com.google.android.exoplayer2.ext.cast.CastPlayer;
import com.google.android.exoplayer2.source.MediaSource;
import com.google.android.exoplayer2.source.hls.HlsMediaSource;
import com.google.android.exoplayer2.text.CaptionStyleCompat;
import com.google.android.exoplayer2.trackselection.AdaptiveTrackSelection;
import com.google.android.exoplayer2.trackselection.DefaultTrackSelector;
import com.google.android.exoplayer2.trackselection.TrackSelection;
import com.google.android.exoplayer2.ui.DefaultTimeBar;
import com.google.android.exoplayer2.ui.PlaybackControlView;
import com.google.android.exoplayer2.ui.PlayerView;
import com.google.android.exoplayer2.ui.SubtitleView;
import com.google.android.exoplayer2.upstream.DataSource;
import com.google.android.exoplayer2.upstream.DefaultBandwidthMeter;
import com.google.android.exoplayer2.upstream.DefaultDataSourceFactory;
import com.google.android.exoplayer2.util.Util;
import com.google.android.gms.cast.MediaInfo;
import com.google.android.gms.cast.MediaMetadata;
import com.google.android.gms.cast.MediaQueueItem;
import com.google.android.gms.cast.framework.CastButtonFactory;
import com.google.android.gms.cast.framework.CastContext;
import com.google.android.gms.cast.framework.CastState;
import com.google.android.gms.cast.framework.CastStateListener;
import com.google.android.material.bottomsheet.BottomSheetBehavior;

public class PlayerActivity extends AppCompatActivity {
    private boolean isShowingTrackSelectionDialog;
    private boolean mExoPlayerFullscreen = false;
    private SimpleExoPlayer player;
    private PlayerView simpleExoPlayerView;
    private DefaultTrackSelector trackSelector;
    private Uri videoUri;
    private ImageView mFullScreenIcon;
    private Toolbar mToolbar;
    private MediaRouteButton mediaRouteButton;
    private CastContext castContext;
    private String mediaInfoTitle;
    private ImageView orientation, bottomSheet;
    private LinearLayout bottomSheetLayout;
    private BottomSheetBehavior bottomSheetBehavior;
    private TextView changeQuailty, changeFontSize, textSize,exo_duration,exo_position,text_title;
    private OrientationEventListener orientationEventListener;
    private ImageButton forewordButton, backwardButton;
    private DefaultTimeBar timeBar;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.video_player);
        // Find view by id
        findView();
        // Fullscreen activity
        hideSystemUI();
        // Setup custom toolbar
        setupActionBar();
        // Set title
        setMediaInfoTitle(getIntent().getStringExtra("title"));
        // Set videoUrl
        setVideoUri(getIntent().getStringExtra("videoUrl"));
        text_title.setText(getIntent().getStringExtra("title"));
        // Initialize SimpleExoPlayer
        initializePlayer();
        // Setup setUpMediaRouteButton for casting
        //setUpCasting();
        // Setup media info for casting
        //setUpMediaInfo();
        //initial full screen mode
        initFullscreenDialog();
        initFullscreenButton();
        if (mExoPlayerFullscreen) {
            mFullScreenIcon.setImageDrawable(ContextCompat.getDrawable(PlayerActivity.this, R.drawable.ic_fullscreen_shrink));
        }


        //set bottom sheet
        bottomSheetBehavior = BottomSheetBehavior.from(bottomSheetLayout);
        bottomSheetBehavior.setPeekHeight(0);
        bottomSheet.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                bottomSheetLayout.setVisibility(View.VISIBLE);
                //hide text
                textSize.setVisibility(View.GONE);
                changeFontSize.setText("Font Size");
                changeQuailty.setText("Change Quailty");

                Drawable fontDrawable = getResources().getDrawable(R.drawable.ic_font);
                Drawable quailtyDrawable = getResources().getDrawable(R.drawable.ic_high_quality);
                changeFontSize.setCompoundDrawablesWithIntrinsicBounds(fontDrawable, null, null, null);
                changeQuailty.setCompoundDrawablesWithIntrinsicBounds(quailtyDrawable, null, null, null);


                // set the peek height
                bottomSheetBehavior.setPeekHeight(150);
                bottomSheetBehavior.setState(BottomSheetBehavior.STATE_HALF_EXPANDED);

                // set hideable or not
                bottomSheetBehavior.setHideable(false);

                changeFontSize.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        bottomSheetBehavior.setPeekHeight(0);
                        bottomSheetLayout.setVisibility(View.GONE);
                        changeFontSize();

                    }
                });
                changeQuailty.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        bottomSheetLayout.setVisibility(View.GONE);

                        if (!isShowingTrackSelectionDialog
                                && TrackSelectionDialog.willHaveContent((DefaultTrackSelector) trackSelector)) {
                            isShowingTrackSelectionDialog = true;
                            TrackSelectionDialog trackSelectionDialog =
                                    TrackSelectionDialog.createForTrackSelector(
                                            (DefaultTrackSelector) trackSelector,
                                            /* onDismissListener= */ dismissedDialog -> isShowingTrackSelectionDialog = false);
                            trackSelectionDialog.show(getSupportFragmentManager(), /* tag= */ null);

                        }
                    }
                });
            }
        });


        // set orientation listener
        setOrientationSensor();
        orientation.setOnClickListener(new View.OnClickListener() {
            @Override

            public void onClick(View view) {
                ImageView imageView = (ImageView) view;
                assert (R.id.orientation == imageView.getId());

                // See here
                Integer integer = (Integer) imageView.getTag();
                integer = integer == null ? 0 : integer;

                switch (integer) {
                    case R.drawable.ic_mobile_orientation:
                        imageView.setImageDrawable(ContextCompat.getDrawable(PlayerActivity.this, R.drawable.ic_lock_orientation));
                        imageView.setTag(R.drawable.ic_lock_orientation);
                        int o = getResources().getConfiguration().orientation;
                        if (o == Configuration.ORIENTATION_LANDSCAPE) {
                            setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_LANDSCAPE);
                            orientationEventListener.disable();

                        } else if (o == Configuration.ORIENTATION_PORTRAIT) {
                            setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_PORTRAIT);
                            orientationEventListener.disable();

                        }
                        break;
                    case R.drawable.ic_lock_orientation:
                    default:
                        imageView.setImageDrawable(ContextCompat.getDrawable(PlayerActivity.this, R.drawable.ic_mobile_orientation));
                        imageView.setTag(R.drawable.ic_mobile_orientation);
                        orientationEventListener.enable();
                        break;
                }


            }
        });
        boolean showTV=getIntent().getBooleanExtra("useTvPlayer",false);
        if(showTV){
            hideController();
        }
    }

    private void setOrientationSensor() {
        orientationEventListener = new OrientationEventListener(PlayerActivity.this) {
            @Override
            public void onOrientationChanged(int orientation) {
                if (orientation == ActivityInfo.SCREEN_ORIENTATION_LANDSCAPE) {
                    getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_HIDE_NAVIGATION);
                    getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_FULLSCREEN);
                }
                int epsilon = 10;
                int leftLandscape = 90;
                int rightLandscape = 270;
                if (epsilonCheck(orientation, leftLandscape, epsilon) ||
                        epsilonCheck(orientation, rightLandscape, epsilon)) {
                    PlayerActivity.this.setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_SENSOR);
                }
            }

            private boolean epsilonCheck(int a, int b, int epsilon) {
                return a > b - epsilon && a < b + epsilon;
            }
        };
        orientationEventListener.enable();

    }


    private void initializePlayer() {
        DefaultBandwidthMeter bandwidthMeter = new DefaultBandwidthMeter(); //test

        TrackSelection.Factory videoTrackSelectionFactory = new
                AdaptiveTrackSelection.Factory(bandwidthMeter);

        trackSelector = new DefaultTrackSelector(videoTrackSelectionFactory);
        LoadControl loadControl = new DefaultLoadControl();

        // Set the subtitles
        trackSelector.setParameters(
                trackSelector
                        .buildUponParameters()
                        .setPreferredTextLanguage("ar")
        );

        //  Create the player
        player = ExoPlayerFactory.
                newSimpleInstance(this, trackSelector, loadControl);


        // Produces DataSource instances through which media data is loaded.
        DataSource.Factory dataSourceFactory = new
                DefaultDataSourceFactory(this,
                Util.getUserAgent(this,
                        "exoplayer2example"), bandwidthMeter);


        MediaSource videoSource = new
                HlsMediaSource.Factory(dataSourceFactory).
                createMediaSource(videoUri);

        // Prepare video with sub title
        player.prepare(videoSource);
        // Set the player to view
        simpleExoPlayerView.setPlayer(player);


        // Auto play
        player.setPlayWhenReady(true);
        // Hide navigation bar

        simpleExoPlayerView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (mToolbar.getVisibility() == View.VISIBLE) {
                    mToolbar.setVisibility(View.GONE);
                } else if (mToolbar.getVisibility() == View.GONE || mToolbar.getVisibility() == View.INVISIBLE) {
                    mToolbar.setVisibility(View.VISIBLE);
                }
                if (bottomSheetLayout.getVisibility() == View.VISIBLE) {
                    bottomSheetLayout.setVisibility(View.GONE);
                }
                hideSystemUI();


            }
        });

        changeSubtitleStyle(1);
        player.addListener(new PlayerEventListener());
    }

    @Override
    protected void onPause() {
        super.onPause();
        //If Exo is ready, passing false you will pause the player
        player.setPlayWhenReady(false);

    }


    private void changeFontSize() {
        bottomSheetLayout.setVisibility(View.VISIBLE);
        // set the peek height
        bottomSheetBehavior.setPeekHeight(150);
        bottomSheetBehavior.setState(BottomSheetBehavior.STATE_HALF_EXPANDED);
        // set hideable or not
        bottomSheetBehavior.setHideable(false);
        textSize.setText("Large");
        textSize.setVisibility(View.VISIBLE);
        textSize.setTextSize(15);
        changeFontSize.setTextSize(15);
        changeQuailty.setTextSize(15);
        changeQuailty.setText("small");
        changeQuailty.setCompoundDrawables(null, null, null, null);
        changeFontSize.setText("medium");
        changeFontSize.setCompoundDrawables(null, null, null, null);
        changeQuailty.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                changeSubtitleStyle(1);
                bottomSheetLayout.setVisibility(View.GONE);
            }
        });
        changeFontSize.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                changeSubtitleStyle(2);
                bottomSheetLayout.setVisibility(View.GONE);
            }
        });
        textSize.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                changeSubtitleStyle(3);
                bottomSheetLayout.setVisibility(View.GONE);
            }
        });

    }

    private void setUpCasting() {


        CastButtonFactory.setUpMediaRouteButton(getApplicationContext(), mediaRouteButton);

        castContext = CastContext.getSharedInstance(this);
        if (castContext.getCastState() != CastState.NO_DEVICES_AVAILABLE)
            mediaRouteButton.setVisibility(View.VISIBLE);

        castContext.addCastStateListener(new CastStateListener() {
            @Override
            public void onCastStateChanged(int state) {
                if (state == CastState.NO_DEVICES_AVAILABLE)
                    mediaRouteButton.setVisibility(View.GONE);
                else {
                    if (mediaRouteButton.getVisibility() == View.GONE)
                        mediaRouteButton.setVisibility(View.VISIBLE);
                }
            }
        });
    }

    private void setUpMediaInfo() {
        MediaMetadata movieMetadata = new MediaMetadata(MediaMetadata.MEDIA_TYPE_MOVIE);
        movieMetadata.putString(MediaMetadata.KEY_TITLE, getMediaInfoTitle());
        MediaInfo mediaInfo = new MediaInfo.Builder(videoUri + "")

                .setStreamType(MediaInfo.STREAM_TYPE_BUFFERED)
                .setContentType("video/m3u8")
                .setMetadata(movieMetadata)
                .build();


        final MediaQueueItem[] mediaItems = {new MediaQueueItem.Builder(mediaInfo).build()};

        CastPlayer castPlayer = new CastPlayer(castContext);
        castPlayer.setSessionAvailabilityListener(new CastPlayer.SessionAvailabilityListener() {
            @Override
            public void onCastSessionAvailable() {

                castPlayer.loadItems(mediaItems, 0, 0, Player.REPEAT_MODE_ALL);
            }

            @Override
            public void onCastSessionUnavailable() {
            }
        });
    }

    private void hideSystemUI() {
        // Set the IMMERSIVE flag.
        // Set the content to appear under the system bars so that the content
        // doesn't resize when the system bars hide and show.
        View decorView = getWindow().getDecorView();

        decorView.setSystemUiVisibility(
                View.SYSTEM_UI_FLAG_LAYOUT_STABLE
                        | View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION
                        | View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN
                        | View.SYSTEM_UI_FLAG_HIDE_NAVIGATION // hide nav bar
                        | View.SYSTEM_UI_FLAG_FULLSCREEN // hide status bar
                        | View.SYSTEM_UI_FLAG_IMMERSIVE);


    }


    @Override
    public void onConfigurationChanged(Configuration newConfig) {

        super.onConfigurationChanged(newConfig);

        // Checking the orientation of the screen
        if (newConfig.orientation == Configuration.ORIENTATION_LANDSCAPE) {
            //First Hide other objects (listview or recyclerview), better hide them using Gone.
            FrameLayout.LayoutParams params = (FrameLayout.LayoutParams) simpleExoPlayerView.getLayoutParams();
            params.width = ViewGroup.LayoutParams.MATCH_PARENT;
            params.height = ViewGroup.LayoutParams.MATCH_PARENT;
            simpleExoPlayerView.setLayoutParams(params);
            mToolbar.setVisibility(View.GONE);
            hideSystemUI();
            // Hide status bar
            getWindow().addFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN);
// Show status bar
            getWindow().clearFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN);

        } else if (newConfig.orientation == Configuration.ORIENTATION_PORTRAIT) {
            //unhide your objects here.
            FrameLayout.LayoutParams params = (FrameLayout.LayoutParams) simpleExoPlayerView.getLayoutParams();
            params.width = ViewGroup.LayoutParams.MATCH_PARENT;
            params.height = ViewGroup.LayoutParams.MATCH_PARENT;
            simpleExoPlayerView.setLayoutParams(params);
            mToolbar.setVisibility(View.VISIBLE);
            hideSystemUI();
        }
    }

    public String getMediaInfoTitle() {
        return mediaInfoTitle;
    }

    public void setMediaInfoTitle(String mediaInfoTitle) {
        this.mediaInfoTitle = mediaInfoTitle;
    }

    public void setVideoUri(String videoUri) {
        this.videoUri = Uri.parse(videoUri);
    }

    private void setupActionBar() {


        mToolbar.setVisibility(View.VISIBLE);

        setSupportActionBar(mToolbar);
        getSupportActionBar().setDisplayShowTitleEnabled(false);


    }

    private void findView() {
        mToolbar = findViewById(R.id.app_bar);
        simpleExoPlayerView = findViewById(R.id.exoplayer);
        text_title=mToolbar.findViewById(R.id.text_title);

        PlaybackControlView controlView = simpleExoPlayerView.findViewById(R.id.exo_controller);
        mFullScreenIcon = controlView.findViewById(R.id.exo_fullscreen_icon);
        orientation = mToolbar.findViewById(R.id.orientation);
        bottomSheet = mToolbar.findViewById(R.id.bottom_sheet);
        bottomSheetLayout = findViewById(R.id.bottom_sheet_layout);
        changeFontSize = findViewById(R.id.change_font_size);
        changeQuailty = findViewById(R.id.change_quality);
        textSize = findViewById(R.id.text_size);
        forewordButton=controlView.findViewById(R.id.exo_ffwd);
        backwardButton=controlView.findViewById(R.id.exo_rew);
        timeBar=controlView.findViewById(R.id.exo_progress);
        exo_duration=controlView.findViewById(R.id.exo_duration);
        exo_position=controlView.findViewById(R.id.exo_position);
        mediaRouteButton =  mToolbar.findViewById(R.id.media_route_button);
        //titleText=mToolbar.findViewById(R.id.title_text);

    }

    //initial full screen mode
    private void initFullscreenDialog() {

        if (mExoPlayerFullscreen)
            closeFullscreenDialog();


    }

    @Override
    protected void onResume() {
        super.onResume();
        View decorView = getWindow().getDecorView();
        int uiOptions = View.SYSTEM_UI_FLAG_FULLSCREEN;
        decorView.setSystemUiVisibility(uiOptions);

    }

    private void openFullscreenDialog() {
        mFullScreenIcon.setImageDrawable(ContextCompat.getDrawable(PlayerActivity.this, R.drawable.ic_fullscreen_shrink));
        mExoPlayerFullscreen = true;
        hideSystemUI();
        simpleExoPlayerView.hideController();


        setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_LANDSCAPE);
// Hide status bar
        getWindow().addFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN);
// Show status bar
        getWindow().clearFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN);

    }

    private void closeFullscreenDialog() {

        mExoPlayerFullscreen = false;
        hideSystemUI();
        mFullScreenIcon.setImageDrawable(ContextCompat.getDrawable(PlayerActivity.this, R.drawable.ic_fullscreen_expend));
        setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_PORTRAIT);


    }

    private void initFullscreenButton() {


        mFullScreenIcon.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (!mExoPlayerFullscreen)
                    openFullscreenDialog();
                else
                    closeFullscreenDialog();
            }
        });
    }

    private void changeSubtitleStyle(int fontSize) {
        //FrameLayout.LayoutParams layoutParams = new FrameLayout.LayoutParams(30, 30);
        // simpleExoPlayerView.getSubtitleView().setLayoutParams(layoutParams);
        int defaultSubtitleColor = Color.argb(255, 218, 218, 218);
        int outlineColor = Color.argb(255, 43, 43, 43);
        CaptionStyleCompat style =
                new CaptionStyleCompat(defaultSubtitleColor,
                        Color.TRANSPARENT, Color.TRANSPARENT,
                        CaptionStyleCompat.EDGE_TYPE_OUTLINE,
                        outlineColor, null);
        simpleExoPlayerView.getSubtitleView().setStyle(style);

        simpleExoPlayerView.getSubtitleView().setFractionalTextSize(SubtitleView.DEFAULT_TEXT_SIZE_FRACTION * fontSize);
    }

    // Handle keeping the screen on while playing video
    private class PlayerEventListener implements Player.EventListener {
        @Override
        public void onPlayerStateChanged(boolean playWhenReady, int playbackState) {
            if (playbackState == Player.STATE_IDLE || playbackState == Player.STATE_ENDED || !playWhenReady) {
                simpleExoPlayerView.setKeepScreenOn(false);
            } else {
                simpleExoPlayerView.setKeepScreenOn(true);
            }



        }
    }
    // Hide controller button for TV use
    public void hideController(){
        forewordButton.setImageDrawable(null);
        backwardButton.setImageDrawable(null);
        backwardButton.setEnabled(false);
        forewordButton.setEnabled(false);
        exo_position.setVisibility(View.GONE);
        exo_duration.setVisibility(View.GONE);
        timeBar.setEnabled(false);
        timeBar.setAdMarkerColor(Color.BLACK);
        timeBar.setBufferedColor(Color.BLACK);
        timeBar.setPlayedColor(Color.BLACK);
        timeBar.setPlayedAdMarkerColor(Color.BLACK);
        timeBar.setScrubberColor(Color.BLACK);
        timeBar.setUnplayedColor(Color.BLACK);

    }
}