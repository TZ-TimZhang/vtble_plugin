//
//  VTModelIdentifier.h
//  VTBLE
//
//  Created by dev on 2022/7/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VTModelIdentifier : NSObject

@property (nonatomic, copy) NSNumber *version;

@property (nonatomic, copy) NSNumber *type;

@property (nonatomic, copy) NSNumber *subtype;

@property (nonatomic, copy) NSNumber *vendor;

- (instancetype)initWithVersion:(NSNumber *)version type:(NSNumber *)type subtype:(NSNumber *)subtype vendor:(NSNumber *)vendor;

/// Creates a modle identifier from a dictionary.
/// @param dictionary A dictionary containing the keys and values with which to initialize the new modle identifier. The keys must be same as property names of the VTModelIdentifier class.
- (instancetype)initWithDictionary:(NSDictionary<NSString *, NSNumber *> *)dictionary;

@end

NS_ASSUME_NONNULL_END
