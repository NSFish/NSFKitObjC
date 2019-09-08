fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew cask install fastlane`

# Available Actions
### release_pod
```
fastlane release_pod
```
一键自动化发布 pod

1. 检查所有代码是否都已经 commit

2. pod install && 单元测试

3. 更新 Info.plist 中的 version number && 更新 podspec && 更新 build number

4. git add && git commit && git push 版本号变更

5. 根据上一次 tag 以来的 commit 自动生成 release note

6. git tag && git push origin tag



参数说明：

- type:发布类型，包括 patch、minor 和 major
### test_and_push
```
fastlane test_and_push
```
push 小修改

单元测试 && git push
### dryrun_tag
```
fastlane dryrun_tag
```
计算本次将提交的 tag

参数说明：

- type:发布类型，包括 patch、minor 和 major

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
