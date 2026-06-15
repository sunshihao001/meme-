# GitHub 与 CI 接入规划 v0.1

> 版本：v0.1  
> 分线：工程化交接线 / GitHub运维线 / CI质量门禁线  
> 状态：规划草案；当前本地目录尚未检测到 git repo，当前环境未检测到 gh CLI。  

---

## 1. 当前探测结果

在项目目录执行检查后得到：

```text
当前目录不是 git repository
未检测到 gh CLI：gh: command not found
GITHUB_TOKEN 环境变量状态：未在输出中暴露；需要 owner 确认 token 来源
```

因此当前不能直接执行：

```text
gh issue create
gh pr create
git push
gh workflow run
```

---

## 2. 目标

将当前项目接入 GitHub，使以下工程闭环可执行：

```text
本地文件变更
-> git branch
-> commit
-> push
-> GitHub issue
-> PR
-> GitHub Actions CI
-> owner review/merge
```

---

## 3. 推荐 GitHub 接入方式

### 3.1 推荐默认路径

```text
1. owner 确认或创建 GitHub repo。
2. 在当前项目目录初始化 git 或将项目移动/复制到已存在 repo。
3. 设置 origin remote。
4. 使用 GitHub token 走 git + curl fallback，或安装 gh CLI。
5. 先创建 issue，不直接创建 PR。
6. 接入 GitHub Actions CI，仅运行 python scripts/validate_all.py。
```

---

## 4. 需要 owner 决策

### Decision 1：repo 来源

```text
A. 使用已有 GitHub repo
B. 创建新 GitHub repo
C. 暂时只保留本地，不推 GitHub
```

推荐：

```text
A，如果已有 repo；否则 B。
```

需要 owner 提供：

```text
repo URL 或 owner/repo 名称
```

---

### Decision 2：认证方式

```text
A. 安装并使用 gh CLI
B. 使用 GITHUB_TOKEN + git/curl
C. 使用 SSH key
```

当前环境：

```text
gh CLI 未安装
```

推荐：

```text
如果你已经有 key/token，先用 GITHUB_TOKEN + git/curl；后续再决定是否安装 gh。
```

---

### Decision 3：CI 接入范围

第一版 CI 只做：

```text
python scripts/validate_all.py
```

不做：

```text
MQL5 编译
Playwright
部署
安全扫描
release
```

原因：

```text
当前项目没有确认 UI，也没有确认 MT5 编译环境；先接最小质量门禁。
```

---

## 5. GitHub Actions Workflow 草案

建议文件：

```text
.github/workflows/validate.yml
```

内容草案：

```yaml
name: Validate Project

on:
  pull_request:
  push:
    branches: [main]

jobs:
  validate:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Set up Python
        uses: actions/setup-python@v5
        with:
          python-version: '3.11'

      - name: Run project validation
        run: python scripts/validate_all.py
```

---

## 6. Git 初始化 / 远程接入命令草案

如果当前目录要变成 repo：

```bash
git init
git branch -M main
git add .
git commit -m "chore: initialize project knowledge base and validation gates"
git remote add origin https://github.com/<owner>/<repo>.git
git push -u origin main
```

如果已有 repo，只需设置 remote：

```bash
git remote add origin https://github.com/<owner>/<repo>.git
```

注意：执行前必须确认：

```text
repo URL
是否允许提交全部本地资料
是否有需要排除的敏感文件
```

---

## 7. 安全检查

推送 GitHub 前必须检查：

```text
1. 是否存在 token / key / password / .env
2. 是否存在私有交易数据
3. 是否存在不应公开的截图或 raw_data
4. 是否需要 .gitignore
```

建议先创建：

```text
.gitignore
```

至少忽略：

```text
.env
*.key
*.pem
*.log
__pycache__/
.pytest_cache/
.venv/
venv/
```

---

## 8. 本版结论

当前不能直接使用 gh，因为：

```text
1. 当前目录不是 git repo。
2. 当前环境未安装 gh CLI。
```

但 GitHub 接入路径已明确。

推荐下一步：

```text
先创建 .gitignore 与 GitHub Actions workflow 草案；
等 owner 提供 repo URL / 授权后，再执行 git init / remote / push / issue / PR。
```
