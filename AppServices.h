#import <Foundation/Foundation.h>
#import "SynthesizeSingleton.h"
#import "AppModel.h"
#import "Game.h"
#import "Tab.h"
#import "Item.h"
#import "Node.h"
#import "Npc.h"
#import "Media.h"
#import "WebPage.h"
#import "Panoramic.h"
#import "PanoramicMedia.h"
#import "JSONResult.h"
#import "JSONConnection.h"
#import "JSONResult.h"
#import "JSON.h"
#import "ASIFormDataRequest.h"
#import "MILSAppDelegate.h"
#import "Comment.h"
#import "Note.h"
#import "NoteMedia.h"
#import "NoteContent.h"
#import <MapKit/MapKit.h>

@interface AppServices : NSObject {
    //Fetcher Flags
    BOOL currentlyFetchingLocationList;
    BOOL currentlyFetchingInventory;
    BOOL currentlyFetchingQuestList;
    BOOL currentlyFetchingGamesList;
    BOOL currentlyUpdatingServerWithPlayerLocation;
    BOOL currentlyUpdatingServerWithMapViewed;
    BOOL currentlyUpdatingServerWithQuestsViewed;
    BOOL currentlyUpdatingServerWithInventoryViewed;
}

//Fetcher Flags
@property(readwrite) BOOL currentlyFetchingLocationList;
@property(readwrite) BOOL currentlyFetchingInventory;
@property(readwrite) BOOL currentlyFetchingQuestList;
@property(readwrite) BOOL currentlyFetchingGamesList;
@property(readwrite) BOOL currentlyUpdatingServerWithPlayerLocation;
@property(readwrite) BOOL currentlyUpdatingServerWithMapViewed;
@property(readwrite) BOOL currentlyUpdatingServerWithQuestsViewed;
@property(readwrite) BOOL currentlyUpdatingServerWithInventoryViewed;  


+ (AppServices *)sharedAppServices;


- (void)login;
- (id) fetchFromService:(NSString *)aService usingMethod:(NSString *)aMethod 
			   withArgs:(NSArray *)arguments usingParser:(SEL)aSelector;

- (void)fetchGameListWithDistanceFilter: (int)distanceInMeters locational:(BOOL)locationalOrNonLocational;
- (void)fetchRecentGameListForPlayer;
- (void)fetchMiniGamesListLocations;
- (void)fetchOneGame:(int)gameId;

- (void)fetchTabBarItemsForGame:(int)gameId;
- (void)fetchLocationList;
- (void)forceUpdateOnNextLocationListFetch;
- (void)fetchGameListBySearch: (NSString *) searchText;
- (void)resetAllPlayerLists;
- (void)fetchAllGameLists;
- (void)resetAllGameLists;
- (void)fetchAllPlayerLists;
- (void)fetchInventory;
- (void)fetchQuestList;
- (void)fetchNpcConversations:(int)npcId afterViewingNode:(int)nodeId;
- (void)fetchGameNpcListAsynchronously:(BOOL)YesForAsyncOrNoForSync;
- (void)fetchGameMediaListAsynchronously:(BOOL)YesForAsyncOrNoForSync;
- (void)fetchGameItemListAsynchronously:(BOOL)YesForAsyncOrNoForSync;
- (void)fetchGameNodeListAsynchronously:(BOOL)YesForAsyncOrNoForSync;
- (void)fetchGameWebpageListAsynchronously:(BOOL)YesForAsyncOrNoForSync;
- (void)fetchGamePanoramicListAsynchronously:(BOOL)YesForAsyncOrNoForSync;
- (void)fetchGameNoteListAsynchronously:(BOOL)YesForAsyncOrNoForSync;
- (void)fetchPlayerNoteListAsynchronously:(BOOL)YesForAsyncOrNoForSync;

- (Item *)fetchItem:(int)itemId;
- (Node *)fetchNode:(int)nodeId;
- (Npc *)fetchNpc:(int)npcId;
- (Note *)fetchNote:(int)noteId;
- (NSMutableArray *)fetchNoteContents:(int)noteId;
- (void)createItemAndPlaceOnMap:(Item *)item;
- (void)createItemAndPlaceOnMapFromFileData:(NSData *)fileData fileName:(NSString *)fileName 
                                      title:(NSString *)title description:(NSString*)description;

- (void)updateItem:(Item *) item;
- (void)createItemAndGiveToPlayerFromFileData:(NSData *)fileData fileName:(NSString *)fileName 
										title:(NSString *)title description:(NSString*)description;
- (void)createItemAndGivetoPlayer: (Item *) item;
- (void)uploadImageForMatching:(NSData *)fileData;

- (void) addContentToNoteFromFileData:(NSData *)fileData fileName:(NSString *)fileName 
                                 name:(NSString *)name noteId:(int) noteId type:(NSString *)type;
- (void) addContentToNoteWithText:(NSString *)text type:(NSString *) type mediaId:(int) mediaId andNoteId:(int)noteId;
- (int)createNote;
- (void)updateServerDropNoteHere: (int)noteId atCoordinate:(CLLocationCoordinate2D) coordinate;
- (void)getNoteById: (int)noteId;
- (void)deleteNoteContentWithContentId:(int) contentId;
- (void)deleteNoteWithNoteId: (int) noteId;
- (void)deleteNoteLocationWithNoteId: (int) noteId;
- (void)updateNoteContent:(int)contentId text:(NSString *)text;
- (int) addCommentToNoteWithId: (int)noteId andRating: (int)rating;
- (void)fetchNoteCommentsWithId: (int)noteId;
- (void)updateCommentWithId: (int)noteId parentNoteId: (int)parentNoteId andRating: (int)rating;

- (void)uploadNoteContentRequestFinished:(ASIFormDataRequest *)request;
- (void)uploadNoteRequestFailed:(ASIHTTPRequest *)request;
- (void)updateServerWithPlayerLocation;
- (void)updateServerNodeViewed: (int)nodeId;
- (void)updateServerItemViewed: (int)itemId;
- (void)updateServerWebPageViewed: (int)webPageId;
- (void)updateServerPanoramicViewed: (int)panoramicId;
- (void)updateServerNpcViewed: (int)npcId;
- (void)updateServerMapViewed;
- (void)updateServerNoteViewed: (int)noteId;
- (void)updateServerQuestsViewed;
- (void)updateServerInventoryViewed;
- (void)updateServerPickupItem: (int)itemId fromLocation: (int)locationId qty: (int)qty;
- (void)updateServerDropItemHere: (int)itemId qty:(int)qty;
- (void)updateServerDestroyItem: (int)itemId qty:(int)qty;
- (void)updateNoteWithNoteId:(int)noteId title:(NSString *) title andShared:(BOOL)shared;
- (void)startOverGame;
- (void)silenceNextServerUpdate;

- (void)registerNewUser:(NSString*)userName password:(NSString*)pass 
			  firstName:(NSString*)firstName lastName:(NSString*)lastName email:(NSString*)email;
- (void)parseGameListFromJSON: (JSONResult *)jsonResult;
- (Game *)parseGame:(NSDictionary *)gameSource;
- (void)parseGameMediaListFromJSON: (JSONResult *)jsonResult;
- (void)parseGameNpcListFromJSON: (JSONResult *)jsonResult;
- (void)parseGameItemListFromJSON: (JSONResult *)jsonResult;
- (void)parseGameNodeListFromJSON: (JSONResult *)jsonResult;
- (void)parseGameWebPageListFromJSON: (JSONResult *)jsonResult;
- (void)parseGamePanoramicListFromJSON: (JSONResult *)jsonResult;
- (void)parseGameTabListFromJSON:(JSONResult *)jsonResult;
- (void)parseGameNoteListFromJSON: (JSONResult *)jsonResult;
- (void)parsePlayerNoteListFromJSON: (JSONResult *)jsonResult;

- (void)parseRecentGameListFromJSON: (JSONResult *)jsonResult;
- (Location*)parseLocationFromDictionary: (NSDictionary *)locationDictionary;
- (Item *)parseItemFromDictionary: (NSDictionary *)itemDictionary;
- (Node *)parseNodeFromDictionary: (NSDictionary *)nodeDictionary;
- (Npc *)parseNpcFromDictionary: (NSDictionary *)npcDictionary;
- (WebPage *)parseWebPageFromDictionary: (NSDictionary *)webPageDictionary;
- (Panoramic *)parsePanoramicFromDictionary: (NSDictionary *)webPageDictionary;
- (Tab *)parseTabFromDictionary:(NSDictionary *)tabDictionary;
- (Note *)parseNoteFromDictionary: (NSDictionary *)noteDictionary;
- (NSMutableArray *)parseNoteContentsFromDictionary: (NSDictionary *)noteContentsDictionary;

- (void)updateServerGameSelected;
- (void)fetchQRCode:(NSString*)QRcodeId;
- (void)saveComment:(NSString*)comment game:(int)gameId starRating:(int)rating;
- (void)parseSaveCommentResponseFromJSON: (JSONResult *)jsonResult;
- (void)sendNotificationToNoteViewer;
- (void)sendNotificationToNotebookViewer;


@end
