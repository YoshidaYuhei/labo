---
name: feature_request
about: Describe this issue template's purpose here.
title: ''
labels: ''
assignees: YoshidaYuhei

---

name: ✨ 機能追加・変更
description: 新しい機能の追加や既存機能の変更提案
title: "[Feature]: "
labels: ["enhancement", "needs-review"]
body:
  - type: markdown
    attributes:
      value: |
        機能追加リクエストありがとうございます 👋
        
  - type: checkboxes
    id: checklist
    attributes:
      label: 事前確認
      options:
        - label: 既存のIssueを検索しました
          required: true
          
  # ==================== 概要 ====================
  
  - type: textarea
    id: overview
    attributes:
      label: 概要
      description: 何を実現したいか
    validations:
      required: true
      
  # ==================== 背景・動機 ====================
  
  - type: textarea
    id: motivation
    attributes:
      label: 背景・動機
      description: なぜこの機能が必要か
    validations:
      required: true
      
  # ==================== 外形的振る舞い ====================
  
  - type: textarea
    id: behavior-before
    attributes:
      label: Before（変更前）
      description: 現在のユーザー体験・操作フロー
      render: markdown
    validations:
      required: true
      
  - type: textarea
    id: behavior-after
    attributes:
      label: After（変更後）
      description: 変更後のユーザー体験・操作フロー
      render: markdown
    validations:
      required: true
      
  - type: textarea
    id: ui-changes
    attributes:
      label: UI/UX の変更
      description: 画面の変化、追加・削除される要素
        
  - type: textarea
    id: design-mockup
    attributes:
      label: デザイン・モックアップ
      description: 画像やFigmaリンクがあれば
        
  # ==================== 完了条件 ====================
  
  - type: textarea
    id: acceptance-criteria
    attributes:
      label: 完了条件
      value: |
        - [ ] 外形的振る舞いが仕様通り
        - [ ] APIが仕様通り動作
        - [ ] テストが書かれている
        - [ ] ドキュメントが更新されている
    validations:
      required: true
      
  # ==================== 実装方針 ====================
  
  - type: textarea
    id: implementation
    attributes:
      label: 実装方針
      description: 技術的なアプローチ
        
  # ==================== API ====================
  
  - type: dropdown
    id: api-changes
    attributes:
      label: API の変更
      options:
        - 変更なし
        - 新規エンドポイント追加
        - 既存エンドポイント更新
        - 両方
    validations:
      required: true
      
  - type: textarea
    id: api-details
    attributes:
      label: API 詳細
      render: markdown
      
  - type: dropdown
    id: breaking-changes
    attributes:
      label: Breaking Changes
      options:
        - なし
        - あり
    validations:
      required: true
      
  # ==================== Schema ====================
  
  - type: dropdown
    id: schema-changes
    attributes:
      label: Schema の変更
      options:
        - 変更なし
        - 新規テーブル追加
        - 既存テーブル更新
        - 両方
    validations:
      required: true
      
  - type: textarea
    id: schema-details
    attributes:
      label: Schema 詳細
      render: markdown
      
  # ==================== セキュリティ ====================
  
  - type: checkboxes
    id: security
    attributes:
      label: セキュリティ考慮事項
      options:
        - label: 認証・認可が必要
        - label: 個人情報を扱う
        - label: 入力検証が必要
        - label: レート制限が必要
        - label: セキュリティレビューが必要
        - label: 該当なし
          
  - type: textarea
    id: security-details
    attributes:
      label: セキュリティ詳細
        
  # ==================== 関連情報 ====================
  
  - type: textarea
    id: related
    attributes:
      label: 関連 Issue / PR
      
  - type: textarea
    id: references
    attributes:
      label: 参考資料
      description: Figma、設計書、参考実装など
        
  - type: dropdown
    id: priority
    attributes:
      label: 優先度
      options:
        - P0 - クリティカル
        - P1 - 高
        - P2 - 中
        - P3 - 低
      default: 2
    validations:
      required: true
      
  - type: textarea
    id: estimation
    attributes:
      label: 見積もり
      description: 工数（分かれば）
