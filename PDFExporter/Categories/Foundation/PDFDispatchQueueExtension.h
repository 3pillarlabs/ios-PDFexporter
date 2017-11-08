//
//  PDFDispatchQueueExtension.h
//  PDFExporter
//
//  Copyright © 2016 3Pillar Global. All rights reserved.
//

#import <Foundation/Foundation.h>

extern void PDFExporter_dispatch_sync_main_queue(void (^block)(void));
