//
//  NSFRuntimeUtils.m
//  AFNetworking
//
//  Created by shlexingyu on 2018/11/21.
//

#import "NSFRuntimeUtils.h"
#import <objc/runtime.h>

NSArray<Class> *NSFClassesThatConformsToProtocol(Protocol *protocol)
{
    Class *classes = NULL;
    NSMutableArray *collection = [NSMutableArray array];
    int numClasses = objc_getClassList(NULL, 0);
    if (numClasses == 0)
    {
        return @[];
    }
    
    classes = (__unsafe_unretained Class*)malloc(sizeof(Class) * numClasses);
    numClasses = objc_getClassList(classes, numClasses);
    for (int index = 0; index < numClasses; index++)
    {
        Class aClass = classes[index];
        if (class_conformsToProtocol(aClass, protocol))
        {
            [collection addObject:aClass];
        }
    }
    free(classes);
    
    return collection.copy;
}
