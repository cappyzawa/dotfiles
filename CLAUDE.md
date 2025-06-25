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

### パッケージ管理

1. **Homebrew**: macOS アプリケーションと CLI ツール（`Brewfile`）
2. **Aqua**: 宣言的 CLI バージョンマネージャー（`.config/aqua/aqua.yaml`）
3. **afx**: GitHub リポジトリと Zsh プラグインの管理（`.config/afx/`）

### 重要な統合

- **1Password**: GitHub トークンなどの認証情報管理
- **Starship**: カスタマイズ可能なプロンプト
- **tmux**: ターミナルマルチプレクサー（TPM でプラグイン管理）
- **Neovim**: LazyVim ベースの設定

## 開発時の注意事項

### PATH の設定

PATH は `.zprofile` で管理されています。新しいツールを追加する場合は、以下の形式で追加：

```bash
path=( \
    ~/.local/share/aquaproj-aqua/bin(N-/) \
    # ... その他のパス
)
```

`(N-/)` は Zsh のグロブ修飾子で、ディレクトリが存在する場合のみ追加します。

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

