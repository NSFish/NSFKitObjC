# NSFKitObjC

[![CI Status](https://img.shields.io/travis/NSFish/NSFKitObjC.svg?style=flat)](https://travis-ci.com/NSFish/NSFKitObjC)
[![Version](https://img.shields.io/github/tag/NSFish/NSFKitObjC.svg?style=flat)](https://github.com/NSFish/NSFKitObjC/releases)
[![License](https://img.shields.io/github/license/mashape/apistatus.svg)](https://github.com/NSFish/NSFKitObjC/blob/master/LICENSE)
[![Platform](https://img.shields.io/badge/platform-iOS-lightgrey.svg)](https://github.com/NSFish/NSFKitObjC)

## 内容

NSFKitObjC 是我数年来 iOS 开发的沉淀，包括但不限于

### 修复原生 SDK 的 bug

```Objective-C
/**
 修正 UITableViewHeaderFooterView 的各种 bug：
 - 移除 UITableViewHeaderFooterView 偶现的 Autolayout 警告
 - 设置 backgroundView = [UIView new]，以保证 backgroundView.backgroundColor 有效
 */
@interface NSFTableViewHeaderFooterView : UITableViewHeaderFooterView

/**
 UITableViewHeaderFooterView 会在 layoutSubviews 中修改 textLabelFont 的值导致外部设置无效
 这里提供一个 placeholder，在 layoutSubviews 中再进行设置
 */
@property (nonatomic, copy, nullable) UIFont *nsf_textLabelFont;
@property (nonatomic, copy, nullable) UIColor *nsf_textLabelColor;

// ...
```

### 最佳实践的封装

```Objective-C
@protocol NSFReusableUIComponent<NSObject>

+ (NSString *)reuseID;

@end

@interface UITableView (NSFExt)

/**
 注册 cell，自动区分 cell 是否有对应的 nib，自动分配 reuseID
 */
- (void)nsf_registerCell:(Class<NSFReusableUIComponent>)cellClass;

/**
 注册 headerFooterView，自动区分 cell 是否有对应的 nib，自动分配 reuseID
 */
- (void)nsf_registerSectionHeaderFooterView:(Class<NSFReusableUIComponent>)viewClass;

//...
@end
```

### 基于 message forwarding 的依赖注入

```Objective-C
/**
 为指定 protocol 的 delegate 提供多个 implementations，每一次方法调用都只会有一个 implementation 胜出并响应该调用。可以用于不同层级间的依赖注入。
 */
@interface NSFPrioritizedDelegate : NSObject

/**
 生成传入的delegates的wrapper delegate

 @param delegates 所有实现了指定protocol的对象
 @param weakRef 是否仅持有所有delegate的弱引用
 */
- (instancetype)initWithDelegates:(NSArray<id<NSObject>> *)delegates
                          weakRef:(BOOL)weakRef NS_DESIGNATED_INITIALIZER;


// ...
@end
```

### 容易实现但完美实现很难、不同版本下更让人咬牙的常用功能封装

```Objective-C
// 支持 iOS 9+ UITableViewCell 的展开收起，不再有
// - 超出一屏时最后一行展开后，列表没有下滑显示展开内容
// - 超出一屏时，收起最后一行无动画
// - ...
//
// 理所当然地支持 Autolayout，也支持复杂 UI 下不得已的 frame based UI.
@interface NSFTableViewCellExpander : NSObject

- (instancetype)initWithTableView:(UITableView *)tableView
                    useAutoLayout:(BOOL)useAutoLayout NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithTableView:(UITableView *)tableView;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

#pragma mark - Public
- (BOOL)expandStateForCellAtIndexPath:(NSIndexPath *)indexPath;
- (void)configCell:(__kindof UITableViewCell<NSFTableViewCellExpandable> *)cell withExpandStateAtIndexPath:(NSIndexPath *)indexPath;

- (void)changeExpandState:(__kindof UITableViewCell<NSFTableViewCellExpandable> *)cell;

@end
```

## 要求

iOS 9.0 or above.

## 安装

NSFKitObjC 没有提交到 Cocoapods 的官方大仓库中，需要在 Podfile 中指定 git:

```ruby
pod 'NSFKitObjC', :git => 'git@github.com:NSFish/NSFKitObjC.git'
```

## License

MIT.
