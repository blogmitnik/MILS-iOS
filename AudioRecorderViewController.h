#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>
#import "AppModel.h"
#import "AudioMeter.h"

typedef enum {
	kAudioRecorderStarting,
	kAudioRecorderRecording,
	kAudioRecorderRecordingComplete,
	kAudioRecorderPlaying,
    kAudioRecorderNoteMode
} AudioRecorderModeType;


@interface AudioRecorderViewController : UIViewController <AVAudioSessionDelegate, AVAudioRecorderDelegate, AVAudioPlayerDelegate> {
	
	AudioMeter *meter;
	AVAudioRecorder *soundRecorder;
	AVAudioPlayer *soundPlayer;
	NSURL *soundFileURL;
	NSData *audioData;
	IBOutlet UIButton *recordStopOrPlayButton;
	IBOutlet UIButton *uploadButton;
	IBOutlet UIButton *discardButton;
	AudioRecorderModeType mode;
	BOOL recording;
	BOOL playing;
    BOOL previewMode;
    int noteId;
	NSTimer *meterUpdateTimer;
	id delegate, parentDelegate;
}

@property(readwrite, retain) AudioMeter *meter;
@property(readwrite, retain) NSURL *soundFileURL;
@property(readwrite, retain) NSData *audioData;
@property(readwrite, retain) AVAudioRecorder *soundRecorder;
@property(readwrite, retain) AVAudioPlayer *soundPlayer;
@property(readwrite, retain) NSTimer *meterUpdateTimer;
@property(nonatomic, retain) id delegate;
@property(nonatomic, retain) id parentDelegate;

@property(readwrite, assign) int noteId;
@property(readwrite, assign) BOOL previewMode;


- (IBAction) recordStopOrPlayButtonAction: (id) sender;
- (IBAction) uploadButtonAction: (id) sender;
- (IBAction) discardButtonAction: (id) sender;
- (void) updateButtonsForCurrentMode;



@end

