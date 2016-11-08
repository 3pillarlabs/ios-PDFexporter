//
//  DispatchQueueExtension.h
//  PDFExporter
//
//  Copyright © 2016 3Pillar Global. All rights reserved.
//

#ifndef DispatchQueueExtension_h
#define DispatchQueueExtension_h

#import <Foundation/Foundation.h>

void PDFExporter_dispatch_sync_main_queue(void (^block)(void)) {
    if ([NSThread isMainThread]) {
        block();
    } else {
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}


#endif /* DispatchQueueExtension_h */
