### 组件化如何解耦
1. #### 把同一模块的代码放到一起
2. #### 代码是两个模块的代码，不能放在同一模块的怎么办。

问题1很简单，就是从代码层面做好按模块分开。
如A模块的代码全部放到A模块里面，然后要对外的时候，A模块放出对外的接口给其他模块调用。
比如日志模块，他能够独立成一个模块，他不依赖别的模块，所以只需要把负责写日志等的代码放到一个日志模块里面，这样别人想要输出日志。就可以引入日志模块并用日志模块的接口输出日志就行。这里面没有耦合，也就不需要解耦。

问题2，比如A模块会用到B模块的方法，然后B模块又有可能用到A模块的代码，但是又不能把A和B合并为一个模块的时候怎么办。总不能A模块编译都编译不过，因为编译的时候会提示缺少B模块的方法。同样B模块也一样，缺少A模块，他编译都编译不了。 

这里就需要对A模块做B模块的解耦，同样B模块也一样要做A模块的解耦。

关于解耦的方法，网上也有挺多。比较有代表性的两种如下：

1. #### CTMediator的target-action模式
2. #### BeeHive的用protocol实现模块间调用

这里参考BeeHive的思想，用swift实现了一个解耦的例子。

### 定义
1. A模块
2. B模块
3. Interface模块（保存各个模块的对外接口，比如A或者B模块的对外接口，都放在这里）
4. 主工程

先看最后的依赖图

![image.png](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/82fa276386b642e085bdc32d3cd92129~tplv-k3u1fbpfcp-watermark.image?)


A模块要调用B模块的接口，这里他不需要依赖B模块，他只需要依赖Interface模块，然后A模块要调用B模块的功能，他只需要调用B模块放到Interface模块的接口就行。

### 如何实现：

Interface模块里面有一个公共类，比如叫：ModuleInterface
然后他里面有两个方法，
一个注册函数是让别的模块把自己实例注册到这里来的
一个是获取函数，通过某个key，获取到对应的模块的实例

```Swift
public class ModuleInterface {
    public static let shared = ModuleInterface()
    public var protocols: [String: BaseProtocol] = [:] // 维护一个字典
    // 注册函数
    public func registProtocol(by name: String, instance: BaseProtocol) {
        self.protocols[name] = instance
    }
    // 获取实例
    public func getProtocol(by name: String) -> BaseProtocol? {
        return self.protocols[name]
    }
}
```

这里的核心是维护一个字典，通过对应的key，找到对应的实例。

然后B模块的公开接口也放在这个Interface模块里面，如：
```Swift
extension ModuleInterface: BProtocol {
    // b对外的接口
    public func getBModuleValue(b: String, callback: ((Int)->Void)) -> Int {
        if let pro = self.getProtocol(by: "BProtocol") as? BProtocol {
            return pro.getBModuleValue(b: b, callback: callback)
        } else {
            print("no found BProtocol instance")
            callback(0)
            return 0
        }
    }
}
```

这里有两个技巧
1. 使用extension ModuleInterface: BProtocol， 这样可以把BProtocol里面定义的方法，实现到ModuleInterface类里面，这样别的模块调用的时候，统一用ModuleInterface来调用就行，入口简单
2. 使用self.getProtocol(by: "BProtocol") as? BProtocol，通过转类型的方式得到BProtocol的实例，就可以调用B模块的方法了。而且是运行时检查，这样也解决了，没有引用B模块也能编译通过。

如上：这样每个模块只需要在初始化的时候把自己的实例添加到这个字典里面去。然后想调用其他模块的时候，只需要从这个字典拿出对应模块的实例，再去调用别的模块就行。

然后A模块要想使用B模块的getBModuleValue的方法时，他只需要引入Interface模块，然后从ModuleInterface里面去调用如下：
```Swift
let a = ModuleInterface.shared.getBModuleValue(b: "a call b") { value in
    print("==callBModule=result==", value)
}
```


整个代码实现非常简单。

具体pod的代码如下： 
```Swift
A模块的podspec的定义
s.dependency 'Interface'

A模块的podfile的定义
use_frameworks!

platform :ios, '9.0'

target 'AModule_Example' do
  pod 'AModule', :path => '../'
  pod 'Interface', :path => '../../Interface'
end

B模块的podspec的定义
s.dependency 'Interface'
B模块的podfile的定义
use_frameworks!

platform :ios, '9.0'

target 'BModule_Example' do
  pod 'BModule', :path => '../'
  pod 'Interface', :path => '../../Interface'
end

主工程Demo的podfile的定义
use_frameworks!

platform :ios, '9.0'

target 'Demo' do
  pod 'AModule', :path => '../AModule'
  pod 'BModule', :path => '../BModule'
  pod 'Interface', :path => '../Interface'
end
```

