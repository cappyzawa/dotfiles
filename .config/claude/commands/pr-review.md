---
allowed-tools: mcp__github__get_pull_request, mcp__github__get_pull_request_comments, mcp__github__get_pull_request_reviews, mcp__github__get_issue_comments, mcp__github__get_pull_request_files, mcp__github__add_issue_comment, mcp__github__create_and_submit_pull_request_review, Read, Write, mcp__filesystem__read_text_file, mcp__filesystem__write_file
description: 提出した PR への Review コメントを効率的に対応（状態管理付き）
argument-hint: <owner/repo> <PR番号> [--reset]
model: sonnet
---

# PR Review 対応コマンド

提出した PR に対するすべての種類のコメント（PR comments, Review comments, Issue comments）を統合的に確認し、未対応のコメントのみに効率的に対応します。

## 機能

- **統合的なコメント収集**: 3種類のコメントを一括で取得・整理
- **永続的な状態管理**: `.claude/pr-review-{PR番号}.json` で対応済みコメントを記録
- **効率的なトークン使用**: 対応済みコメントは再度処理しない
- **インクリメンタル処理**: 新規コメントのみを対象として処理

## 対象となるコメント種類

1. **Issue Comments**: PR全体への一般的なコメント（PRはIssueとしても扱われる）
2. **Review Comments**: 特定のコード行に対するレビューコメント
3. **Pull Request Reviews**: レビュー全体のコメント

## 状態管理ファイル

```json
{
  "pr_number": 123,
  "owner": "cappyzawa",
  "repo": "example-project",
  "last_checked": "2025-01-11T10:30:00Z",
  "handled_comments": {
    "issue_comments": ["1234567", "1234568"],
    "review_comments": ["9876543", "9876544"],
    "reviews": ["5555555"]
  }
}
```

## 動作フロー

1. `.claude/pr-review-{PR番号}.json` から前回の状態を読込
2. PR の基本情報を取得
3. すべての種類のコメントを並行して収集
4. 対応済みコメント（handled_comments）を除外
5. 未対応のコメントのみを表示・対応
6. 対応完了後に状態ファイルを更新

## 使用方法

```bash
/pr-review cappyzawa/example-project 123
/pr-review cappyzawa/example-project 123 --reset  # 状態をリセット
```

引数 `$ARGUMENTS` から自動的に解析：

- 第1引数: `owner/repo` 形式のリポジトリ指定
- 第2引数: PR番号
- 第3引数（オプション）: `--reset` で状態ファイルをリセット

## 対応完了の記録

コメントに対応した際は、該当するコメントIDを状態ファイルの `handled_comments` に自動追加します。これにより次回実行時はそのコメントを無視し、効率的な処理が可能です。

Token消費を最小限に抑えながら、確実に新規コメントを見落とすことなく対応できます。

---

引数解析例:

```
$ARGUMENTS = "cappyzawa/example-project 123 --reset"
→ owner: cappyzawa, repo: example-project, PR: 123, reset: true
```
