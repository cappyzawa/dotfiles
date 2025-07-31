---
allowed-tools: Bash(claude mcp add:*)
description: 現在のプロジェクトに Serena MCP サーバーを追加
model: sonnet
---

# Serena MCP サーバー追加

現在のプロジェクトに Serena MCP サーバーを追加します。

Serena は Language Server Protocol を使用してセマンティックなコード解析・編集機能を提供し、Claude Code の能力を大幅に向上させます。

## 実行されるコマンド

```bash
claude mcp add serena -- uvx --from git+https://github.com/oraios/serena serena start-mcp-server --context ide-assistant --project $(pwd)
```

## 機能

- **シンボルレベルのコード理解**: grep に代わる正確なコード検索
- **IDE レベルの操作**: Go to Definition、Find References など
- **多言語対応**: Go, Rust, TypeScript, Python, Java, C# など
- **効率的なトークン使用**: API コスト削減

## 使用後の流れ

1. Serena が追加されたら新しい会話を開始
2. 「プロジェクトをアクティベートして」でプロジェクトを認識させる
3. シンボルレベルでの高度なコード操作が利用可能

grep での検索と比較して大幅な効率向上が期待できます。
