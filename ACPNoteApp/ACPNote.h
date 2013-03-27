//
//  ACPNote.h
//  ACPNoteApp
//
//  Created by Anna Parks on 3/27/13.
//  Copyright (c) 2013 Anna Parks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ACPNote : NSManagedObject

@property (nonatomic, retain) NSDate * timeStamp;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * noteDescription;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;

@end
