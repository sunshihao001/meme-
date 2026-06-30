# A/B/C/D/E/F 端口强制 Handoff 规则 v0.1

> 分线：10_工程化交接 / 工作流运行机制
> 状态：v0.1 / 强制运行规则草案
> 目标：解决“工作流文件存在，但实际输入仍绕过 A 端、B/C/D/E/F 直接回答”的问题。
> 原则：A 是默认入口门；B/C/D/E/F 只接上游 handoff，不直接接收原始输入。

---

## 1. 核心问题

当前工作流已经具备：

```text
dbs 路由默认入口
A 端默认入口与跳过条件规则
A/B/C 前置研究循环
A/B/C 正式合同提速版
A-F 端口主 skill
workflow state / queue
```

但实际使用中仍可能发生：

```text
用户新输入
→ 直接被某个端口处理
→ 没有 dbs 路由
→ 没有 A 端最小澄清
→ 没有 handoff
→ 工作流看似存在，但没有真正跑起来
```

所以本规则要补的是：

```text
端口接收纪律。
```

---

## 2. 总规则

```text
1. 用户新输入默认先过 dbs 路由。
2. dbs 路由后进入 A 端最小澄清。
3. A 端生成最小 handoff。
4. B/C/D/E/F 只接收上游 handoff，不直接接收原始用户输入。
5. 如果没有 handoff，下游端口必须打回 A 端。
```

一句话：

```text
没有 handoff，就没有下游执行。
```

---

## 3. 标准 Handoff 包

任何端口向下游移交时，至少包含：

```text
1. From Port：来自哪个端口
2. To Port：交给哪个端口
3. Task Type：澄清 / 搜索 / 理论 / 落库 / 验证 / 决策
4. Objective：本轮目标
5. Inputs：输入文件 / 上游结论 / 证据包
6. Boundaries：允许范围
7. Forbidden：禁止事项
8. Expected Output：期望输出
9. Stop / Return Conditions：停止或打回条件
```

最小版可以压缩为：

```text
From:
To:
Goal:
Input:
Boundary:
Expected:
Return if:
```

---

## 4. A 端 Handoff 规则

### 4.1 A 端接收什么

A 端可以接收：

```text
- 用户原始输入
- dbs 路由结果
- 上一轮状态恢复结果
- F 端 Owner 决策
- E 端打回意见
```

### 4.2 A 端必须输出什么

A 端至少输出：

```text
- 问题类型
- 当前核心想法
- 当前缺口
- 推荐下一端口
- 跳过/不跳过 A 的理由
- 最小 handoff 包
```

### 4.3 A 端不能做什么

```text
- 不直接写最终理论。
- 不替 B 搜索资料。
- 不替 C 生成长理论。
- 不替 D 落库。
- 不替 E 验证。
- 不替 F 做 Owner 最终决策。
```

---

## 5. B 端 Handoff 规则

### 5.1 B 端只接收

```text
- A 端搜索任务单
- A 端知识缺口定义
- A 端指定的资料范围
- 已授权的本地文件/外部来源范围
```

### 5.2 没有以下内容，B 端必须打回 A

```text
- 搜索目标不清
- 关键词/来源范围不清
- 返回格式不清
- 不知道资料要给 C 端还是只入储备库
```

### 5.3 B 端输出

```text
- Search / Compression Brief
- Source Pack
- Evidence Summary
- Gaps / Conflicts / Unknowns
- Handoff to A or C
```

### 5.4 B 端禁止

```text
- 不写最终理论。
- 不直接让 Codex 生成方案。
- 不直接改 repo。
- 不把未知填成结论。
```

---

## 6. C 端 Handoff 规则

### 6.1 C 端只接收

```text
- A 端问题框架
- B 端 Source Pack
- A 端吸收判断
- 明确的理论生成任务
```

### 6.2 没有以下内容，C 端必须打回

```text
- A 端目标不清 → 打回 A
- B 端证据不足 → 打回 B
- 是否进入 deep_path 不清 → 打回 A / Owner
- 输出用途不清 → 打回 A
```

### 6.3 C 端输出

```text
- Short Theory Package
- C-research 草案
- C-execution 接口包
- Downstream Landing Plan
- Handoff to D/E
```

### 6.4 C 端禁止

```text
- 不绕过 A/B 直接写长理论。
- 不直接改 repo。
- 不把浅草稿冒充深度理论包。
- 不把推测写成已验证结论。
```

---

## 7. D 端 Handoff 规则

### 7.1 D 端只接收

```text
- C-execution 接口包
- A 端或 Owner 明确授权
- E 端允许落库意见（如适用）
- 明确 allowed paths / forbidden paths
```

### 7.2 没有以下内容，D 端必须打回

```text
- 没有落库授权 → 打回 A/F
- 没有文件范围 → 打回 C/A
- 没有验证要求 → 打回 E/A
- 涉及敏感路径或交易执行 → 打回 Owner/F
```

### 7.3 D 端输出

```text
- Changed Files
- Index / Change Log Updates
- Validation Commands
- Git Commit / Push Result
- Handoff to E
```

### 7.4 D 端禁止

```text
- 不重新发明理论方向。
- 不绕过 E/F。
- 不触碰私钥/API/交易执行。
- 不静默删除或移动历史资料。
```

---

## 8. E 端 Handoff 规则

### 8.1 E 端只接收

```text
- C 端理论包
- D 端落库记录
- git diff / changed files
- validate_all / diff --check / CI 输出
- 明确验收标准
```

### 8.2 没有以下内容，E 端必须打回

```text
- 没有真实文件路径 → 打回 D/C
- 没有验证命令输出 → 打回 D
- 没有验收标准 → 打回 A/C
- 没有风险边界 → 打回 A/F
```

### 8.3 E 端输出

```text
- Verification Report
- PASS / PARTIAL / FAIL
- Risk Check
- Owner Decision Brief candidate
- Return-to-A/B/C/D instruction
```

### 8.4 E 端禁止

```text
- 不替 D 改文件。
- 不凭 maker 自述宣布完成。
- 不跳过真实验证输出。
- 不替 Owner 做最终授权。
```

---

## 9. F 端 Handoff 规则

### 9.1 F 端接收

```text
- E 端 Owner Decision Brief
- A 端阶段门问题
- 需要 Owner 授权的风险/方向/范围问题
```

### 9.2 F 端输出

```text
- ACCEPT
- PARTIAL_ACCEPT
- REVISE
- REJECT
- RESERVE_ONLY
- CONTINUE_RESEARCH
- AUTHORIZE_D_LANDING
- STOP
```

### 9.3 F 端不是

```text
- 不是技术执行端。
- 不是 E 端验证替代品。
- 不是 dbs-decision 的自动结论。
```

---

## 10. 打回规则

```text
B 没搜索任务单 → 回 A
C 没 A+B 输入 → 回 A/B
D 没 C-execution 或授权 → 回 C/A/F
E 没真实验证材料 → 回 D/C
F 没 decision brief → 回 E/A
```

打回时必须输出：

```text
Return To:
Missing:
Why blocked:
Minimum fix:
```

---

## 11. fast_path 最小运行格式

为了不变慢，每轮可以只输出：

```text
【dbs 路由】问题类型 / 推荐能力包
【A 端判断】核心想法 / 缺口 / 下一端口
【Handoff】From / To / Goal / Input / Expected / Return if
```

只有当涉及：

```text
baseline 修改
外部技能大量接入
长理论生成
repo 落库
Owner 授权
```

才展开 deep_path。

---

## 12. 本版结论

```text
工作流实际用不起来的关键原因，是端口可以绕过入口和 handoff。
本规则把 A 端变成默认入口，把 B/C/D/E/F 变成只接上游包的专职端口。
```

---

## 13. 下一步

```text
1. 将本规则加入知识库索引与变更记录。
2. 如需更强约束，再把“只接 handoff”分别写入 B/C/D/E 端主 skill。
3. 后续可以用真实输入样例验证：是否真的先 dbs → A → handoff。
```