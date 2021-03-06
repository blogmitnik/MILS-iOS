#import <UIKit/UIKit.h>
#import "AppModel.h"
#import <ZXingWidgetController.h>
#import "ZBarReaderViewController.h"


@interface QRScannerViewController : UIViewController <UINavigationControllerDelegate, 
                                                        UIImagePickerControllerDelegate, 
                                                        ZXingDelegate, ZBarReaderDelegate>{
	IBOutlet UIButton *qrScanButton;
    IBOutlet UIButton *barcodeButton;
    IBOutlet UIButton *imageScanButton;
	IBOutlet UITextField *manualCode;
    NSString *resultText;
    UIImagePickerController *imageMatchingImagePickerController;
}

@property (nonatomic, retain) IBOutlet UIButton *qrScanButton;
@property (nonatomic, retain) IBOutlet UIButton *barcodeButton;

@property (nonatomic, retain) IBOutlet UIButton *imageScanButton;
@property (nonatomic, retain) IBOutlet UITextField *manualCode;
@property (nonatomic, retain) UIImagePickerController *imageMatchingImagePickerController;
@property (nonatomic, retain) NSString *resultText;

- (IBAction) scanButtonTapped;

- (IBAction)qrScanButtonTouchAction: (id) sender;
- (IBAction)imageScanButtonTouchAction: (id) sender;
- (void) loadResult:(NSString *)result;

- (void)zxingController:(ZXingWidgetController*)controller didScanResult:(NSString *)result;
- (void)zxingControllerDidCancel:(ZXingWidgetController*)controller;


@end
