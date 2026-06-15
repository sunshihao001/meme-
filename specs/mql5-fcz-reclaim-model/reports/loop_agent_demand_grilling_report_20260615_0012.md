# Loop Agent Demand Grilling Report — 20260615_0012

> 项目：mql5-fcz-reclaim-model  
> run_mode：manual  
> loop_type：theory_evolution / loop_self_patch  
> output_type：TYPE_I_LOOP_SELF_PATCH + TYPE_H_EXTERNAL_CONCEPT_ABSORPTION  
> authority：Autonomous  
> 状态：v0.1 / 搜索前语义转译层运行报告

---

## 1. problem_world / solution_world / shared_phenomena

```text
problem_world：Owner 指出需求拷问端虽然知道要搜索外部来源，但仍可能把 Owner 的中文口语、个人语义、项目内部叫法直接当作搜索词，导致搜不到成熟概念，或搜到了语义相似材料但没有理解 Owner 真正想表达的整体问题。

solution_world：Agent 可以在需求拷问端中增加“搜索前语义转译层”，把 Owner 原话转译为专业概念族、多语言检索式、多视角查询，并记录查询漂移风险与检索失败模式。

shared_phenomena：Owner 原始表达、Agent 的语义理解、专业领域词汇、外部文档语料、搜索引擎/RAG 检索机制之间存在 vocabulary mismatch / query-document gap。
```

---

## 2. concept_map_seed / issue_tree_seed

### concept_map_seed

```text
Owner 原始表达 → 需要语义理解 → 形成信息需求
信息需求 → 需要专业概念族 → 形成可检索表达
可检索表达 → 需要多语言/多视角变体 → 提升召回
外部来源 → 需要证据分类 → 防止 query drift
检索结果 → 回流需求拷问端 → 改进内部认知缺口
```

### issue_tree_seed

```text
Root：为什么“知道要外部搜索”仍然搜不到真正有用的补全材料？

A. 表层词问题：Owner 使用的是个人语义/中文口语，外部资料使用专业术语。
B. 语言问题：中文表达不一定对应外部主流资料语言，需要英文/平台语言/领域术语。
C. 粒度问题：直接搜太窄，需要 step-back 到上位概念。
D. 结构问题：一个请求混合多个问题，需要 decomposition 成子查询。
E. 风险问题：扩展词可能产生 query drift，搜到看似相关但偏离 Owner 意图的材料。
```

---

## 3. 搜索前语义转译证据

```text
owner_surface_terms：外部来源、概念语义、关键词搜索、词语表达不对、中文用户、搜索不到、论坛成品、拼接补全。

interpreted_information_need：需求拷问端需要一种搜索前的 query understanding / query transformation 机制，把用户自然语言转成专业、跨语言、可检索、可验证的查询族，而不是机械搜索用户原词。

professional_concept_family：vocabulary mismatch；query reformulation；query rewriting；query expansion；query transformation；query-document gap；cross-lingual information retrieval；multilingual query expansion；step-back prompting；HyDE；multi-query retrieval；problem decomposition。

query_transformation_strategy：rewrite + expansion + decomposition + step-back + multilingual；HyDE 作为可选策略，用于把口语问题转成更像外部文档的假想答案/资料段落再检索。

retrieval_failure_mode：词汇不匹配 + 语言不匹配 + 查询过窄 + 多问题混合 + 潜在 query drift。
```

### search_query_variants

```text
semantic query expansion search terms formulation information retrieval user intent vocabulary mismatch
query reformulation vocabulary mismatch information retrieval semantic search multilingual query expansion
RAG query transformation query rewriting multi query retrieval user intent expansion
LLM query rewriting retrieval augmented generation multi query retriever HyDE step back prompting
vocabulary mismatch user information need query formulation information retrieval
site:langchain.com query transformation multi query retriever HyDE step back prompting
```

### query_drift_risk

```text
1. 只搜 RAG 技术可能偏离需求拷问端的人机协作目标。
2. 只搜 query expansion 可能停在信息检索算法，不足以覆盖问题空间建模。
3. 只搜 multilingual search 可能忽略 Owner 的整体语义理解问题。
4. 只搜论坛成品可能得到工程实现，但缺方法论边界。
```

---

## 4. external_search_sources / external_sources_absorbed

```text
external_search_sources：
1. LangChain Query Transformations：https://www.langchain.com/blog/query-transformations
2. Vocabulary mismatch：https://en.wikipedia.org/wiki/Vocabulary_mismatch
3. Query expansion：https://en.wikipedia.org/wiki/Query_expansion
4. Query Rewriting and Expansion in RAG：https://learnixo.io/blog/rag-query-rewriting
5. Which Query Transformation Techniques Actually Help RAG：https://alexchernysh.com/blog/query-transformation-for-rag
```

### absorbed findings

```text
confirmed_by_source：Query transformation 是在检索前修改/扩展用户问题，以提高 RAG / 搜索检索质量。
confirmed_by_source：Vocabulary mismatch 描述不同人用不同词表达同一概念，造成检索失败。
confirmed_by_source：Query expansion 通过同义词、相关词、形态变化、重权重等方式提高召回，但可能降低 precision。
confirmed_by_source：RAG query rewriting 常见技术包括 rewrite、multi-query、decomposition、step-back、HyDE、fusion。
confirmed_by_source：Query transformation 只有在能命名具体 retrieval failure mode 时才应使用，否则会增加复杂度。
```

---

## 5. current_convergence_slice

```text
把需求拷问端从“语义发散后直接外部搜索”升级为“语义发散 → 搜索前语义转译 / 查询改写 → 外部搜索 → 证据吸收 → 收敛切片”。
```

---

## 6. unchosen_branches / revisit_trigger

```text
unchosen_branches：
1. 暂不实现自动 query expansion 脚本；原因：当前先固化协议，避免过早工程化。
2. 暂不引入向量数据库/RAG；原因：项目当前仍以 Markdown + Git + validator 为主。
3. 暂不全量审计所有旧知识源；原因：本轮切片只修搜索前语义转译层。

revisit_trigger：
1. 后续多次外部搜索仍然召回差。
2. Owner 再次指出某个旧知识源“明明有但没搜到”。
3. 需要把内部旧知识库做成 searchable corpus / RAG。
4. 开始执行旧知识库接入债审计。
```

---

## 7. Runtime Skill Audit

### loaded

```text
dbs-good-question / references/semantic-divergence-before-convergence.md
spec-first-ai-engineering / references/demand-grilling-semantic-external-absorption.md
```

### referenced_only

```text
10_工程化交接/需求拷问端概念语义升级_外部概念吸收_v0.1.md
specs/mql5-fcz-reclaim-model/demand_theory_evolution_loop.md
specs/mql5-fcz-reclaim-model/loop_agent_demand_grilling_contract.md
```

### conditional_not_executed

```text
dbs-chatroom：本轮没有启动专家聊天室；问题已收敛为方法契约补丁，不需要先模拟多专家。
dbs-save / dbs-report：本轮状态写入项目 repo、索引、变更记录和 Git，不写 ~/.dbs 存档。
```

### forbidden

```text
交易执行
私钥
swap
gmgn-swap
gmgn-cooking
自动下单
未经授权 cron
未经授权合并 PR
```

---

## 8. 输出类型 / 权限分类 / 更新文件

```text
输出类型：TYPE_I_LOOP_SELF_PATCH + TYPE_H_EXTERNAL_CONCEPT_ABSORPTION
权限分类：Autonomous
```

更新文件：

```text
10_工程化交接/需求拷问端概念语义升级_外部概念吸收_v0.1.md
specs/mql5-fcz-reclaim-model/demand_theory_evolution_loop.md
specs/mql5-fcz-reclaim-model/loop_agent_demand_grilling_contract.md
specs/mql5-fcz-reclaim-model/reports/loop_agent_demand_grilling_report_20260615_0012.md
00_知识库设计规范/05_索引与变更记录/知识库索引_v0.1.md
00_知识库设计规范/05_索引与变更记录/设计规范变更记录.md
```

---

## 9. PROPOSED / UNKNOWN / REQUIRES_OWNER

```text
PROPOSED：后续可把搜索前语义转译做成 validator 或 query checklist。
UNKNOWN：是否需要引入 RAG/向量库来检索本地旧知识库，尚未决策。
REQUIRES_OWNER：如果要全量重构知识库检索系统或引入自动搜索脚本，需要 Owner 决策。
```

---

## 10. 验证输出

```text
待运行：python scripts/validate_all.py
```

---

## 11. 下一轮建议

```text
执行“旧知识库接入债审计 v0.1”：盘点旧资料、旧关键词、旧资料吸收、文章库、指标代码库哪些还没有进入新 AI 工作流的 internal recall / traceability / validator。
```
