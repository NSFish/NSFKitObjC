//
//  NSFCollectionViewDelegateProxy.m
//
//  Created by shlexingyu on 2018/11/16.
//

#import "NSFCollectionViewDelegateProxy.h"
#import <objc/runtime.h>

@interface NSFCollectionViewDelegateProxy()
@property (nonatomic, weak, readonly) UIViewController<NSFAllOptionalCollectionViewDataSource, UICollectionViewDelegate> *viewController;
@property (nonatomic, weak, readonly) id<NSFAllOptionalCollectionViewDataSource, UICollectionViewDelegate> viewModel;
@property (nonatomic, assign) SEL cellForItemAtIndexPath;
@property (nonatomic, assign) SEL viewForSupplementaryElementOfKindAtIndexPath;
@property (nonatomic, assign) SEL didSelectItemAtIndexPath;

@end


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wprotocol"
@implementation NSFCollectionViewDelegateProxy
#pragma clang diagnostic pop

- (instancetype)initWithViewController:(UIViewController<NSFAllOptionalCollectionViewDataSource, UICollectionViewDelegate> *)viewController
                             viewModel:(id<NSFAllOptionalCollectionViewDataSource, UICollectionViewDelegate>)viewModel
{
    if (self = [super initWithDelegates:@[viewController, viewModel] weakRef:YES])
    {
        _viewController = viewController;
        _viewModel = viewModel;
        
        self.cellForItemAtIndexPath = @selector(collectionView:cellForItemAtIndexPath:);
        self.viewForSupplementaryElementOfKindAtIndexPath = @selector(collectionView:viewForSupplementaryElementOfKind:atIndexPath:);
        self.didSelectItemAtIndexPath = @selector(collectionView:didSelectItemAtIndexPath:);
    }
    
    return self;
}

#pragma mark - Rule
- (id<NSObject>)delegateRules:(SEL)selector
{
    if (selector == self.cellForItemAtIndexPath)
    {
        return self.viewController;
    }
    else if (selector == self.viewForSupplementaryElementOfKindAtIndexPath
             || selector == self.didSelectItemAtIndexPath)
    {
        if ([self.viewController respondsToSelector:selector])
        {
            return self.viewController;
        }
    }
    else if ([self.viewController respondsToSelector:selector])
    {
        return self.viewController;
    }
    else if ([self.viewModel respondsToSelector:selector])
    {
        return self.viewModel;
    }
    
    return nil;
}

@end
