//
//  CollectionIndexView.h
//  LoginPart
//
//  Created by blacksky on 2020/2/16.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionIndexView : UIControl
/** The direction in which the control is oriented. Assists in determining layout values.
 */
typedef enum {
    BDKCollectionIndexViewDirectionVertical = 0,
    BDKCollectionIndexViewDirectionHorizontal
} BDKCollectionIndexViewDirection;

/** A collection of string values that represent section index titles.
 */
@property (strong, nonatomic) NSArray *indexTitles;

/** Indicates the position of the last-selected index title. Should map directly to a table view / collection section.
 */
@property (readonly, nonatomic) NSUInteger currentIndex;

/** The number of points used for padding at the end caps of the view (assists in layout).
 */
@property (nonatomic) CGFloat endPadding;

/** The direction in which the control is oriented; this is automatically set based on the frame given.
 */
@property (readonly) BDKCollectionIndexViewDirection direction;

/** The index title at the index of `currentIndex`.
 */
@property (readonly) NSString *currentIndexTitle;

/** A class message to initialize and return an index view control, given a frame and a list of index titles.
 *  @param frame the frame to use when initializing the control.
 *  @param indexTitles the index titles to be rendered out in the control.
 *  @return an instance of the class.
 */
+ (id)indexViewWithFrame:(CGRect)frame indexTitles:(NSArray *)indexTitles;

/** A message to initialize and return an index view control, given a frame and a list of index titles.
 *  @param frame the frame to use when initializing the control.
 *  @param indexTitles the index titles to be rendered out in the control.
 *  @return an instance of the class.
 */
- (id)initWithFrame:(CGRect)frame indexTitles:(NSArray *)indexTitles;
@end
