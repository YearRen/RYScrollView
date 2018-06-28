//
//  CarInfoModel.h
//  SampleDemo
//
//  Created by RoZ on 2018/6/26.
//  Copyright © 2018年 Year. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarInfoModel : NSObject

@property (nonatomic, strong) NSNumber *specId;
@property (nonatomic, strong) NSNumber *seriesId;
@property (nonatomic, copy) NSString *specName;
@property (nonatomic, strong) NSArray *specColorList;
@property (nonatomic, strong) NSArray *groupParamsViewModelList;

@end

@interface CarColorModel : NSObject

@property (nonatomic, strong) NSNumber *ownId;
@property (nonatomic, strong) NSNumber *specId;
@property (nonatomic, strong) NSNumber *colorId;
@property (nonatomic, copy) NSString *colorValue;
@property (nonatomic, copy) NSString *colorName;
@property (nonatomic, strong) NSNumber *bodyId;

@end

@interface GroupParams : NSObject

@property (nonatomic, strong) NSNumber *groupId;
@property (nonatomic, copy) NSString *groupName;
@property (nonatomic, strong) NSArray *paramList;

@end

@interface Params : NSObject

@property (nonatomic, strong) NSNumber *paramId;
@property (nonatomic, copy) NSString *paramName;
@property (nonatomic, copy) NSString *paramValue;

@end
