# CLAUDE.md

## Common

- 会話は基本的に日本語で行います
  - 全角と半角の間に半角スペースを入れてしまう派です
  - 会話が日本語であれば構わないため、Thinking は英語でも問題ありません。
- 変更対象の Repository に `CONTRIBUTING.md` が存在する際はそちらに従ってください

## Commit

- 全ての Commit は署名をしてください
  - `git commit -s`
- Commit Message は英語で記述してください
  - Commit Message を作成する前に、必ず `git diff --staged` でステージされた変更内容を確認してください
    - 実際の変更内容を正確に反映してください
    - 複数の機能や変更が含まれる場合は、それぞれを明記してください
  - タイトルは50文字以内
  - 詳細なメッセージは72文字で折り返し

## Language

### Rust

- コードの提案を行うときは、それが `cargo clippy` で指摘事項がないかチェックしてください
