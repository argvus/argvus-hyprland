---
title: キーボードショートカット
description: ARGVUS Hyprland の設定で提供されているショートカットを見つけてください。
---
コントロールセンター → デスクトップ＆入力 → キーボードショートカットを開くか、`argvus control-center keybindings`を実行します。

## ページの機能

**すべてのショートカット**は、アクティブなキー割り当てマニフェストを検索してグループ化します。バインディングを選択し、そのキー組み合わせを編集したり、新しい組み合わせをキャプチャしたり、設定可能なバインディングを有効または無効にしたり、ページの復元操作からすべてのショートカットを復元することができます。ショートカットには修飾キー以外のキーを含める必要があります。エディタはSuper/Win、Ctrl、Alt、Shift、矢印、ファンクションキー、メディアキーなどの名前を正規化します。`SUPER + Y`は、コントロールセンター → 外観 → 壁紙を開きます。

公式ショートカットの変更は`$XDG_CONFIG_HOME/argvus/config/keyboard_shortcuts.json`に保存され、論理モデルでは`/keyboard_shortcuts`で表されます。生成されたHyprlandフラグメントは`~/.config/argvus/data/generated/hypr/`の下に書き込まれます。無効化されたショートカットは`null`で表されます。キーは選択されたロケールに依存しない安定した英語の設定キーです: `window.close`のようなマニフェストIDは`close_window`にマッピングされ、`window.drag_mouse`は`drag_window__floating_window_only`にマッピングされます。古い`/hyprland/keybindings`セクションと`keybindings.toml`は移行専用です。ARGVUSはプロジェクション計画が実際の変更を報告した場合にのみセッションのリロードをスケジュールします。

**ショートカットを作成** は、パッケージ化されたマニフェストとは独立してグローバルキーボードショートカットを作成します。説明、キー、およびコマンドまたはサポートされているLuaディスパッチャー（例：`window.float`、JSON引数 `{"action":"toggle"}`）を指定してください。 **作成** はそれを保存して適用し、その後 **すべてのショートカット → カスタムショートカット** で選択します。キャンセルまたは`Esc`はドラフトを破棄します。作成およびキャプチャではコマンドは実行されません。

カスタムショートカットは、編集、有効/無効化、削除（確認付き）が可能です。同じコンテキスト内で有効になっているショートカットと競合する場合は、置き換えの確認が必要です。保護されたバインディングは置き換えることができません。公式のデフォルトを復元してもカスタム記録は保持されます。復元がアクティブなカスタムショートカットと衝突する場合は、まずそのカスタムショートカットを変更するか無効にしてください。カスタム定義は $XDG_CONFIG_HOME/argvus/config/hyprland.json 内の `/hyprland/custom_shortcuts` に保存されます。生成された  `$XDG_CONFIG_HOME/argvus/config/hyprland.json` `data/generated/hypr/custom-shortcuts.lua` は既存の保護ロードにより読み込まれ、無効な登録はログに記録されますが、他の構成は中止されません。保存に失敗した場合は下書きが保持され、アプリケーションの失敗が発生した場合は記録が保存されたことが報告され、再試行可能です。

`argvus control-center shortcuts create` または `argvus control-center shortcuts list` を実行して、いずれかのページを開きます。高度なサブマップ、マウスバインディング、またはフラグについては、[`bindings.lua`](/docs/argvus-hyprland/hyprland-overrides/) が引き続き利用可能です。生成されたフラグメントを編集してはいけません。

## 現在の参照

基本マニフェストとインストール済みチートシートは `/usr/share/argvus/hyprland/` の下にあります。アクティブユーザーのオーバーライドはマニフェストの置き換えではなく、コントロールセンターで選択されたエントリを変更するものです。このため、バージョン固有の手動コピーリストは古くなる可能性があります。

便利な組み込みアクションには、フォーカスやワークスペースの移動、フローティングウィンドウの切り替え、スクリーンショットや録画、ランチャー/ターミナルの起動、外観の変更、セッションのロック、メディアの制御、Hyprlandのリロードなどがあります。デフォルトのバインディングは以下の[デフォルトショートカット表](#default-shortcut-table)に記載されています。コントロールセンターページでは、現在設定されているバインディングが表示されます。

`SUPER + Shift + R`は明示的なランタイムリロードです：Hyprlandをリロードし、ARGVUSタスクバー、コントロールパネル、ウィジェットテレメトリサービスを再起動します。設定に基づくリロードは条件付きのままで、標準状態が変更されていない場合はグラフィカルなリロードをスキップします。

## デフォルトショートカット表

この表は、基本マニフェスト（`/usr/share/argvus/hyprland/keybindings.json`）のバインディングとそのデフォルトキーを示しています。コントロールセンターで行った変更は、ここに示されているキーを対象のバインディングに置き換え、無効化されたバインディングは実行されません。### ナビゲーション

| ショートカット | 説明 |
| --- | --- |
| `SUPER + Left Arrow` | 方向でタイルウィンドウにフォーカス |
| `SUPER + Right Arrow` | 方向でタイルウィンドウにフォーカス |
| `SUPER + Up Arrow` | 方向でタイルウィンドウにフォーカス |
| `SUPER + Down Arrow` | 方向でタイルウィンドウにフォーカス |
| `SUPER + CTRL + Left Arrow` | ウィンドウ間のフォーカスを切り替える（タイルおよびフローティング） |
| `SUPER + CTRL + Right Arrow` | ウィンドウ間のフォーカスを切り替える（タイルおよびフローティング） |

### ワークスペース

| ショートカット | 説明 |
| --- | --- |
| `CTRL + ALT + Right Arrow` | 作業領域間の移動 |
| `CTRL + ALT + Left Arrow` | 作業領域間の移動 |
| `Mouse extra button (mouse:276)` | 作業領域間の移動 |
| `Mouse side button (mouse:275)` | 作業領域間の移動 |
| `SUPER + 1` | ワークスペース 1 |
| `SUPER + 2` | ワークスペース 2 |
| `SUPER + 3` | ワークスペース 3 |
| `SUPER + 4` | ワークスペース 4 |
| `SUPER + 5` | ワークスペース 5 |
| `SUPER + 6` | ワークスペース 6 |
| `SUPER + 7` | ワークスペース 7 |
| `SUPER + 8` | ワークスペース 8 |
| `SUPER + 9` | ワークスペース 9 |
| `SUPER + CTRL + 1` から `SUPER + CTRL + 9` | `argvus projects` のその位置でプロジェクトを開く |
| `SUPER + Shift + 1` | ウィンドウをデスクトップ 1 に移動 |
| `SUPER + Shift + 2` | ウィンドウをデスクトップ 2 に移動 |
| `SUPER + Shift + 3` | ウィンドウをデスクトップ 3 に移動 |
| `SUPER + Shift + 4` | ウィンドウをデスクトップ 4 に移動 |
| `SUPER + Shift + 5` | ウィンドウをデスクトップ 5 に移動 |
| `SUPER + Shift + 6` | ウィンドウをデスクトップ 6 に移動 |
| `SUPER + Shift + 7` | ウィンドウをデスクトップ 7 に移動 |
| `SUPER + Shift + 8` | ウィンドウをデスクトップ 8 に移動 |
| `SUPER + Shift + 9` | ウィンドウをデスクトップ 9 に移動 |

### ウィンドウズ

| ショートカット | 説明 |
| --- | --- |
| `SUPER + S` | ウィンドウを最大化（トグル） |
| `SUPER + Q` | ウィンドウを閉じる |
| `SUPER + Shift + Space` | フローティングウィンドウの有効/無効 |
| `SUPER + F` | 全画面表示 |
| `SUPER + E` | 縦/横分割の切り替え |
| `SUPER + W` | タブにグループ化/グループ解除 |
| `SUPER + Tab` | タブ間を移動 |
| `SUPER + Shift + Left Arrow` | ウィンドウを移動 |
| `SUPER + Shift + Right Arrow` | ウィンドウを移動 |
| `SUPER + Shift + Up Arrow` | ウィンドウを移動 |
| `SUPER + Shift + Down Arrow` | ウィンドウを移動 |
| `SUPER + Left mouse button (mouse:272)` | ウィンドウをドラッグ（フローティングウィンドウのみ） |
| `SUPER + Right mouse button (mouse:273)` | ウィンドウサイズ変更モード（フローティングウィンドウのみ） |
| `SUPER + R` | ウィンドウサイズ変更モードに入る（フローティングウィンドウのみ） |

### アプリケーション

| ショートカット | 説明 |
| --- | --- |
| `SUPER + Enter` | ターミナル |
| `SUPER + [` | ターミナルスクラッチパッド（特別なワークスペースでドロップダウン表示；もう一度押すと非表示） |
| `SUPER + Space` | ファイルマネージャー |
| `SUPER + CTRL + Space` | システムモニター |
| `SUPER + Shift + D` | 取り外し可能デバイスメニュー |
| `SUPER + Shift + F` | ARGVUS フォーカス（ポモドーロと集中セッション） |
| `SUPER + Shift + C` | ARGVUS 時計（時計、タイマー、アラーム） |
| `SUPER + D` | プログラムランチャー |
| `SUPER + B` | デフォルトブラウザ |
| `SUPER + C` | 電卓 |
| `SUPER + ALT + S` | SSH ホストピッカー（`argvus ssh`） |
| `SUPER + ALT + N` | スニペットピッカー（`argvus snippets`） |
| `SUPER + ALT + G` | プロジェクトピッカー、その後選択したプロジェクトで git TUI（lazygit または gitui）（`argvus git`） |

### メディア

| ショートカット | 説明 |
| --- | --- |
| `XF86AudioRaiseVolume` | 音量を上げる |
| `Volume Down` | 音量を下げる |
| `Mute` | ミュート |
| `Brightness Up` | 明るさを上げる |
| `Brightness Down` | 明るさを下げる |
| `Play/Pause` | 再生/一時停止 |
| `Next Track` | 次のトラック |
| `Previous Track` | 前のトラック |
| `Stop` | トラックを停止 |

### スクリーンショットと録画

| ショートカット | 説明 |
| --- | --- |
| `Print` | 選択範囲をキャプチャ |
| `SUPER + Print` | フォーカスされたウィンドウをキャプチャ |
| `SUPER + Shift + Print` | 画面全体をキャプチャ |
| `SUPER + G` | 画面録画を開始/一時停止/再開 |
| `SUPER + Shift + G` | 録画を停止して保存 |

### セッション

| ショートカット | 説明 |
| --- | --- |
| `SUPER + L` | システムをロック |
| `SUPER + escape` | システムを終了 |
| `SUPER + Shift + R` | Hyprland をリロード |
| `SUPER + Shift + S` | モニターをオン/オフにする（システムはサスペンドしない） |
| `SUPER + Shift + L` | 非アクティブ時のロックタイムアウトを選択 |
| `SUPER + ALT + W` | 常時起動を切り替え |

### システム

| ショートカット | 説明 |
| --- | --- |
| `SUPER + Shift + /` | Hyprland チートシート |
| `SUPER + CTRL + /` | Kitty チートシート |
| `SUPER + F1` | ARGVUS についてを開く |
| `SUPER + ALT + C` | コントロールセンターを開く |
| `SUPER + P` | カラーピッカー |
| `SUPER + .` | 絵文字ピッカー |
| `SUPER + H` | クリップボード履歴 |
| `SUPER + Shift + H` | クリップボード履歴をクリア |

### ウィジェット

| ショートカット | 説明 |
| --- | --- |
| `SUPER + ,` | 通知サイドバーを開く/閉じる |
| `Middle mouse button (mouse:274)` | 通知サイドバーを開く/閉じる |
| `SUPER + Backspace` | Waybarを上部に切り替え |
| `SUPER + Shift + W` | 天気の場所を設定 |
| `SUPER + ALT + Up Arrow` | タスクバーを上に移動 |
| `SUPER + ALT + Down Arrow` | タスクバーを下に移動 |

### 外観

| ショートカット | 説明 |
| --- | --- |
| `SUPER + Y` | コントロールセンターの壁紙を開く |
| `SUPER + Shift + T` | テーマセレクターを開く |
| `SUPER + Shift + M` | スティッキー/スペースモードピッカーを開く |
| `SUPER + F5` | ARGVUSダークとARGVUSライトのテーマを切り替え |
| `SUPER + F6` | アニメーションを切り替え |
| `SUPER + Shift + B` | 明るさセレクターとナイトライトの切り替えを開く |

### サイズ変更モード（SUPER + R の後）

これらのショートカットはサイズ変更モードが有効なときのみ機能します。`Esc` または `Enter` でモードを終了します。

| ショートカット | 説明 |
| --- | --- |
| `Right Arrow` | サイズ変更 |
| `Left Arrow` | サイズ変更 |
| `Up Arrow` | サイズ変更 |
| `Down Arrow` | サイズ変更 |
| `Shift + Right Arrow` | ウィンドウを移動 |
| `Shift + Left Arrow` | ウィンドウを移動 |
| `Shift + Up Arrow` | ウィンドウを移動 |
| `Shift + Down Arrow` | ウィンドウを移動 |
| `escape` | サイズ変更モードを終了 |
| `Enter` | サイズ変更モードを終了 |

浮動ウィンドウとワークスペースの動作については[Windows and layout](/docs/argvus-hyprland/windows-and-layout/)を参照し、設定のワークフローについては[Control Center](/docs/components/argvus-control-center/)を参照してください。

## ナイトライト

**SUPER + Shift + B** は `appearance.brightness` アクションを正規のキー設定マニフェストに保持します。Rofi の輝度メニューには、Hyprsunset が利用可能な場合、ナイトライトも表示されます。温度（1000–20000 K）やローカルの開始/終了時間は **コントロールセンター > デスクトップと入力 > ディスプレイ > ナイトライト** で設定できます。クイックアクションは共通 CLI を使用し、Hyprland を再読み込みしたり生成された Lua を変更したりしません。

オプションの argvus-ai パッケージがインストールされている場合、SUPER + A で AI エージェントメニューが開きます。このバインディングは app.ai のユーザー上書きを尊重し、パッケージ削除とコンポジター再読み込み後に消えます。再読み込みまでは保護されたアクションは非アクティブです。


オプションの argvus-ai パッケージは /usr/share/argvus/ai/hyprland.lua を所有しています。Hyprland はユーザーによる上書きの前に安全にそれを読み込みます；モジュールを削除すると、リロード時のバインドも削除されます。Hyprland パッケージは、モジュールのインストール/アップグレード/削除後にシステム設定のタイムスタンプのみを更新する Pacman フックを提供し、ネイティブの自動リロードをトリガーします。自動リロードが無効の場合や、別のユーザー root 設定を使用している場合は、その設定を明示的にリロードしてください。コントロールセンターのカタログには app.ai が含まれており、同じデフォルトキーとローカライズされたラベルが設定されています；オプションのモジュールがない場合、バインディングは非アクティブのままです。

## パッケージターミナル

これらのキーは、Hyprland 全体に対してではなく、**Control Center > System Administration > Packages** 内で適用されます。`F8` はトランザクション端末を再度開き、`Esc` はプロセスを停止せずに非表示にし、`Shift+PageUp/PageDown` は履歴をスクロールし、`Shift+End` はライブ出力に戻り、`Ctrl+C` はフォーカスされている子プロセスを中断します。インストールされているチートシートには同じキーが含まれています。

Packages では、`/` が最上部の **Search** バーにフォーカスします。そこでは `Enter` により Official/AUR のインストール検索が実行され、削除および更新リストは入力に応じてフィルターされます。`Down` は結果に移動し、`Up` は最初の結果で Search に戻り、`Esc` は Search 内でクエリを保持してリストに戻ります。結果で Enter を押すと、そのパッケージのアクションが実行されます。
