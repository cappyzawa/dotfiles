# CLAUDE.md

## Common

- 会話は基本的に日本語で行います
  - 全角と半角の間に半角スペースを入れてしまう派です
  - 会話が日本語であれば構わないため、Thinking は英語でも問題ありません。
- 変更対象の Repository に `CONTRIBUTING.md` が存在する際はそちらに従ってください
- 更新するファイルにおいて、原則は改行で終了してください
  - No Newline at end of file でないことを確認してください
- 既存資産を優先的に活用してください
  - プロジェクト内の `internal/` ディレクトリを事前に調査する
  - 標準ライブラリや既存パッケージで解決できないか検討する
  - レビュアーとの対話で既存資産について積極的に質問する

## Commit

- 全ての Commit は署名をしてください
  - `git commit -s`
- Commit Message は英語で記述してください
  - Commit Message を作成する前に、必ず `git diff --staged` でステージされた変更内容を確認してください
    - 実際の変更内容を正確に反映してください
    - 複数の機能や変更が含まれる場合は、それぞれを明記してください
  - タイトルは50文字以内
  - 詳細なメッセージは72文字で折り返し
  - GitHub の予約語（Fixes, Closes, Resolves など）は使用しないでください
    - Issue や PR への言及も不要です
    - コミットメッセージは変更内容のみを記述してください

## Language

### Rust

- コードの提案を行うときは、それが `cargo clippy` で指摘事項がないかチェックしてください

## FluxCD 作業時の必須プロセス

FluxCD リポジトリでコード変更時は必ず以下を実行：

1. 作業開始前に Read tool で `~/ghq/src/github.com/cappyzawa/fluxcd-development-notes/knowledge/review-lessons.md` を確認し、最新の教訓を把握
2. 実装開始前に Read tool で `~/ghq/src/github.com/cappyzawa/fluxcd-development-notes/checklists/pre-implementation.md` を確認
3. PR作成前に Read tool で `~/ghq/src/github.com/cappyzawa/fluxcd-development-notes/checklists/pre-pr.md` を確認
4. PR説明書作成時に Read tool で `~/ghq/src/github.com/cappyzawa/fluxcd-development-notes/checklists/pr-description.md` を確認

## GitHub へのアクセスについて

- Web の Fetch ではなく、github mcp server でアクセスしてください
  - 会話において自分は Web リンクを提供すると思いますが、github mcp server でアクセスしてください
