package net.halasat.tv;

import android.content.res.Configuration;
import android.net.Uri;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.FrameLayout;

import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;
import androidx.mediarouter.app.MediaRouteButton;

import com.google.android.exoplayer2.DefaultLoadControl;
import com.google.android.exoplayer2.ExoPlayerFactory;
import com.google.android.exoplayer2.LoadControl;
import com.google.android.exoplayer2.Player;
import com.google.android.exoplayer2.SimpleExoPlayer;
import com.google.android.exoplayer2.ext.cast.CastPlayer;
import com.google.android.exoplayer2.source.MediaSource;
import com.google.android.exoplayer2.source.hls.HlsMediaSource;
import com.google.android.exoplayer2.trackselection.AdaptiveTrackSelection;
import com.google.android.exoplayer2.trackselection.DefaultTrackSelector;
import com.google.android.exoplayer2.trackselection.TrackSelection;
import com.google.android.exoplayer2.ui.PlayerView;
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

import com.google.android.gms.cast.framework.CastButtonFactory;
import com.google.android.gms.cast.framework.CastContext;
import com.google.android.gms.cast.framework.CastState;
import com.google.android.gms.cast.framework.CastStateListener;

public class PlayerActivity extends AppCompatActivity {
    private boolean isShowingTrackSelectionDialog;
    private SimpleExoPlayer player;
    private PlayerView simpleExoPlayerView;
    private DefaultTrackSelector trackSelector;
    private Uri videoUri;
    private Uri subtitleUri;

    private Toolbar mToolbar;

    private MediaRouteButton mediaRouteButton;
    private CastContext castContext;

    private MediaSource videoSource;
    private String mediaInfoTitle;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.video_player);

        // Fullscreen activity
        hideSystemUI();

        // Setup custom toolbar
        setupActionBar();

        // Set title
        setMediaInfoTitle(getIntent().getStringExtra("title"));

        // Set videoUrl
        setVideoUri(getIntent().getStringExtra("videoUrl"));

        // Find view by id
        findView();

        // Initialize SimpleExoPlayer
        initializePlayer();

        // Setup setUpMediaRouteButton for casting
        setUpCasting();
        // Setup media info for casting
        setUpMediaInfo();

    }

    private void initializePlayer() {
        DefaultBandwidthMeter bandwidthMeter = new DefaultBandwidthMeter(); // test

        TrackSelection.Factory videoTrackSelectionFactory = new AdaptiveTrackSelection.Factory(bandwidthMeter);

        trackSelector = new DefaultTrackSelector(videoTrackSelectionFactory);
        LoadControl loadControl = new DefaultLoadControl();

        // Set the subtitles
        trackSelector.setParameters(trackSelector.buildUponParameters().setPreferredTextLanguage("ar"));

        // Create the player
        player = ExoPlayerFactory.newSimpleInstance(this, trackSelector, loadControl);

        // Produces DataSource instances through which media data is loaded.
        DataSource.Factory dataSourceFactory = new DefaultDataSourceFactory(this,
                Util.getUserAgent(this, "exoplayer2example"), bandwidthMeter);

        MediaSource videoSource = new HlsMediaSource.Factory(dataSourceFactory).createMediaSource(videoUri);

        // Prepare video with sub title
        player.prepare(videoSource);
        // Set the player to view
        simpleExoPlayerView.setPlayer(player);
        // Auto play
        player.setPlayWhenReady(true);
        // Hide navigation bar
        simpleExoPlayerView.setOnClickListener(v -> hideSystemUI());
        // Add a listener to handle keeping the screen awake
        player.addListener(new PlayerEventListener());

    }

    @Override
    protected void onPause() {
        super.onPause();
        // If Exo is ready, passing false you will pause the player
        player.setPlayWhenReady(false);

    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        super.onCreateOptionsMenu(menu);
        getMenuInflater().inflate(R.menu.change_quality_menu, menu);
        CastButtonFactory.setUpMediaRouteButton(getApplicationContext(), menu, R.id.media_route_menu_item);

        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        if (item.getItemId() == R.id.change_quality) {
            if (!isShowingTrackSelectionDialog && TrackSelectionDialog.willHaveContent(trackSelector)) {
                isShowingTrackSelectionDialog = true;
                TrackSelectionDialog trackSelectionDialog = TrackSelectionDialog.createForTrackSelector(trackSelector,
                        /* onDismissListener= */ dismissedDialog -> isShowingTrackSelectionDialog = false);
                trackSelectionDialog.show(getSupportFragmentManager(), /* tag= */ null);

            }
        }
        return true;
    }

    private void setUpCasting() {

        CastButtonFactory.setUpMediaRouteButton(getApplicationContext(), mediaRouteButton);

        castContext = CastContext.getSharedInstance(this);
        if (castContext.getCastState() != CastState.NO_DEVICES_AVAILABLE)
            mediaRouteButton.setVisibility(View.VISIBLE);

        castContext.addCastStateListener(state -> {
            if (state == CastState.NO_DEVICES_AVAILABLE)
                mediaRouteButton.setVisibility(View.GONE);
            else {
                if (mediaRouteButton.getVisibility() == View.GONE)
                    mediaRouteButton.setVisibility(View.VISIBLE);
            }
        });
    }

    private void setUpMediaInfo() {
        MediaMetadata movieMetadata = new MediaMetadata(MediaMetadata.MEDIA_TYPE_MOVIE);

        movieMetadata.putString(MediaMetadata.KEY_TITLE, getMediaInfoTitle());

        MediaInfo mediaInfo = new MediaInfo.Builder(videoUri + "").setStreamType(MediaInfo.STREAM_TYPE_BUFFERED)
                .setContentType("video/m3u8").setMetadata(movieMetadata).build();

        final MediaQueueItem[] mediaItems = { new MediaQueueItem.Builder(mediaInfo).build() };

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

        decorView.setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_STABLE | View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION
                | View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN | View.SYSTEM_UI_FLAG_HIDE_NAVIGATION // hide nav bar
                | View.SYSTEM_UI_FLAG_FULLSCREEN // hide status bar
                | View.SYSTEM_UI_FLAG_IMMERSIVE);
    }

    @Override
    public void onConfigurationChanged(Configuration newConfig) {

        super.onConfigurationChanged(newConfig);

        // Checking the orientation of the screen
        if (newConfig.orientation == Configuration.ORIENTATION_LANDSCAPE) {
            // First Hide other objects (listview or recyclerview), better hide them using
            // Gone.
            FrameLayout.LayoutParams params = (FrameLayout.LayoutParams) simpleExoPlayerView.getLayoutParams();
            params.width = ViewGroup.LayoutParams.MATCH_PARENT;
            params.height = ViewGroup.LayoutParams.MATCH_PARENT;
            simpleExoPlayerView.setLayoutParams(params);
        } else if (newConfig.orientation == Configuration.ORIENTATION_PORTRAIT) {
            // Reveal your objects here.
            FrameLayout.LayoutParams params = (FrameLayout.LayoutParams) simpleExoPlayerView.getLayoutParams();
            params.width = ViewGroup.LayoutParams.MATCH_PARENT;
            params.height = ViewGroup.LayoutParams.MATCH_PARENT;
            simpleExoPlayerView.setLayoutParams(params);
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

    public void setSubtitleUri(String subtitleUri) {
        this.subtitleUri = Uri.parse(subtitleUri);
    }

    private void setupActionBar() {

        mToolbar = findViewById(R.id.toolbar);
        setSupportActionBar(mToolbar);
        getSupportActionBar().setTitle("");
    }

    private void findView() {
        simpleExoPlayerView = findViewById(R.id.exoplayer);
        mediaRouteButton = findViewById(R.id.media_route_button);
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

    /*
     * menu to add casting button
     */
    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        super.onCreateOptionsMenu(menu);
        getMenuInflater().inflate(R.menu.media_route_menu_item, menu);
        CastButtonFactory.setUpMediaRouteButton(getApplicationContext(), menu, R.id.media_route_menu_item);
        return true;
    }

}
