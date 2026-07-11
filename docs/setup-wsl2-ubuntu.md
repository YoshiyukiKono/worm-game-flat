# WSL2 Ubuntuでの環境構築

この文書では、Windows上のWSL2 UbuntuでGodotを起動し、`worm-game-flat`を実行するまでの手順を説明します。

## 1. この環境の構成

このリポジトリでは、次の構成を使用します。

```text
Windows 11
└── WSL2
    └── Ubuntu 24.04
        ├── Git
        ├── Godot 4.7
        └── worm-game-flat
```

GodotはGUIアプリケーションですが、WSL2ではWSLgを通してLinux版GodotのウィンドウをWindowsデスクトップ上に表示できます。

この構成では、次の操作をすべてWSL2 Ubuntu側で行います。

* Gitによるソースコード管理
* Godot Editorの起動
* GDScriptの編集
* ゲームの実行
* コマンドラインからの動作確認

## 2. WSL2 Ubuntuの確認

Windows PowerShellで、インストールされているWSL環境を確認します。

```powershell
wsl --list --verbose
```

次のように、UbuntuのVERSIONが`2`になっていることを確認します。

```text
  NAME            STATE           VERSION
* Ubuntu-24.04    Running         2
```

WSLが古い場合は、管理者権限のPowerShellで更新します。

```powershell
wsl --update
wsl --shutdown
```

その後、Ubuntuを再度起動します。

## 3. Ubuntuの更新

WSL2 Ubuntuを開き、パッケージ情報を更新します。

```bash
sudo apt update
sudo apt upgrade -y
```

## 4. 基本ツールのインストール

Git、ダウンロード、展開に使用するツールをインストールします。

```bash
sudo apt install -y \
  git \
  curl \
  wget \
  unzip
```

バージョンを確認します。

```bash
git --version
curl --version
unzip -v
```

## 5. WSLgの確認

WSLgが利用できることを確認します。

```bash
echo "$WAYLAND_DISPLAY"
echo "$DISPLAY"
```

通常は、次のような値が表示されます。

```text
wayland-0
:0
```

簡単なGUIアプリケーションで確認する場合は、次を実行します。

```bash
sudo apt install -y x11-apps
xeyes
```

Windowsデスクトップ上にウィンドウが表示されれば、WSLgは動作しています。

確認後、`xeyes`はウィンドウを閉じて終了できます。

## 6. Godot 4.7のインストール

Godotの公式サイトから、Godot 4.7 stableのLinux版をダウンロードします。

使用するのは、通常のLinux x86_64版です。

ダウンロードしたZIPファイルを、WSL2 Ubuntuのホームディレクトリに置きます。Windows側のDownloadsフォルダーに保存した場合は、次のようにコピーできます。

```bash
cp /mnt/c/Users/<Windowsユーザー名>/Downloads/Godot_v4.7-stable_linux.x86_64.zip ~/
```

ホームディレクトリへ移動します。

```bash
cd ~
```

ZIPファイルを展開します。

```bash
unzip Godot_v4.7-stable_linux.x86_64.zip
```

展開された実行ファイルを配置します。

```bash
sudo install \
  Godot_v4.7-stable_linux.x86_64 \
  /usr/local/bin/godot
```

実行できることを確認します。

```bash
godot --version
```

次のように、`4.7`を含むバージョンが表示されれば準備完了です。

```text
4.7.stable.official...
```

## 7. Godot Editorの起動確認

WSL2 UbuntuからGodot Editorを起動します。

```bash
godot --editor
```

Windowsデスクトップ上にGodotのウィンドウが表示されることを確認します。

初回起動では、プロジェクトマネージャーが表示されます。

## 8. リポジトリの取得

ホームディレクトリ以下にリポジトリを取得します。

```bash
cd ~
git clone https://github.com/YoshiyukiKono/worm-game-flat.git
cd worm-game-flat
```

リポジトリの内容を確認します。

```bash
find . -maxdepth 2 -type f | sort
```

主なファイルは次のとおりです。

```text
./LICENSE
./README.md
./project.godot
./scenes/main.tscn
./scripts/main.gd
```

## 9. プロジェクトの起動

Godot Editorでプロジェクトを開きます。

```bash
godot --editor --path .
```

Godot Editorが開いたら、画面右上の **Run Project** を選択します。

コマンドラインからゲームを直接起動する場合は、次を実行します。

```bash
godot --path .
```

## 10. 操作方法

| キー    | 操作        |
| ----- | --------- |
| `h`   | 左へ向く      |
| `j`   | 下へ向く      |
| `k`   | 上へ向く      |
| `l`   | 右へ向く      |
| `r`   | ゲーム終了後に再開 |
| `Esc` | 終了        |

ゲームを起動すると、ワームは自動的に右へ進みます。

## 11. プロジェクトの配置場所

リポジトリは、Windows側のファイルシステムではなく、WSL2 Ubuntuのホームディレクトリ以下に配置することを推奨します。

推奨する配置場所:

```text
/home/<Ubuntuユーザー名>/worm-game-flat
```

つまり、次のように取得します。

```bash
cd ~
git clone https://github.com/YoshiyukiKono/worm-game-flat.git
```

次のようなWindows側の領域でも実行できますが、通常の開発場所としては推奨しません。

```text
/mnt/c/Users/<Windowsユーザー名>/...
```

WSL2内でGit、Godot、エディタを利用する場合、プロジェクトをLinux側のファイルシステムに置いた方が、ファイルアクセスや権限の扱いが単純になります。

Windows ExplorerからWSL2内のファイルを見る場合は、アドレスバーに次を入力します。

```text
\\wsl$\Ubuntu-24.04\home\<Ubuntuユーザー名>\worm-game-flat
```

## 12. VS Codeを使用する場合

Windows版Visual Studio CodeとWSL拡張機能を使用している場合は、リポジトリのディレクトリから次を実行できます。

```bash
code .
```

この場合、Visual Studio Codeの画面はWindows側で動作し、ターミナル、Git、ファイル操作はWSL2 Ubuntu側で実行されます。

Godot Editorは引き続き、次のコマンドで起動します。

```bash
godot --editor --path .
```

## 13. トラブルシューティング

### Godotのウィンドウが表示されない

PowerShellでWSLを更新し、再起動します。

```powershell
wsl --update
wsl --shutdown
```

その後、Ubuntuを開き直します。

WSL2 Ubuntu側では、次の値を確認します。

```bash
echo "$WAYLAND_DISPLAY"
echo "$DISPLAY"
```

どちらも空の場合は、WSLgが有効になっていない可能性があります。

### `godot: command not found`と表示される

Godotの実行ファイルが配置されているか確認します。

```bash
ls -l /usr/local/bin/godot
```

PATHを確認します。

```bash
echo "$PATH"
```

直接実行して確認することもできます。

```bash
/usr/local/bin/godot --version
```

### 描画に関するエラーが発生する

GPUとWSLgの状態を確認します。

```bash
ls -l /dev/dxg
```

`/dev/dxg`が存在しない場合は、WSLまたはWindows側のGPUドライバーを更新します。

OpenGL情報を確認するには、次を使用します。

```bash
sudo apt install -y mesa-utils
glxinfo -B
```

一時的な切り分けとして、ソフトウェアレンダリングを指定して起動できます。

```bash
LIBGL_ALWAYS_SOFTWARE=1 godot --editor --path .
```

これは通常の起動方法ではなく、GPU描画に問題があるかを確認するための方法です。

### 音声に関する警告が表示される

このゲームではBGMや効果音を使用しないため、音声関連の警告が表示されてもゲーム本体の確認には影響しない場合があります。

### プロジェクトが見つからない

現在のディレクトリを確認します。

```bash
pwd
ls
```

`project.godot`が存在するディレクトリで、次を実行してください。

```bash
godot --editor --path .
```

## 14. 環境情報の確認

問題を記録するときは、次の情報を取得します。

```bash
echo "=== OS ==="
cat /etc/os-release

echo
echo "=== Kernel ==="
uname -a

echo
echo "=== WSL ==="
uname -r

echo
echo "=== Display ==="
echo "DISPLAY=$DISPLAY"
echo "WAYLAND_DISPLAY=$WAYLAND_DISPLAY"

echo
echo "=== Godot ==="
godot --version

echo
echo "=== Git ==="
git --version
```

これにより、WSL2 Ubuntu、WSLg、Godot、Gitの基本状態をまとめて確認できます。

## 15. 参考情報

* Microsoft: WSLでLinux GUIアプリを実行する
* Godot Engine: Godot 4.7 stable
* Godot Engine Documentation: Command line tutorial
* Godot Engine Documentation: System requirements
