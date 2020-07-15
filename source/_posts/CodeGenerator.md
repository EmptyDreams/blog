---

title: 代码生成器类结构展示
date: 2020-04-02 22:11:32
categories:
        - 晨曦
tags: 
        - JAVA
        - 类
        - 设计
---

## 代码生成器结构如下图：
![](http://i1.fuimg.com/714951/9e01c4a7952001d3.png)

----------

### 1.CXImport

​		表示一个完整类名，用来表示需要导入的包：`java.lang.Object`

### 2.EnumState

表示一个元素的状态，当状态冲突时抛出运行期异常：

| 名称      | 介绍                      |
| --------- | ------------------------- |
| CLASS     | 表示这是一个类            |
| INTERFACE | 表示这是一个接口          |
| ENUM      | 表示这是一个枚举类        |
| FINAL     | 表示该元素被final修饰     |
| ABSTRACT  | 表示该元素被abstract修饰  |
| PUBLIC    | 表示该元素被public修饰    |
| PRIVATE   | 表示该元素被private修饰   |
| PROTECTED | 表示该元素被protected修饰 |



### 3.CXStruct

所有数据类的父类，被`abstract`修饰，其中可能包含的方法及元素如下：

| 种类 | 类型                 | 名称           | 介绍             | 是否为`abstract` |
| :--: | :------------------- | :------------- | :--------------- | :--------------: |
| 元素 | String               | name           | 存储标识符       |        否        |
| 元素 | Set&lt;EnumState&gt; | states         | 存储状态量       |        否        |
| 元素 | Set&lt;CXImport&gt;  | imports        | 存储需要导入的包 |        否        |
| 方法 | public String        | toString()     | 获得字符串       |        是        |
| 方法 | public int           | hashCode()     | 获取hashCode()   |        是        |
| 方法 | public boolean       | equals(Object) | 判断对象是否相等 |        是        |
| 方法 | public XXX           | getter()       |                  |        否        |
| 方法 | public void          | setter(XXX)    |                  |        否        |

### 4.CXClass

代表需要生成一个类，继承自`CXStruct`，其中可能包含的方法及元素如下：

| 种类 | 类型              | 名称       | 介绍                 |
| ---- | ----------------- | ---------- | -------------------- |
| 元素 | Set&lt;CXField&gt; | fields | 存储类中包含的变量 |
| 元素 | Set&lt;CXFunction&gt; | futcions | 存储类中包含的函数 |
| 元素 | Set&lt;CXInnerClass&gt; | innerClass | 存储类中包含的内部类 |
| 元素 | Set&lt;CXConstructors&gt; | constructors | 存储构造函数 |
| 方法 | public void | read(File file) | 从指定文件中读取离线的数据 |
| 方法 | public void | write(File file) | 向指定目录离线数据 |
| 方法 | public void | readCode(StringBuilder) | 读取需要转换为代码的数据 |
| 方法 | public boolean | isInnerClass() | 是否是内部类 |
| 方法 | public XXX | getter()                |                            |
| 方法 | public void | setter()                |                            |

### 5.CXType

表示一个数据类型，包括基本类型：

| 种类 | 类型        | 名称     | 介绍                                              |
| ---- | ----------- | -------- | ------------------------------------------------- |
| 元素 | String      | name     | 数据类型的名称，该名称与`Class.getName()`保持一致 |
| 元素 | Object      | value    | 存储该数据的值                                    |
| 方法 | public XXX  | getter() |                                                   |
| 方法 | public void | setter() |                                                   |

### 6.CXFunction

代表类中的一个方法：

| 种类 | 类型                     | 名称           | 介绍                        |
| ---- | ------------------------ | -------------- | --------------------------- |
| 元素 | CXType                   | returnType     | 表示返回值的数据类型        |
| 元素 | CXConstructor            | param          | 存储方法的参数列表          |
| 元素 | Set&lt;StatementType&gt; | sentences      | 存储方法体内的语句          |
| 方法 | public boolean           | check(CXClass) | 检查sentences内数据是否合法 |
| 方法 | public XXX               | getter()       |                             |
| 方法 | public void              | setter()       |                             |

### 7.CXConstructor

表示一个类的构造函数或者一个方法的所有参数：

| 种类 | 类型               | 名称             | 介绍                   |
| ---- | ------------------ | ---------------- | ---------------------- |
| 元素 | List&lt;CXType&gt; | types            | 存储包含的参数列表     |
| 方法 | public boolean     | check(CXType...) | 判断输入的列表是否合法 |
| 方法 | public XXX         | getter()         |                        |
| 方法 | public void        | setter()         |                        |


### 8.StatementType

表示一个语句的类型，其中有众多分支：

| 内部类类名  | 介绍                 | 示例                                |
| ----------- | -------------------- | ----------------------------------- |
| Ddclaration | 一个变量的声明       | `int k`                             |
| Assgin      | 一个变量的赋值       | `k = 0`                             |
| DecAss      | 一个变量的声明和赋值 | `int k = 0`                         |
| Loop        | 循环语句             | `for (int i = 0; i < 10; ++i) { }`  |
| Control     | 控制语句             | `return true`                       |
| Call        | 方法调用             | `System.out.println("EmptyDreams")` |
| Operation   | 运算语句             | `5 + 10`                            |
| Judge       | 判断语句             | `if (true) { }`                     |
| Cast        | 类型转换             | `(int) [double]`                    |
| Superior    | 上级引用语句         | `super(10)`                         |

