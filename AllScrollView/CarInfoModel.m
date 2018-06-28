//
//  CarInfoModel.m
//  SampleDemo
//
//  Created by RoZ on 2018/6/26.
//  Copyright © 2018年 Year. All rights reserved.
//

#import "CarInfoModel.h"

@implementation CarInfoModel

+ (NSDictionary *)mj_objectClassInArray {
    
    return @{@"specColorList":[CarColorModel class],
             @"groupParamsViewModelList":[GroupParams class]};
}

@end

@implementation CarColorModel

@end

@implementation GroupParams

+ (NSDictionary *)mj_objectClassInArray {

    return @{@"paramList":[Params class]};
}

@end

@implementation Params

@end
