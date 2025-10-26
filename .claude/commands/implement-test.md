---
allowed-tools: Bash(gh issue view:*)
---

# Issue テスト実装コマンド

このコマンドは、GitHub Issue の仕様を理解し、RSpec + committee-rails によるテストコードを実装します。

## 使い方
```
/implement-test <issue_number>
```

## 処理フロー

1. **Issue 仕様の読み込み**: メモリから `issue-<番号>` を読み込む（なければ `/issue` コマンド実行を促す）
2. **既存コードの調査**: 関連するファイル構造とパターンを調査
3. **テストコードの設計**: Issue の要件に基づいてテストケースを設計
4. **テストコードの実装**: RSpec + committee-rails でテストを実装
5. **OpenAPI specの更新**: `public/doc/swagger.yml` に新しいエンドポイントを追加
6. **動作確認**: テストが正しく実行できることを確認

## 実行手順

### ステップ1: Issue 仕様の確認

1. `mcp__serena__read_memory` ツールで `issue-{{args}}` メモリを読み込む
2. メモリが存在しない場合は、ユーザーに `/issue {{args}}` の実行を促す
3. Issue の要件、技術的詳細、受け入れ基準を把握する

### ステップ2: 既存コードとパターンの調査

プロジェクトの構造に従って、以下を調査：

1. **ルーティング**: `config/routes/api_v1.rb` の既存パターンを確認
2. **コントローラ**: `app/controllers/api/v1/` の既存実装を参考にする
3. **既存テスト**: `spec/requests/api/v1/` の既存テストパターンを確認
4. **モデル・Factory**: 必要なモデルと FactoryBot 定義を確認

### ステップ3: テストケースの設計

Issue の要件から、以下を設計：

1. **テスト対象エンドポイント**: 実装すべきAPIエンドポイントのリスト
2. **テストシナリオ**: 各エンドポイントの正常系・異常系のシナリオ
3. **必要なデータ**: FactoryBot で作成すべきテストデータ
4. **期待される結果**: レスポンスコード、レスポンスボディの構造

### ステップ4: RSpec + committee-rails テストの実装

プロジェクトのパターンに従って実装：

#### 4-1. ディレクトリ構造の確認・作成
```bash
# 必要に応じてディレクトリを作成
mkdir -p spec/requests/api/v1/<namespace>
```

#### 4-2. Request Spec の作成

`spec/requests/api/v1/<namespace>/<endpoint>_spec.rb` を作成し、以下を含める：

```ruby
require 'rails_helper'

RSpec.describe 'API V1 <Resource>', type: :request do
  describe 'POST /api/v1/<endpoint>' do
    context '正常系' do
      it 'エンドポイントの説明' do
        # テストデータの準備
        params = { # テストデータ }

        # リクエスト実行
        post '/api/v1/<endpoint>', params: params, as: :json

        assert_response_schema_confirm(200)

        expect(response.parsed_body['key']).to eq('value')
      end
    end

    context '異常系' do
      it 'バリデーションエラーを返す' do
        # 不正なテストデータ
        params = { # 不正なデータ }

        post '/api/v1/<endpoint>', params: params, as: :json

        assert_response_schema_confirm(422)
      end
    end
  end
end
```

#### 4-3. 必要に応じて Factory の作成・更新

`spec/factories/<model>.rb` にテストデータの定義を追加：

```ruby
FactoryBot.define do
  factory :model_name do
    attribute { Faker::適切なジェネレータ }
  end
end
```

### ステップ5: テストの実行と確認

1. **テスト実行**:
```bash
bundle exec rspec spec/requests/api/v1/<namespace>/<endpoint>_spec.rb
```

2. **結果の確認**:
   - すべてのテストがパスすることを確認
   - エラーがあれば修正
   - committee-railsによるスキーマ検証が成功することを確認

3. **ドキュメントの確認**:
   - `/api-docs` でSwagger UIを確認できることを伝える
   - 新しく追加したエンドポイントが表示されることを確認

### ステップ7: ユーザーへの報告

以下を報告：
- 作成したテストファイルのパス
- 実装したテストケースの概要
- テスト実行結果
- 次のステップ（コントローラ実装など）の提案

## テスト実装のベストプラクティス

### このプロジェクトでの規約
- **テストフレームワーク**: RSpec
- **APIドキュメント**: OpenAPI 3.0（`public/doc/swagger.yml`）
- **スキーマ検証**: committee-rails
- **テストデータ**: FactoryBot + Faker
- **マッチャー**: Shoulda Matchers

### テストカバレッジ
各エンドポイントで以下をカバー：
- ✅ 正常系（200, 201など）
- ✅ 認証エラー（401）- 認証が必要な場合
- ✅ バリデーションエラー（422）
- ✅ リソース不在（404）- 該当する場合
- ✅ 権限エラー（403）- 該当する場合

### committee-rails の利点
- OpenAPI specに基づいてレスポンスを自動検証
- Swagger UI で API を視覚的に確認・テスト可能
- `assert_response_schema_confirm(200)` でスキーマ準拠を保証
- ドキュメントとテストの整合性を自動チェック

## 注意事項

- Issue番号が指定されていない場合は、ユーザーに Issue 番号の入力を促す
- メモリに Issue 情報がない場合は、先に `/issue <番号>` を実行するよう促す
- 既存のコードパターンを必ず参考にして、プロジェクトの規約に従う
- テストが失敗する場合は、原因を分析してユーザーに報告する
- コントローラの実装はまだ行わない（テストファーストアプローチ）

## 次のステップ

テスト実装後、以下のステップを提案：
1. コントローラの実装（テストを通すため）
2. ルーティングの追加
3. モデルの調整（必要に応じて）
4. 統合テストの実行
5. PRの作成準備
