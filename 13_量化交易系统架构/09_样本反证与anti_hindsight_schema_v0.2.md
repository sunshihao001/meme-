# 样本反证与 anti-hindsight schema v0.2

> 分线：13_量化交易系统架构 / 样本反证与防后验  
> 状态：v0.2 / C端 v0.2 深度理论第四切片落库  
> 上游入口：`13_量化交易系统架构/06_C端v0.2深度理论落库总纲.md`、`13_量化交易系统架构/07_FCZ状态机专题_v0.2.md`、`13_量化交易系统架构/08_GMGN_data_to_state_mapper_v0.2.md`  
> 关联旧真源：`07_样本标注/`、`09_规则与回测/反证实验设计_v0.1.md`、`09_规则与回测/策略反证样本库设计_v0.1.md`  
> 边界：本文只定义样本、反证、防后验与审计 schema；不接入 API key/private key，不做 swap，不做自动下单，不宣称策略有效。

---

## 1. 本文要解决的问题

当前 13 分线已经具备：

```text
1. 系统总览与阶段门。
2. FCZ observe-only 状态机。
3. GMGN data-to-state mapper。
```

但如果没有样本反证与 anti-hindsight schema，状态机仍可能退化为：

```text
看到成功结果 → 回头移动 FCZ 边界 → 解释为模型有效
```

本文把第四切片固化为：

```text
sample evidence contract
+ counterexample taxonomy
+ anti-hindsight lock
+ evidence provenance
+ falsification review gate
```

目标不是证明模型能赚钱，而是让每一次 FCZ 状态判断都能被追溯、质疑、反证和复盘。

---

## 2. 样本不是截图印象

样本记录不是：

```text
一张成功图
一次喊单截图
事后解释
单个 token 暴涨故事
```

样本记录必须是：

```text
1. 有 sample_id。
2. 有 token / chain / time window。
3. 有 raw refs 或明确 missing 标记。
4. 有 FCZ lock 的时间点和数据截断点。
5. 有状态机路径。
6. 有 positive / negative / missing evidence。
7. 有 outcome window，但 outcome 不得反写前置状态。
8. 有反证分类或不可判定原因。
```

---

## 3. 最小 sample evidence object

后续每个 GMGN + FCZ 样本至少应能表达为：

```text
sample_id
sample_version
chain
token_address
token_symbol_optional
source_provider = gmgn
source_snapshot_refs
raw_ref_paths
manual_note_refs
sample_created_at
sample_updated_at
observer

pre_observation_window_start
pre_observation_window_end
data_cutoff_at
fcz_lock_timestamp
outcome_window_start
outcome_window_end

initial_state
final_observe_state
state_path
state_transition_evidence
reason_codes

positive_evidence
negative_evidence
missing_evidence
data_quality_flags
risk_flags
manual_review_required
counterexample_class
falsification_status
anti_hindsight_lock
was_boundary_moved_after_outcome
```

字段解释：

```text
pre_observation_window_*：只允许用于判断前置结构的数据窗口。
data_cutoff_at：mapper 计算特征时允许看到的最后时间点。
fcz_lock_timestamp：FCZ 边界被锁定的时间，不得晚于 outcome window。
outcome_window_*：只用于事后评估，不得进入前置特征计算。
```

---

## 4. 样本类型 taxonomy

当前 v0.2 至少区分：

```text
SUCCESS_CONFIRMED
  模型前置状态满足，后续 outcome 与 watch/candidate 假设一致。

FAILURE_AFTER_VALID_SETUP
  前置状态符合，但后续失败；这是最重要的反证样本。

FALSE_POSITIVE_RISK
  看似结构漂亮，但风险字段、流动性、holder、wash trading 或安全字段否定。

MISSED_RUN
  模型没有给出 watch/candidate，但 token 后续上涨；用于检查漏判。

DEATH_POOL_MISCLASSIFIED
  死亡盘/不可交易盘被误判成 deep wash/recovery。

UNEXECUTABLE_LIQUIDITY
  图形结构成立，但流动性、滑点、交易成本使其不可执行。

DATA_INSUFFICIENT
  数据不足，不能判断。

SOURCE_CONFLICT
  GMGN 与其他来源或不同快照冲突，不能直接判定。

HINDSIGHT_CONTAMINATED
  发现使用了 outcome 之后的数据反推边界。
```

---

## 5. 反证优先级

反证样本优先级高于成功样本：

```text
1. FAILURE_AFTER_VALID_SETUP
2. DEATH_POOL_MISCLASSIFIED
3. FALSE_POSITIVE_RISK
4. UNEXECUTABLE_LIQUIDITY
5. MISSED_RUN
6. SOURCE_CONFLICT
7. DATA_INSUFFICIENT
8. SUCCESS_CONFIRMED
```

原因：

```text
成功样本容易被事后解释污染；失败样本更能暴露规则边界、风险过滤和状态机误判。
```

---

## 6. Anti-hindsight lock

每个样本必须回答：

```text
在 outcome 发生之前，系统到底能看到什么？
```

因此必须显式记录：

```text
data_cutoff_at
fcz_lock_timestamp
features_computed_at
outcome_window_start
outcome_window_end
raw_snapshot_created_at
source_snapshot_refs
```

硬规则：

```text
1. fcz_high / fcz_low / poc / vah / val 不得使用 outcome_window_start 之后的数据计算。
2. deep_wash 不能用未来最低点事后定义。
3. recovery 不能用未来大阳线反推。
4. second_launch_watch 不能用已经发生的二次拉升反推。
5. 如果边界被移动，必须记录 was_boundary_moved_after_outcome = true，并将样本降级为 HINDSIGHT_CONTAMINATED。
```

---

## 7. evidence refs 规则

每个状态转移都必须绑定证据引用：

```text
state_transition:
  from_state
  to_state
  transition_at
  reason_codes
  evidence_refs
  missing_evidence
  invalidation_rule
```

evidence_refs 可以指向：

```text
raw_refs/*.json
样本记录/*.md
GMGN snapshot path
manual_review_note
chart annotation note
mapper run report
```

禁止：

```text
1. 用聊天记忆当唯一证据。
2. 用“看起来像”当 reason-code。
3. 没有 evidence_refs 就进入 candidate。
4. 缺少风险字段却默认安全。
```

---

## 8. falsification status

每个样本的反证状态必须是以下之一：

```text
UNREVIEWED
  已记录但尚未审查。

NEEDS_MORE_DATA
  核心 raw refs 或时间窗口不足。

VALID_PRE_OUTCOME_SAMPLE
  前置窗口、raw refs、fcz lock 都合格。

COUNTEREXAMPLE_ACCEPTED
  作为有效反证进入规则修正。

COUNTEREXAMPLE_REJECTED_DATA_QUALITY
  因数据问题不能作为反证。

HINDSIGHT_CONTAMINATED
  样本被后验污染，不得用于证明策略有效。

ARCHIVED_NOT_RELEVANT
  与 FCZ/GMGN 当前研究问题无关。
```

---

## 9. 与现有 07_样本标注 的关系

本文不替代 `07_样本标注/`，而是定义 13 分线下的系统级 schema。

归位关系：

```text
07_样本标注/样本记录/*.md
  → 人类可读样本记录。

07_样本标注/raw_refs/*.json
  → GMGN raw refs / fixture 证据。

07_样本标注/反证样本库_v0.1.csv
  → 当前 CSV 级反证索引。

13_量化交易系统架构/09_样本反证与anti_hindsight_schema_v0.2.md
  → 样本、反证、防后验和 evidence contract 的系统级约束。
```

后续 validator 可以逐步检查：

```text
1. sample_id 是否存在。
2. raw_ref_paths 是否存在。
3. data_cutoff_at 是否早于 outcome_window_start。
4. fcz_lock_timestamp 是否存在。
5. forbidden outcome leakage 字段是否出现。
6. counterexample_class 是否在 taxonomy 中。
```

---

## 10. 最小 markdown 样本段落模板

后续样本记录可逐步补充以下段落：

```md
## Anti-hindsight lock

- data_cutoff_at:
- fcz_lock_timestamp:
- features_computed_at:
- outcome_window_start:
- outcome_window_end:
- was_boundary_moved_after_outcome: false / true

## Evidence refs

- raw_ref_paths:
- source_snapshot_refs:
- manual_note_refs:

## State path

- initial_state:
- final_observe_state:
- state_path:
- reason_codes:

## Counterexample review

- counterexample_class:
- falsification_status:
- positive_evidence:
- negative_evidence:
- missing_evidence:
```

---

## 11. 本版结论

```text
样本库是 FCZ + GMGN 量化体系的验证真源，而不是附属材料。

没有 anti-hindsight lock 的样本，不得用于证明策略有效。

失败样本、误判样本、漏判样本和不可执行样本，比成功样本更优先进入规则修正。
```
