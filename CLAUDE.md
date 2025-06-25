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
- `.zsh/`: モジュール化された Zsh 設定
  - `10_utils.zsh`: ユーティリティ関数
  - `20_keybinds.zsh`: キーバインド
  - `30_aliases.zsh`: エイリアス
  - `50_setopt.zsh`: Zsh オプション
  - `80_custom.zsh`: カスタム設定
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

3. **afx** (`.config/afx/`)
   - Zsh プラグインと設定ファイル
   - GitHub CLI (gh) プラグイン管理
   - GitHub リポジトリの直接管理
   - dotfiles 固有の拡張機能

### 重要な統合

- **1Password**: GitHub トークンなどの認証情報管理
- **Starship**: カスタマイズ可能なプロンプト
- **tmux**: ターミナルマルチプレクサー（TPM でプラグイン管理）
- **Neovim**: LazyVim ベースの設定

## 開発時の注意事項

### PATH の動的管理システム

`.zsh/05_path_manager.zsh` で提供される動的 PATH 管理システムを使用：

#### 基本的な使い方

```bash
# 高優先度で PATH に追加（先頭に追加）
path_add /path/to/bin

# 低優先度で PATH に追加（末尾に追加）
path_add /path/to/bin append

# 変数を含むパスの追加（後から変数が変更されても対応）
path_add '$CUSTOM_ROOT/bin'

# PATH から削除
path_remove /path/to/bin

# PATH の状態確認
path_debug
```

#### 利点

- **柔軟性**: 環境変数の変更後も正しく動作
- **順序制御**: 後から追加されたパスが優先される
- **重複排除**: 自動的に重複を排除
- **デバッグ**: `path_debug` で現在の状態を確認可能

#### 設定追加時の推奨パターン

```bash
# .zprofile: システム全体の基本パス
path_add ~/.local/bin

# 80_custom.zsh: 個別ツールの動的パス
export TOOL_ROOT=${TOOL_ROOT:-$HOME/.tool}
path_add '$TOOL_ROOT/bin'
```

### 環境変数

- `.zshenv`: 基本的な環境変数（履歴、XDG パス、CLAUDE_CONFIG_DIR など）
- `.zprofile`: PATH、言語設定、エディタ設定

### アーキテクチャ対応

ARM64 と x86_64 の両方に対応。切り替えは：

- `arm`: ARM64 アーキテクチャに切り替え
- `x64`: x86_64 アーキテクチャに切り替え

### 設定の追加・変更

1. 新しいツールの設定は `.config/` ディレクトリに配置
2. `Makefile` の `install` ターゲットにシンボリックリンクの作成を追加
3. パッケージは適切なマネージャーで管理（Homebrew なら `Brewfile`、Aqua なら `aqua.yaml`）

