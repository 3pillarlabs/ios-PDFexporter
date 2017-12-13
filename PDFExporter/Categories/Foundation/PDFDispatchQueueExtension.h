//
//  PDFDispatchQueueExtension.h
//  PDFExporter
//
//  Copyright © 2016 3Pillar Global. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Assures that the block is called on synchronously on main queue.

 @param ^block The block to be called on main queue.
 */
extern void PDFExporter_dispatch_sync_main_queue(void (^block)(void));
