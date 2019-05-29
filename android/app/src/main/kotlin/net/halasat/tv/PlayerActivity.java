package net.halasat.tv;
import android.net.Uri;
import android.os.Bundle;
import android.view.Menu;
import android.view.View;
import android.widget.ImageButton;

import androidx.appcompat.app.AppCompatActivity;
import androidx.mediarouter.app.MediaRouteButton;

import com.google.android.exoplayer2.C;
import com.google.android.exoplayer2.DefaultLoadControl;
import com.google.android.exoplayer2.ExoPlayerFactory;
import com.google.android.exoplayer2.Format;
import com.google.android.exoplayer2.LoadControl;
import com.google.android.exoplayer2.SimpleExoPlayer;
import com.google.android.exoplayer2.source.MediaSource;
import com.google.android.exoplayer2.source.MergingMediaSource;
import com.google.android.exoplayer2.source.SingleSampleMediaSource;
import com.google.android.exoplayer2.source.hls.HlsMediaSource;
import com.google.android.exoplayer2.trackselection.AdaptiveTrackSelection;
import com.google.android.exoplayer2.trackselection.DefaultTrackSelector;
import com.google.android.exoplayer2.trackselection.TrackSelection;
import com.google.android.exoplayer2.trackselection.TrackSelector;
import com.google.android.exoplayer2.ui.PlaybackControlView;
import com.google.android.exoplayer2.ui.SimpleExoPlayerView;
import com.google.android.exoplayer2.upstream.DataSource;
import com.google.android.exoplayer2.upstream.DefaultBandwidthMeter;
import com.google.android.exoplayer2.upstream.DefaultDataSourceFactory;
import com.google.android.exoplayer2.util.MimeTypes;
import com.google.android.exoplayer2.util.Util;

import com.google.android.gms.cast.framework.CastButtonFactory;
import com.google.android.gms.cast.framework.CastContext;
import com.google.android.gms.cast.framework.CastState;
import com.google.android.gms.cast.framework.CastStateListener;


public class PlayerActivity extends AppCompatActivity {
    private boolean isShowingTrackSelectionDialog;
    private SimpleExoPlayer player;
    private SimpleExoPlayerView simpleExoPlayerView;
    private ImageButton quality;
    private TrackSelector trackSelector;
    private Uri videoUri;
    private Uri subtitleUri;
    private String title;
    private MediaRouteButton mediaRouteButton;

    public void setVideoUri(String videoUri) {
        this.videoUri = Uri.parse(videoUri);
    }


    public void setSubtitleUri(String subtitleUri) {
        this.subtitleUri = Uri.parse(subtitleUri);
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setContentView(R.layout.activity_main);

        Bundle bundle = getIntent().getExtras();


        if (bundle != null) {
            setSubtitleUri(bundle.getString("subsUrl"));
            setVideoUri(bundle.getString("videoUrl"));
            title = bundle.getString("title");
            Log.d("sdfhjsad", bundle.getString("subsUrl"));
        }


        setContentView(R.layout.activity_main);

        // Find view by id
        simpleExoPlayerView = findViewById(R.id.exoplayer);

        PlaybackControlView controlView = simpleExoPlayerView.findViewById(R.id.exo_controller);
        quality = controlView.findViewById(R.id.q);
         //cast button
        mediaRouteButton = controlView.findViewById(R.id.media_route_button);
        CastButtonFactory.setUpMediaRouteButton(getApplicationContext(), mediaRouteButton);

        mCastContext = CastContext.getSharedInstance(this);
        //set visibility of casting button
        if (mCastContext.getCastState() != CastState.NO_DEVICES_AVAILABLE)
            mediaRouteButton.setVisibility(View.VISIBLE);

        mCastContext.addCastStateListener(new CastStateListener() {
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


        DefaultBandwidthMeter bandwidthMeter = new DefaultBandwidthMeter(); //test
        TrackSelection.Factory videoTrackSelectionFactory = new AdaptiveTrackSelection.Factory(bandwidthMeter);
        trackSelector = new DefaultTrackSelector(videoTrackSelectionFactory);
        LoadControl loadControl = new DefaultLoadControl();


        //  Create the player
        player = ExoPlayerFactory.newSimpleInstance(this, trackSelector, loadControl);
        simpleExoPlayerView.setPlayer(player);

        quality.setOnClickListener(v -> {
            if (!isShowingTrackSelectionDialog
                    && TrackSelectionDialog.willHaveContent((DefaultTrackSelector) trackSelector)) {
                isShowingTrackSelectionDialog = true;
                TrackSelectionDialog trackSelectionDialog =
                        TrackSelectionDialog.createForTrackSelector(
                                (DefaultTrackSelector) trackSelector,
                                /* onDismissListener= */ dismissedDialog -> isShowingTrackSelectionDialog = false);
                trackSelectionDialog.show(getSupportFragmentManager(), /* tag= */ null);

            }
        });

        simpleExoPlayerView.requestFocus();

        // Bind the player to the view.
        simpleExoPlayerView.setPlayer(player);

        // Produces DataSource instances through which media data is loaded.
        DataSource.Factory dataSourceFactory = new DefaultDataSourceFactory(this, Util.getUserAgent(this, "exoplayer2example"), bandwidthMeter);


        //FOR LIVESTREAM LINK:
        // MediaSource videoSource =new HlsMediaSource(videoUri,dataSourceFactory,1,null,null);
        MediaSource videoSource = new HlsMediaSource.Factory(dataSourceFactory).createMediaSource(videoUri);

        // Build the subtitle MediaSource.
        Format subtitleFormat = Format.createTextSampleFormat(null, // An identifier for the track. May be null.
                MimeTypes.APPLICATION_SUBRIP, // The mime type. Must be set correctly.
                Format.NO_VALUE,
                "en",
                null); // The subtitle language. May be null.

        MediaSource subtitleSource = new SingleSampleMediaSource(subtitleUri, dataSourceFactory, subtitleFormat, C.TIME_UNSET);
        // Merging the video with subTitle
        MergingMediaSource mergedSource = new MergingMediaSource(videoSource, subtitleSource);
        // Set the player to view
        simpleExoPlayerView.setPlayer(player);
        // Prepare video with sub title
        player.prepare(mergedSource);


        // Auto play
        player.setPlayWhenReady(true);

    }


    // If the user close the activity then the video should pause also
    @Override
    protected void onPause() {
        super.onPause();
        // If Exo is ready, passing false you will pause the player
        if (player != null)
            player.setPlayWhenReady(false);
    }
    /*
     * menu to add casting button
     * */
    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        super.onCreateOptionsMenu(menu);
        getMenuInflater().inflate(R.menu.media_route_menu_item, menu);
        CastButtonFactory.setUpMediaRouteButton(getApplicationContext(),
                menu,
                R.id.media_route_menu_item);
        return true;
    }

}
