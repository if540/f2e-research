# f2e-research

前端技術趨勢每日分析報告庫。

## 每日 Routine 流程

1. 收集 GitHub Trending（整體 + JS / Python / TypeScript / Rust / Go）
2. 收集 HackerNews Top 50 + Ask/Show HN
3. 套用熱度公式：`GitHub 今日 ⭐ × 3 + HN 分數 × 1 + 提及次數 × 2`
4. 產出 TOP 20 排行，撰寫繁體中文報告
5. 存檔至 `reports/YYYY-MM-DD-trending.md` 與 `reports/latest.md`
6. Commit message 格式：`report: daily trending YYYY-MM-DD`
7. 執行推送與建立 PR：

```bash
export GITHUB_TOKEN=<your-pat>
bash scripts/push-report.sh <branch-name> <YYYY-MM-DD>
```

## 環境需求

| 項目 | 說明 |
|------|------|
| `GITHUB_TOKEN` | GitHub Personal Access Token，需有 `repo` scope |

### 設定 GITHUB_TOKEN（一次性）

在 Claude Code 遠端環境設定中加入：

```
GITHUB_TOKEN=ghp_xxxxxxxxxxxx
```

路徑：**claude.ai/code → 你的 session 設定 → Environment variables**

設定後，未來每次 routine 執行時腳本會自動取用，不需手動輸入 token。

## 目錄結構

```
reports/
  YYYY-MM-DD-trending.md   # 每日報告
  latest.md                # 最新報告的捷徑
scripts/
  push-report.sh           # 推送 + 建立 PR 的自動化腳本
```
