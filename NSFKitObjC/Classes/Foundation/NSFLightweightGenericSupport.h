//
//  NSFLightweightGenericSupport.h
//  Pods
//
//  Created by shlexingyu on 2018/12/17.
//

#ifndef NSFLightweightGenericSupport_h
#define NSFLightweightGenericSupport_h

#define Array(X)    NSArray<X *> *
#define MArray(X)   NSMutableArray<X *> *
#define Dict(X, Y)  NSDictionary<X *, Y *> *
#define MDict(X, Y) NSMutableDictionary<X *, Y *> *
#define Set(X)      NSSet<X *> *
#define MSet(X)     NSMutableSet<X *> *
#define Signal(X)   RACSignal<X *> *

#endif /* NSFLightweightGenericSupport_h */
