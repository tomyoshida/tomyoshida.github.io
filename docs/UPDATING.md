# サイトの更新方法

このサイトはGitHub Pages標準のJekyllで生成します。新しい外部CMS、翻訳API、JavaScriptのビルド環境は不要です。

## 論文・発表を追加する

Pythonやターミナル操作は不要です。下記のデータファイルをテキストエディタで開き、既存の項目をコピーして書き換え、保存してください。1回の編集で3言語の一覧に反映されます。GitHubのファイル編集画面からも編集できます。

YAMLでは字下げにスペースを使います。各項目の先頭の `- title:` と、その下の2文字分の字下げを保ってください。

### 論文: `_data/publications.yml`

最新の論文をファイルの先頭に追加します。分類ごとに記載順で表示します。番号や件数を編集する必要はありません。

```yaml
- title: "正式な論文タイトル"
  url: "https://doi.org/実際のDOI"
  authors: "**Tomohiro C. Yoshida**, 共著者"
  citation: "2026, 雑誌名, 巻, ページ"
  year: 2026
  group: lead
```

`group` は主著なら `lead`、共著なら `coauthor`。タイトルは正式な原題を使います。必要なら `<sup>13</sup>` のような上付き文字を使用できます。著者欄はMarkdown対応です。

### 発表: `_data/talks.yml`

```yaml
- title: "正式な発表題目"
  authors: "**Tomohiro C. Yoshida** et al."
  format: "Oral (invited)"
  event: "学会・研究会名"
  location: "会場、都市、国"
  date: "2026-10-09"
  date_label: "9–11 Oct 2026"
  group: international
  language: en
```

`group` は `international` または `domestic`。`date` は並べ替え用の発表日（開始日）、`date_label` は表示用の日付・期間です。`language` は題目の言語。日付は引用符で囲んでください。分類ごとに新しい日付順で表示します。

## プロフィール・研究・経歴を変更する

| 内容 | 編集するファイル |
| --- | --- |
| ナビゲーション、プロフィール、見出し、研究テーマの短い紹介 | `_data/site_text.yml` の `en` / `ja` / `it` |
| 日本語の研究本文 | `_includes/academic/research-ja.md` |
| 英語の研究本文 | `_includes/academic/research-en.md` |
| イタリア語の研究本文 | `_includes/academic/research-it.md` |
| 職歴・学歴・受賞歴 | `_data/career.yml` |
| メールアドレス・研究者リンク | `_config.yml` の `author` |
| 顔写真・観測アニメーション | `images/tomyoshida.jpg` / `images/imlup.gif` |

イタリア語版の初期文章は既存の英語・日本語から生成した翻訳です。翻訳はファイルとして保存され、閲覧時のAPI呼び出しはありません。今後プロフィールや研究内容を更新するときは、3言語の該当箇所も更新してください。論文・発表の正式な題目、著者名、会場名は原文を維持しています。

CVは提供された `part_B2.pdf` のPositions・Education・Prizesに合わせて更新しています。詳細説明は `_data/career.yml` の各項目に `details` として追加できます。

## デザインテンプレート

- 全ページの共通枠: `_layouts/academic.html`
- ページごとの部品: `_includes/academic/*.html`
- 元のレイアウト・文字・余白: `assets/css/main.scss` と `_sass/`
- 配色: `_sass/_variables.scss`
- ヘッダー・モバイル表示・一覧の調整: `assets/css/academic.css`
- 各ページの言語・種類・URL: `_pages/en/`, `_pages/ja/`, `_pages/it/`

元のAcademicPagesのレイアウト・文字・余白を使用しています。配色は `_sass/_variables.scss` の色変数で調整します。`assets/css/academic.css` はヘッダー・モバイル表示・一覧の調整です。JavaScriptが無効でも本文、全論文・発表、言語切り替えを利用できます。

## ローカル確認と公開

既存のGemfileを使用します。Ruby / Bundlerが利用できる環境で実行してください。

```sh
bundle install
bundle exec jekyll serve --config _config.yml,_config.dev.yml
```

`http://localhost:4000/en/`、`/ja/`、`/it/` を開きます。ビルドのみ行う場合:

```sh
bundle exec jekyll build
ruby scripts/check_site.rb
```

`check_site.rb` はデータの必須項目、3言語の生成ページ、旧URLの転送、サイト内リンクを確認します。

通常のGitHub Pages公開ブランチへコミット・pushすると、GitHub Pagesが生成します。今回の更新作業ではpushや公開設定の変更を行っていません。

## URL

各言語にプロフィール・研究・論文・発表・経歴の5ページがあります。言語切り替えでは現在のページ種別を保ちます。

- `/en/`, `/ja/`, `/it/`
- 各言語の `/research/`, `/publications/`, `/talks/`, `/cv/`
- 旧 `/`、`/about/`、`/publications/`、`/talks/`、`/cv/`、`/research_en/` は対応する英語版へ転送
- 旧 `/research/` は日本語の研究ページへ転送

AcademicPagesの既存CSS、プロフィール部品、フッター、モバイルナビゲーションを使用しています。補助ページは404ページとサイトマップだけを残しています。
