# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## リポジトリ概要

これは macOS 用の dotfiles リポジトリです。シェル設定、開発ツール、各種アプリケーション設定を管理しています。

## ビルド・インストールコマンド

### 初期セットアップ

```bash
# 全体のセットアップ（Homebrew インストールと dotfiles の配置）
make all

# 個別のセットアップ
make brew     # Homebrew のインストールと Brewfile からパッケージをインストール
make install  # dotfiles のシンボリックリンクを作成
```

### クリーンアップ

```bash
make clean    # dotfiles のシンボリックリンクとリポジトリを削除
```

## アーキテクチャと構造

### ディレクトリ構造

- ルートレベル: 主要な設定ファイル（`.zshrc`, `.tmux.conf`, `.gitconfig` など）
- `.config/`: XDG Base Directory 仕様に従ったアプリケーション固有の設定
  - `zsh/`: モジュール化された Zsh 設定（sheldon で読み込み）
    - `00_path.zsh`: PATH 設定
    - `10_aliases.zsh`: エイリアス
    - `20_keybinds.zsh`: キーバインド
    - `30_fzf.zsh`: fzf 設定
    - `40_integrations.zsh`: ツール統合（direnv, AWS CLI, Starship）
    - `50_options.zsh`: Zsh オプション
    - `60_gh-extensions.defer.zsh`: gh extensions 管理（遅延ロード）
  - `sheldon/`: sheldon プラグイン設定
  - `aqua/`: aqua パッケージ設定
- `etc/scripts/`: インストールスクリプト

### パッケージ管理戦略

明確な使い分けに基づいて3つのパッケージマネージャーを使用：

1. **Homebrew** (`Brewfile`)
   - システムレベルのツール（git, curl など）
   - GUI アプリケーション（Alacritty, Docker など）
   - システム統合が必要なツール（fonts, drivers など）

2. **Aqua** (`.config/aqua/aqua.yaml`)
   - 開発用 CLI ツール（kubectl, terraform, golang など）
   - バージョン管理が重要なツール
   - チーム間で統一したいツール

3. **Sheldon** (`.config/sheldon/plugins.toml`)
   - Zsh プラグイン管理
   - ローカル設定ファイルの読み込み（`.config/zsh/*.zsh`）
   - zsh-defer による遅延ロード対応

### 重要な統合

- **1Password**: GitHub トークンなどの認証情報管理
- **Starship**: カスタマイズ可能なプロンプト（遅延ロード対応）
- **tmux**: ターミナルマルチプレクサー（TPM でプラグイン管理）
- **Neovim**: LazyVim ベースの設定

### パフォーマンス最適化

#### 遅延ロードシステム

sheldon + zsh-defer による遅延ロードで高速起動を実現：

- **zsh-defer**: 重い初期化処理を遅延実行
- **gh extensions**: バックグラウンドで未インストールの extensions をインストール

#### 読み込み順序

1. `.zshenv`: 環境変数と基本 PATH（~/bin, aqua）
2. `.zprofile`: Homebrew 初期化
3. `.zshrc`: compinit + sheldon source（プラグインと `.config/zsh/*.zsh` を読み込み）

## 開発時の注意事項

### PATH 管理

`.config/zsh/00_path.zsh` で PATH を管理：

- `typeset -U path` で重複を自動排除
- 優先度の高いパスは先頭に prepend
- 優先度の低いパスは末尾に append

### 環境変数

- `.zshenv`: 基本的な環境変数（履歴、XDG パス、CLAUDE_CONFIG_DIR など）
- `.zprofile`: Homebrew 初期化
- `.config/zsh/00_path.zsh`: 詳細な PATH 設定

### アーキテクチャ対応

ARM64 と x86_64 の両方に対応。切り替えは：

- `arm`: ARM64 アーキテクチャに切り替え
- `x64`: x86_64 アーキテクチャに切り替え

### 設定の追加・変更

1. 新しいツールの設定は `.config/` ディレクトリに配置
2. `Makefile` の `install` ターゲットにシンボリックリンクの作成を追加
3. パッケージは適切なマネージャーで管理（Homebrew なら `Brewfile`、Aqua なら `aqua.yaml`）
