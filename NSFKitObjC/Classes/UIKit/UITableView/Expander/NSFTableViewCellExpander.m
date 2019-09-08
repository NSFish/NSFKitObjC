//
//  NSFTableViewCellExpander.m
//  AWSCore
//
//  Created by shlexingyu on 2019/3/27.
//

#import "NSFTableViewCellExpander.h"

@interface NSFTableViewCellExpander ()
@property (nonatomic, strong, readonly) UITableView *tableView;
@property (nonatomic, assign, readonly) BOOL useAutoLayout;
@property (nonatomic, strong) NSMutableDictionary<NSIndexPath *, NSNumber *> *states;

@end

@implementation NSFTableViewCellExpander

- (instancetype)initWithTableView:(UITableView *)tableView
                    useAutoLayout:(BOOL)useAutoLayout
{
    if (self = [super init])
    {
        _tableView = tableView;
        _useAutoLayout = useAutoLayout;
        self.states = [NSMutableDictionary new];
    }
    
    return self;
}

- (instancetype)initWithTableView:(UITableView *)tableView
{
    return [self initWithTableView:tableView useAutoLayout:YES];
}

#pragma mark - Public
- (BOOL)expandStateForCellAtIndexPath:(NSIndexPath *)indexPath
{
    return self.states[indexPath].boolValue;
}

- (void)configCell:(__kindof UITableViewCell<NSFTableViewCellExpandable> *)cell withExpandStateAtIndexPath:(NSIndexPath *)indexPath
{
    [cell configWithExpandState:self.states[indexPath].boolValue];
}

- (void)changeExpandState:(__kindof UITableViewCell<NSFTableViewCellExpandable> *)cell
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    BOOL expand = !self.states[indexPath].boolValue;
    [self nsf_properlyAnimateCell:cell atIndexPath:indexPath expand:expand];
}

#pragma mark - Private
- (void)nsf_properlyAnimateCell:(__kindof UITableViewCell<NSFTableViewCellExpandable> *)cell
                    atIndexPath:(NSIndexPath *)indexPath
                         expand:(BOOL)expand
{
    CGFloat beforeRowHeight = [self.tableView.delegate tableView:self.tableView heightForRowAtIndexPath:indexPath];
    
    self.states[indexPath] = @(expand);
    if (self.useAutoLayout)
    {
        [cell configWithExpandState:expand];
    }
    __block CGFloat rowHeight = 0;
    
    dispatch_block_t updateTableView = ^{
        // 1. 保证 contentSize 是正确的
        // 2. 当前 cell 下方的 cell 依序上/下移
        [self.tableView beginUpdates];
        [self.tableView endUpdates];
    };
    
    dispatch_block_t correctContentOffset = ^{
        // 展开收起最后一行时，保证该行内容完全可视
        CGRect frame = [cell.superview convertRect:cell.frame toView:self.tableView.superview];
        CGFloat y = frame.origin.y + rowHeight;
        if (y >= self.tableView.frame.size.height)
        {
            CGRect rect = cell.frame;
            rect.origin.y += rowHeight;
            
            [self.tableView scrollRectToVisible:CGRectMake(0, 0, self.tableView.frame.size.width, rect.origin.y)
                                       animated:YES];
        }
    };
    
    dispatch_block_t correctContentSize = ^{
        CGSize contentSize = self.tableView.contentSize;
        contentSize.height += (rowHeight - beforeRowHeight);
        self.tableView.contentSize = contentSize;
    };
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        // cell 本身的动画要在 updateTableView 之前调用
        // 否则动画效果会被无视
        if (self.useAutoLayout)
        {
            [cell.contentView layoutIfNeeded];
        }
        else
        {
            [cell configWithExpandState:expand];
        }
        
        rowHeight = [self.tableView.delegate tableView:self.tableView heightForRowAtIndexPath:indexPath];
        
        if (expand)
        {
            // 先执行 correct 的话，动画效果会是
            // 1. 列表整体内容下移
            // 2. 列表上移，直到显示出 expand 部分
            updateTableView();
            
            correctContentSize();
            correctContentOffset();
        }
        else
        {
            // 先执行 update 的话，动画效果会是
            // 1. expand 部分会"瞬移"到 cell.bounds 的最上方
            // 2. 原先所在位置露出空白
            // 3. 原先所在位置慢慢收窄到消失
            correctContentSize();
            correctContentOffset();
            
            updateTableView();
        }
    } completion:nil];
}

@end
