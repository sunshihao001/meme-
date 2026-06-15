# GitHub上传接入说明 v0.1

> 分线：10_工程化交接  
> 目的：把当前本地知识库安全上传到 GitHub 仓库，并明确 AI 工作流中的上传边界。  
> 状态：上传前执行记录 / 待凭证 push  
> 目标仓库：`https://github.com/sunshihao001/meme-`

---

## 1. 当前项目现实

```text
本地项目路径：C:/Users/Administrator/Documents/MQL5_第一控盘区成本中枢回收模型_学习资料
远程仓库：sunshihao001/meme-
远程默认分支：main
远程当前内容：仅 README.md / Initial commit
本地初始状态：尚未初始化为 git 仓库
本机 GitHub CLI：未安装
本机 GitHub 认证：未检测到 gh 登录
本地 git identity：上传前需配置 user.name / user.email
```

---

## 2. 按 AI 工作流的上传顺序

```text
1. 项目现实检查：确认本地目录、AGENTS.md、SOURCE_OF_TRUTH.md、项目 skill、远程仓库状态。
2. 上传边界确认：本次只做项目入库，不做策略内容扩写，不覆盖远程历史。
3. 安全初始化：git init，设置 main 分支，添加 origin。
4. 保留远程 README：fetch origin/main 后以 allow-unrelated-histories 合并，避免覆盖远程初始提交。
5. 本地验证：运行 scripts/validate_all.py。
6. 本地提交：提交当前知识库快照。
7. 凭证 push：由 owner 提供 GitHub PAT 或完成登录后推送到 origin/main。
8. 上传后验证：检查 GitHub 仓库文件、Actions/validate 工作流状态。
```

---

## 3. 本次上传不做什么

```text
1. 不 force push。
2. 不删除远程 README。
3. 不上传凭证、token、密钥或本地虚拟环境。
4. 不把观察指标包装成自动交易系统。
5. 不在未认证状态下假装 push 成功。
```

---

## 4. 推荐 owner 操作

如果当前机器没有 GitHub 凭证，推荐使用 Personal Access Token：

```text
1. 打开 https://github.com/settings/tokens
2. Generate new token classic
3. 勾选 repo；如果要触发/管理 Actions，再勾选 workflow
4. 复制 token
5. 在终端 push 时：
   Username 输入 GitHub 用户名
   Password 输入 token，不是 GitHub 登录密码
```

---

## 5. 完成标准

```text
1. git status clean。
2. origin 指向 https://github.com/sunshihao001/meme-.git。
3. main 分支包含本地知识库文件与远程 README。
4. GitHub 页面能看到 AGENTS.md / SOURCE_OF_TRUTH.md / 00-12 目录 / scripts / tests / .github/workflows/validate.yml。
5. GitHub Actions validate 工作流可运行，或至少本地 scripts/validate_all.py 已通过。
```
