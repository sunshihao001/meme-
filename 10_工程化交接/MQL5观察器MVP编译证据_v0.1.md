# MQL5 Observer MVP Compile Evidence v0.1

> 分线：10_工程化交接 / MQL5观察器MVP验证  
> 状态：v0.1 / 真实 MetaEditor 编译证据  
> 目标文件：`mql5/indicators/FCZ_Cost_Reclaim_Observer.mq5`  
> 编译器：`C:/Program Files/MetaTrader 5/MetaEditor64.exe`

---

## 1. 编译命令

```bash
'/c/Program Files/MetaTrader 5/MetaEditor64.exe' \
  /compile:'C:\Users\Administrator\Documents\MQL5_第一控盘区成本中枢回收模型_学习资料\mql5\indicators\FCZ_Cost_Reclaim_Observer.mq5' \
  /log:'C:\Users\Administrator\Documents\MQL5_第一控盘区成本中枢回收模型_学习资料\mql5\indicators\compile.log'
```

---

## 2. 结果

第一次编译：

```text
Result: 0 errors, 1 warnings
```

warning：

```text
version '0.10' is incompatible with MQL5 Market, must be xxx.yyy
```

修复：

```text
#property version "0.10" → "1.000"
```

第二次编译：

```text
Result: 0 errors, 0 warnings, 633 ms elapsed, cpu='X64 Regular'
```

---

## 3. 当前验证边界

已真实完成：

```text
MetaEditor 编译通过，0 errors / 0 warnings。
```

未完成：

```text
MT5 图表手工挂载运行验证。
```

原因：

```text
当前 Hermes 工具可调用 MetaEditor 编译，但未执行 MT5 GUI 图表挂载与人工视觉确认。
```

后续如继续循环代理，应执行：

```text
1. 将指标复制/确认到 MT5 MQL5/Indicators 路径。
2. 在 MT5 中打开任意图表并挂载 FCZ_Cost_Reclaim_Observer。
3. 确认图表绘制 FCZ 矩形、POC/VAH/VAL、状态标签。
4. 检查 MQL5/Files/FCZ_Observer_latest.csv 是否生成。
```
