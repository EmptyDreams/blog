---
title: 《我的世界：Minecraft模组开发指南》读后感
date: 2020-07-23 17:54:24
tags:
	- Java
	- MC
categories:
	- Java
cover: https://cdn.jsdelivr.net/gh/EmptyDreams/resources/b2.png
description: 经过漫长的等待终于拿到书了，迫不及待地大致的把书翻看了一遍，今天就简单的谈一下阅读时发现的问题
---

&emsp;&emsp;经过漫长的等待终于拿到书了，迫不及待地大致的把书翻看了一遍，今天就简单的谈一下阅读时发现的问题。

&emsp;&emsp;拿到书后迫不及待的大概的把书翻看了一遍，总体来说不太满意，感觉内容中难度上卡到了入门和熟练之间，读起来比较捉急，即没有真的把入门的东西讲全，也没有提到高级的东西。

&emsp;&emsp;按照个人的建议，这本书并不适合Java和Forge的深度学习，学习Forge推荐阅读4z的[Minecraft 1.8.9 FML Mod 开发教程](https://fmltutor.ustc-zzzz.net/)以及[先驱者教程](https://harbinger.covertdragon.team)，其中4z的教程版本较老但是较为完善，先驱者是1.12.2版本但是内容不完善同时对新手不太友好，所以可以两个搭配食用。学习Java的话在文章尾部笔者罗列了一些书籍，读者可以选择性的阅读。

&emsp;&emsp;同时按照我个人的看法，开始写模组之前一定要熟练掌握Java编程，不然开发过程中会遇到很多问题。

&emsp;&emsp;同时阅读的时候也发现了一些我个人认为有待改进、不严谨和错误的地方，这里简单罗列一下：

### 代码风格

&emsp;&emsp;书中简要提及了代码风格的问题，但是说明的不够详细，详细介绍可以[看这里](https://www.jianshu.com/p/e7d500f36da4)，如果看完仍然不清楚的话可以自行百度查阅更多资料。

### 启动/调试模组的方式（P19）

&emsp;&emsp;书中给出的方式是`gradlew.bat runClient`和`gradlew.bat runServer`，实际上如果使用`gradlew.bat genIntelliRuns`配置的运行方式应该是下图中的样子(其中的虚拟机选项、程序参数、使用模块的类路径与JRE默认不是这样子，服务端与这个类似)：![客户端运行配置](https://blog.emptydreams.xyz/ReviewOfDevelopmentGuide/run.png)

### 注册名称（P57...）

&emsp;&emsp;书中一直在使用`setRegistryName(String name)`方法设置名称，虽然Forge可以自动推导modid，但是我个人仍然推荐使用`setRegistryName(String modid, String name)`、`setRegistryName(ResourceLocation name)`或者是`setRegistryName("modid:name")`。

&emsp;&emsp;同时使用`ResourceLocation`时也建议使用`new ResourceLocation(String resourceDomainIn, String resourcePathIn)`这个构造函数而不是手动的拼接modid与方块名称，其中对于方块来讲，`resourceDomainIn`对应modid，`resourcePathIn`对应方块name。

### 垃圾回收机制（P58---倒数第三行）

> 每过一段时间就会检查JVM中部分对象或所有对象

&emsp;&emsp;这句话实际上不严谨，GC（垃圾回收器）不会按照固定的时间进行回收，只会在满足特定条件时进行回收，至于检查所有对象还是部分对象，不同的垃圾回收器以及不同的收集方式会有所区别，这里不进行深究，读者感兴趣可以去查阅[《深入理解Java虚拟机：JVM高级特性与最佳实践》](https://book.douban.com/subject/6522893/)中的相关章节，书中详细说明了GC的相关算法与实现。

### SideOnly注解（P62---代码下方）

> @SideOnly的作用是表明这个方法只作用于客户端

&emsp;&emsp;实际上应该是`@SideOnly(CLIENT)`表明被修饰的元素只作用于客户端（@SideOnly可以修饰类、方法和字段），同时`@SideOnly(SERVER)`在普通开发中一般见不到，因为一旦使用了这个注解，那么模组将无法在本地游戏中使用被注解的元素。

### 材质大小（P63---最后一行）

> PNG文件本身大小应该是16像素x16像素，不过32像素x32像素的PNG图片也是可行的

&emsp;&emsp;做过材质的读者应该知道，MC中的材质大小只需要是2的整次幂就可以了（2，4，8，16……）。

### 未说明的代码

&emsp;&emsp;书中有多处给出了代码却没有说明用途的地方，如`Block`的构造函数、`GuiContainer#renderHoveredToolTip(int, int)`等。

### 书写错误

> 1.这是我们第一次编写拥有返回值的方法，也就是返回值声明为void。
>
> ​																			------ P71 · 第一行
>
> 2.IntelliJ IDEA 提出了两个方案——实现对应方法，并把这个类同样变成抽象类。
>
> ​																			------ P83 · 第四行
>
> 3.返回值是EnumActionResult.PASS的情况都将被视为成功执行，并忽略副手上的物品。
>
> ​																			------ P226 · 第七行

1). 应该为：这是我们第一次编写拥有返回值的方法，也就是返回值声明为`非void`。| 书中写成了"void"。

2). 应该为：IntelliJ IDEA 提出了两个方案——实现对应方法，`或`把这个类同样变成抽象类。| 书中将“或”写为了“并”。

3). 应该为：返回值是`EnumActionResult.SUCCESS`的情况都将被视为成功执行，并忽略副手上的物品。 | 书中将“SUCCESS”写成了“PASS”。

### ItemStack类（P85---倒数第三行）

> 这个数量在大部分情况下可以是1到64之间的任意值，当然，对于调用了setMaxStackSize方法，也就是设置了最大堆叠的物品，最大数字可能小于64。

&emsp;&emsp;这里只是补充一下，就算设置的最大值，也可以突破这个数值，极端一点的说，就算你设置了最大数值为"1"，也可以通过`setCount(int)`、`grow(int)`等方法使堆叠数量超过这个数值，不过开发中建议不要超过最大数量。

### 缺失的注解（P89---第一段代码）

&emsp;&emsp;文中明确说明“为覆盖用的方法也加上这一注解”，但是在下方代码中并没有出现`@sideOnly`注解，同时这句话我感觉应该是多写了一个“用”字。

### 被忽视的工具（P90）

&emsp;&emsp;文中提到了挖掘速度，指出速度等级为：木 < 石 < 铁 < 钻石，但是其中漏掉了“金”，加上金的排序如下：木 < 石 < 铁 < 钻石 < 金。

### 更为方便的数组声明方式（P101---最后一行）

&emsp;&emsp;书中使用`int[] intArray = new int[] {1, 2, 3, 4}`创建了数组，其实也可以简写为`int[] intArray = {1, 2, 3, 4}`。

### 冗余的对象比较方式（P120---最后一段代码）

&emsp;&emsp;虽然这么写比较没有问题，但是可以简写为：

```java
Blocks.DIRT.getRegistryName().equals(registryName)
```

&emsp;&emsp;或者使用更直白的方式：

```java
Item.getItemFromBlock(Blocks.DIRT) == event.getItemStack().getItem()
```

### 未说明的`hashCode()`方法（P121）

&emsp;&emsp;书中简单叙述了`equals(Object)`方法，但是却漏掉了`hashCode()`方法。在开发过程中，如果一个类重写了`equals(Object)`方法，那么它就应当也重写`hashCode()`方法，如果只重写其中一个，那么这个类将无法更好的与集合类合作。因为集合类为了优化性能，在比较对象时会优先比较hashCode，如果hashCode不同那么这两个对象一定不相等，如果相同再调用`equals(Object)`确保对象一致。

&emsp;&emsp;关于`hashCode()`方法这里就不详细说明了，读者可以查阅相关文章[(CSND)](https://www.cnblogs.com/zhchoutai/p/8676351.html)。

### 生成器模式（P167）

&emsp;&emsp;书中简要叙述了“生成器模式”，不过没有提到其它模式让人感觉有些可惜，读者[可以到这里](http://c.biancheng.net/design_pattern/)查阅相关内容，网页中不是所有模式都需要阅读，阅读：单例模式、工厂模式、建造者模式（即生成器模式）、代理模式、观察者模式、访问者模式即可。

&emsp;&emsp;不过小伙伴Java语言基础不怎么好的话可以先不看，留着以后阅读就好。

### 漏写的代码（P168）

&emsp;&emsp;书中写了`FooBuilder.create()`这样子的代码，但是每行都忘记在末尾加上`.build()`了。

### 装箱与拆箱

&emsp;&emsp;关于装箱与拆箱这里做一个补充：在能使用基本类型的时候不要使用包装类型，因为使用包装类型很可能会带来“许多”不必要的装箱与拆箱，会较为严重的影响程序性能。

### 识别NBT类型（P216）

> nbt instanceof NBTTagByte：检查nbt是否是byte类型的数据

&emsp;&emsp;同样这里只做一个简单的补充：NBT中`boolean`类型同样是以`NBTTagByte`的形式存储的。

### 过于简单的提及meta（P256）

&emsp;&emsp;关于meta书中只说明了只能使用4位，却没有提及二进制运算，实在令人感到可惜，读者可以阅读这篇文章了解[二进制（位）运算](https://www.cnblogs.com/shuaiding/p/11124974.html)。

&emsp;&emsp;同时书中给的代码其实是无法正常运行的，在游戏启动时会造成崩溃，应该写为如下形式：

```java
EnumFacing facing = EnumFacing.getHorizontal(meta);
if (facing.getAxis() == EnumFacing.Axis.Y) {
	facing = EnumFacing.NORTH;
}
return getDefaultState().widthProperty(FACING, facing);
```



### 混淆for与for-each（P272）

> 以for开头的语句被称为for-each循环语句。

&emsp;&emsp;实际上，只有如下形式的循环成为`for-each循环`，其他都成为`for循环`

```java
//"var"指数据类型，"array"指支持for-each循环的类型
for (var i : array) {
    //do something......
}
```

&emsp;&emsp;另外提一点，并非只有数组支持for-each循环，所有实现了`Iterable<E>`接口的类都可以支持for-each循环。

### 误用for-each循环（P272）

&emsp;&emsp;文中写了下面这样的代码：

```java
int[] range = new int[] {0, 1, 2, 3, 4, 5, 6, 7, 8};
for (int i : range) {
    //do something......
}
```

&emsp;&emsp;但是for-each循环的目的不是为了循环指定次数，而是用于遍历，循环指定次数应当使用如下代码：

```java
for (int i = 0; i < 8; ++i) {
    //do something......
}
```

### 排版问题

&emsp;&emsp;书中代码的排版问题还是很明显的，这里罗列一个（P226）：

```java
@Override
protected void onImact(RayTraceResult result)
{
    if (!this.world.isRemote)
    {
        if (result.entityHit != null)
        {
            float amount = 6.0F;
            DamageSource source = DamageSource.causeThrownDamage(this, this
.getThrower());
            if (result.entityHit instanceof EntityLivingBase)
            {
                EntityLivingBase target = ((EntityLivingBase) result.entityHit);
                if (target.isPotionActive(PotionRegistryHandler.POTION_DIRT_
PROTECTION))
                {
                    PotionEffect effect = target.getActivePotionEffect(PotionRegi
stryHandler.POTION_DIRT_PROTECTION);
                    amount = effect.getAmplifier() > 0 ? 0 : amount / 2;
                }
            }
            result.entityHit.attackEntityFrom(source, amount);
        }
        this.setDead();
    }
}
```

&emsp;&emsp;这段代码看起来无疑是非常混乱的，那么有没有办法让代码打印出来依然美观呢？答案是有的，有两种方法，第一种简单粗暴，直接贴张截图就可以了；另一种则是修改代码的样式。

&emsp;&emsp;比如说这段代码，我们可以看到缩进浪费了很多空间，那么我们可以把前两个`if`改成下面这种形式：

```java
if (this.world.isRemote) return;
if (result.entityHit == null)
{
    this.setDead();
    return;
}
```



&emsp;&emsp;这样子后面的代码就不需要缩进了，并且阅读代码的人看到前面的代码就能非常清楚的知道：这段代码在这两种情况下是不需要执行后面的逻辑的，按照原本的写法，读者还需要继续往下看，直到找到其对应的`}`然后发现原来这个情况是没有任何代码需要执行的。实际上在开发中，也建议使用后面的写法，会使代码更加的清晰易懂。

&emsp;&emsp;但是很明显，就算消除了缩进，中间最长的代码依然超出了打印的最大宽度，那么如何解决？很简单，仔细阅读就会发现代码中一个静态常量使用了两次，那么为了缩短打印出来的代码，我们可以使用`import static`或者直接干脆告诉读者因为印刷原因xxx简写成xxx来完成。同时我们也可以省去`this`，或者使用“伪代码”来节省版面。

&emsp;&emsp;经过简单的修改，代码就变成了下面这样，是不是好看了很多：

```java
//import static PotionRegistryHandler.POTION_DIRT_PROTECTION
@Override
protected void onImact(RayTraceResult result)
{
    if (this.world.isRemote) return;
    if (result.entityHit == null)
    {
        this.setDead();
        return;
    }
    
    float amount = 6.0F;
    DamageSource source = DamageSource.causeThrownDamage(this, getThrower());
    if (result.entityHit instanceof EntityLivingBase)
    {
    	EntityLivingBase target = ((EntityLivingBase) result.entityHit);
        if (target.isPotionActive(POTION_DIRT_PROTECTION))
        {
        	PotionEffect effect = target.getActivePotionEffect(POTION_DIRT_PROTECTION);
            amount = effect.getAmplifier() > 0 ? 0 : amount / 2;
        }
	}
    result.entityHit.attackEntityFrom(source, amount);
    setDead();
}
```

&emsp;&emsp;我们再举一个栗子，比如说P239的代码：

```java
mc.ingameGUI.drawTexturedModalRect(width / 2 - 170, height - 35, orange < 4 ? 0 : 9, 0, 9, 9);
mc.ingameGUI.drawTexturedModalRect(width / 2 - 170, height - 24, green < 4 ? 0 : 9, 0, 9, 9);
......
```

&emsp;&emsp;首先，我们看到代码中有一个重复出现的量，即：`width / 2 - 170`，那么我们可以把它保存下来，变成下面这样的代码：

```java
int x = width / 2 - 170;
mc.ingameGUI.drawTexturedModalRect(x, height - 35, orange < 4 ? 0 : 9, 0, 9, 9);
mc.ingameGUI.drawTexturedModalRect(x, height - 24, green < 4 ? 0 : 9, 0, 9, 9);
......
```

&emsp;&emsp;这里我们假设一个情况，就是已经缩短到最简，无法进行任何缩减了该怎么办？比如P242的代码：

```java
	private static final FMLEventChannel CHANNEL = NetworkRegistry.INSTANCE.
newEventDrivenChannel(NAME);
```

&emsp;&emsp;虽然可以使用`import static`进行缩短，但是这里我们换一种方法，就是拆分，把一行代码写成多行：

```java
private static final FMLEventChannel CHANNEL =
    			NetworkRegistry.INSTANCE.newEventDrivenChannel(NAME);
```

### 书籍推荐

&emsp;&emsp;这里我罗列出一些我看过的感觉还不错的编程书，大家可以根据自己的需求阅读：

| 归类 |                                  书籍名称 |
| :--: | ----------------------------------------: |
| 入门 |                          Java从入门到精通 |
| 入门 |                              Java编程思想 |
| 提升 |                            Effective Java |
| 提升 |                        Java数据结构与算法 |
| 提升 |                  重构：改善既有代码的设计 |
| 提升 |                                Java8 实战 |
| 拔高 | 深入理解Java虚拟机：JVM高级特性与最佳实践 |