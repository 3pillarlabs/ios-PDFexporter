//
//  PDFDispatchQueueExtension.m
//  PDFExporter
//
//  Copyright © 2016 3Pillar Global. All rights reserved.
//

#import "PDFDispatchQueueExtension.h"

void PDFExporter_dispatch_sync_main_queue(void (^block)(void)) {
    if ([NSThread isMainThread]) {
        block();
    } else {
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}
