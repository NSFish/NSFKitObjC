//
//  NSFButton.m
//  NSFKitObjC
//
//  Created by shlexingyu on 2019/1/2.
//

#import "NSFButton.h"
#import "NSFLightweightGenericSupport.h"

// 保证自定义 state 不和 UIControlState 的值相同
static inline NSUInteger NSFButtonCustomStateOffset(NSUInteger customState)
{
    return customState + 10086;
};


@interface NSFButton ()
@property (nonatomic, strong) MDict(NSNumber, NSNumber) states;

@end


@implementation NSFButton
@synthesize nsf_currentCustomState = _nsfCurrentCustomState;

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        _nsfCurrentCustomState = NSNotFound;
    }
    
    return self;
}

#pragma mark - Public
- (void)nsf_mapCustomState:(NSUInteger)customState toState:(UIControlState)state
{
    self.states[@(NSFButtonCustomStateOffset(customState))] = @(state);
}

- (void)nsf_setCustomState:(NSUInteger)customState
      withUIConfiguration:(void(NS_NOESCAPE ^)(NSFUIButtonBuilder *button))configuration
{
    UIControlState state = [self.states[@(NSFButtonCustomStateOffset(customState))] integerValue];
    [self nsf_setState:state withUIConfiguration:configuration];
}

- (void)nsf_setTitle:(NSString *)title forCustomState:(NSUInteger)customState
{
    UIControlState state = [self.states[@(NSFButtonCustomStateOffset(customState))] integerValue];
    [self setTitle:title forState:state];
}

- (void)nsf_setTitleColor:(UIColor *)color forCustomState:(NSUInteger)customState
{
    UIControlState state = [self.states[@(NSFButtonCustomStateOffset(customState))] integerValue];
    [self setTitleColor:color forState:state];
}

- (void)nsf_setTitleShadowColor:(UIColor *)color forCustomState:(NSUInteger)customState
{
    UIControlState state = [self.states[@(NSFButtonCustomStateOffset(customState))] integerValue];
    [self setTitleShadowColor:color forState:state];
}

- (void)nsf_setImage:(UIImage *)image forCustomState:(NSUInteger)customState
{
    UIControlState state = [self.states[@(NSFButtonCustomStateOffset(customState))] integerValue];
    [self setImage:image forState:state];
}

- (void)nsf_setBackgroundImage:(UIImage *)image forCustomState:(NSUInteger)customState
{
    UIControlState state = [self.states[@(NSFButtonCustomStateOffset(customState))] integerValue];
    [self setBackgroundImage:image forState:state];
}

- (void)nsf_setAttributedTitle:(NSAttributedString *)title forCustomState:(NSUInteger)customState
{
    UIControlState state = [self.states[@(NSFButtonCustomStateOffset(customState))] integerValue];
    [self setAttributedTitle:title forState:state];
}

#pragma mark - Property
- (void)nsf_setCurrentCustomState:(NSUInteger)currentCustomState
{
    if (currentCustomState == NSNotFound
        || _nsfCurrentCustomState == currentCustomState)
    {
        return;
    }
    
    [self willChangeValueForKey:NSStringFromSelector(@selector(nsf_currentCustomState))];
    _nsfCurrentCustomState = currentCustomState;
    [self didChangeValueForKey:NSStringFromSelector(@selector(nsf_currentCustomState))];
    
    UIControlState state = [self.states[@(NSFButtonCustomStateOffset(currentCustomState))] integerValue];
    self.selected = state & UIControlStateSelected;
    self.enabled = !(state & UIControlStateDisabled);
}

- (MDict(NSNumber, NSNumber))states
{
    if (!_states)
    {
        _states = [NSMutableDictionary new];
    }
    
    return _states;
}

@end
