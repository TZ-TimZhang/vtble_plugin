//
//  VTAcceleration.h
//  VTBLE
//
//  Created by dev on 2022/8/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VTAcceleration : NSObject

/// X-axis acceleration in G's (gravitational force).
@property (nonatomic, assign, readonly) SInt16 x;

/// Y-axis acceleration in G's (gravitational force).
@property (nonatomic, assign, readonly) SInt16 y;

/// Z-axis acceleration in G's (gravitational force).
@property (nonatomic, assign, readonly) SInt16 z;

@end

NS_ASSUME_NONNULL_END
