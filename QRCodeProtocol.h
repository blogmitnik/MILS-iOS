enum {
	QRCodeNPC		= 1,
	QRCodeItem		= 2,
	QRCodeNode		= 3
};
typedef UInt32 QRCodeKind;


@protocol QRCodeProtocol
- (NSString *)name; 
- (QRCodeKind)kind;
- (void)display;
@end
