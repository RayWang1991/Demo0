/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: lixianliang@bongmi.com
 */

#import "JSONModel/JSONModel.h"

@interface BMTJSONModel : JSONModel
@end

@interface BMTJSONModel (Protected)

// 这两个方法是用来配置哪些项是必需的，哪些是可选的
// BMTJSONModel会先去检查optionalKeys，如果返回不为nil，那么除去optionalKeys之外的都是必需的
// 如果optionalKeys返回nil，BMTJSONModel会再去检查necessaryKeys， 如果返回不为nil，那么除去necessaryKeys之外的都是可选的
// 如果两者都返回nil，则所有项均必需，此为默认行为。即跟optionalKeys返回空数组效果相同。
// 如果想要说明所有项均可选，则保持optionalKeys返回为nil，并且necessaryKeys返回空数组
+ (NSArray*)necessaryKeys;
+ (NSArray*)optionalKeys;

@end
