# Tomohiro Yoshida — academic website

日本語・英語・イタリア語に対応した個人研究サイト。

## 更新する

以下のファイルを開き、既存の項目をコピーして書き換え、保存します。
論文・発表は一度の編集で3言語に反映されます。

- 論文: [_data/publications.yml](_data/publications.yml)
- 発表: [_data/talks.yml](_data/talks.yml)
- CV: [_data/career.yml](_data/career.yml)
- プロフィール・翻訳: [_data/site_text.yml](_data/site_text.yml)
- 研究本文: `_includes/academic/research-ja.md`（英語は `-en.md`、イタリア語は `-it.md`）

**コピー用の例と公開手順: [更新方法](docs/UPDATING.md)**

GitHub上の編集画面でも更新できます。公開ブランチへ変更を反映すると、GitHub Pagesがサイトを生成します。

## デザイン

- 共通テンプレート: `_layouts/academic.html`
- ヘッダー: `_includes/academic/masthead.html`
- 表示調整: `assets/css/academic.css`
- 配色: `_sass/_variables.scss`

## クレジット

AcademicPages / Minimal Mistakesをベースにしています。Minimal Mistakes © 2016 Michael Rose、MIT License。ライセンスは [LICENSE](LICENSE) を参照してください。

## フォルダ案内

普段の更新は `_data/` と研究本文だけで完結します。

| フォルダ | 用途 |
| --- | --- |
| `_data/` | 論文・発表・経歴・3言語の文章 |
| `_includes/academic/` | 研究本文とページの部品 |
| `_pages/` | 各言語のURL設定、404、サイトマップ |
| `_layouts/` | 共通のページ構造 |
| `images/` | 使用中の顔写真と研究アニメーション |
| `assets/`・`_sass/` | デザイン、フォント、動作に必要なテーマ部品 |
| `docs/` | 更新手順 |
| `scripts/` | サイトの確認用Rubyスクリプト（通常の更新には不要） |
| `_site/` | 自動生成されるプレビュー。直接編集しません |

`_config.yml` はサイト設定、`Gemfile` はJekyllの依存関係、`LICENSE` は利用元テーマのライセンスです。`google0387967501c2b08f.html` はGoogleの所有権確認用です。
