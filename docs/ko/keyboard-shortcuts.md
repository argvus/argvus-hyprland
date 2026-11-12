---
title: 키보드 단축키
description: ARGVUS Hyprland 설정에서 제공하는 단축키를 찾으세요.
---
제어 센터 → 데스크탑 및 입력 → 키보드 단축키를 열거나 `argvus control-center keybindings`를 실행하세요.

## 페이지 기능

모든 단축키는 활성 키 바인딩 매니페스트를 검색하고 그룹화합니다. 바인딩을 선택하고, 키 조합을 편집하거나, 새로운 조합을 캡처하고, 구성 가능한 바인딩을 활성화 또는 비활성화하며, 페이지의 복원 기능을 사용하여 모든 단축키를 복원할 수 있습니다. 단축키는 하나 이상의 수정 키가 아닌 키를 포함해야 하며, 편집기는 Super/Win, Ctrl, Alt, Shift, 화살표, 기능 키와 미디어 키와 같은 이름을 표준화합니다. `SUPER + Y`는 제어 센터 → 모양 → 바탕화면 배경을 엽니다.

공식 단축키 변경 사항은 `$XDG_CONFIG_HOME/argvus/config/keyboard_shortcuts.json`에 저장되며, 논리 모델에서는 `/keyboard_shortcuts`로 표시됩니다; 생성된 Hyprland 조각은 `~/.config/argvus/data/generated/hypr/` 아래에 기록됩니다. 비활성화된 단축키는 `null`로 표시됩니다. 키는 선택한 로케일과 상관없이 안정적인 영어 구성 키입니다: `window.close`와 같은 매니페스트 ID는 `close_window`에 매핑되며, `window.drag_mouse`는 `drag_window__floating_window_only`에 매핑됩니다. 오래된 `/hyprland/keybindings` 섹션과 `keybindings.toml`는 마이그레이션 전용입니다. ARGVUS는 프로젝션 계획이 실제 변경 사항을 보고할 때만 세션 재로드를 예약합니다.

**단축키 생성**은 패키지화된 매니페스트와 독립적으로 전역 키보드 단축키를 생성합니다. 설명, 키, 그리고 명령어 또는 지원되는 Lua 디스패처(예: `window.float` 및 JSON 인수 `{"action":"toggle"}`)를 제공합니다. **생성**은 이를 저장하고 적용한 후, **모든 단축키 → 사용자 정의 단축키**에서 선택합니다. 취소 또는 `Esc`는 초안을 삭제합니다. 생성 및 캡처는 명령을 실행하지 않습니다.

사용자 정의 단축키는 편집, 활성/비활성 및 삭제 시 확인이 필요합니다. 동일한 컨텍스트에서 활성화된 단축키와 충돌하는 경우 교체 확인이 필요하며, 보호된 바인딩은 교체할 수 없습니다. 공식 기본값을 복원하면 사용자 정의 기록은 보존됩니다. 복원 시 활성화된 사용자 정의 단축키와 충돌할 경우 먼저 해당 사용자 정의 단축키를 변경하거나 비활성화하십시오. 사용자 정의 정의는 `/hyprland/custom_shortcuts`에 `$XDG_CONFIG_HOME/argvus/config/hyprland.json` 아래 저장됩니다. 생성된 `data/generated/hypr/custom-shortcuts.lua`는 기존 보호 로더와 함께 로드되며, 잘못된 등록은 나머지 구성을 중단하지 않고 기록됩니다. 저장 실패 시 초안은 보존되며, 애플리케이션 실패 시 레코드가 저장되었다고 보고되고 재시도가 가능합니다.

`argvus control-center shortcuts create` 또는 `argvus control-center shortcuts list`를 실행하여 해당 페이지를 엽니다. 고급 서브맵, 마우스 바인딩 또는 플래그의 경우 [`bindings.lua`](/docs/argvus-hyprland/hyprland-overrides/)가 계속 사용 가능합니다. 생성된 조각은 절대로 편집하지 마십시오.

## 현재 참조

기본 매니페스트와 설치된 치트시트는 `/usr/share/argvus/hyprland/`에 있습니다. 활성 사용자 오버라이드는 매니페스트를 대체하는 것이 아니라 Control Center에서 선택된 항목을 변경합니다. 이것이 버전별로 수동으로 복사된 목록이 오래될 수 있는 이유입니다.

몇 가지 유용한 내장 동작에는 포커스 및 작업 공간 이동, 플로팅 창 전환, 스크린샷 및 녹화, 런처/터미널 열기, 외관 변경, 세션 잠금, 미디어 제어 및 Hyprland 재시작이 포함됩니다. 기본 단축키는 아래 [기본 단축키 표](#default-shortcut-table)에 나와 있으며, 제어 센터 페이지에는 현재 설정된 대로 단축키가 표시됩니다.

`SUPER + Shift + R`는 명시적인 런타임 재시작입니다: 이는 Hyprland를 재시작하고 ARGVUS 작업 표시줄, 제어판 및 위젯 텔레메트리 서비스를 다시 시작합니다. 설정 기반 재시작은 조건부로 유지되며, 정식 상태가 변경되지 않은 경우 그래픽 재시작은 건너뜁니다.

## 기본 단축키 표

이 표에는 기본 매니페스트(`/usr/share/argvus/hyprland/keybindings.json`)에 대한 단축키와 기본 키가 나열되어 있습니다. 제어 센터에서 사용자가 변경한 내용은 여기 표시된 키를 영향을 받는 단축키에 대해 대체하며, 비활성화된 단축키는 실행되지 않습니다.### 탐색

| 단축키 | 설명 |
| --- | --- |
| `SUPER + Left Arrow` | 방향으로 타일 창에 포커스 맞추기 |
| `SUPER + Right Arrow` | 방향으로 타일 창에 포커스 맞추기 |
| `SUPER + Up Arrow` | 방향으로 타일 창에 포커스 맞추기 |
| `SUPER + Down Arrow` | 방향으로 타일 창에 포커스 맞추기 |
| `SUPER + CTRL + Left Arrow` | 창 간 포커스 순환 (타일 및 플로팅) |
| `SUPER + CTRL + Right Arrow` | 창 간 포커스 순환 (타일 및 플로팅) |

### 작업 공간

| 단축키 | 설명 |
| --- | --- |
| `CTRL + ALT + Right Arrow` | 작업 영역 간 이동 |
| `CTRL + ALT + Left Arrow` | 작업 영역 간 이동 |
| `Mouse extra button (mouse:276)` | 작업 영역 간 이동 |
| `Mouse side button (mouse:275)` | 작업 영역 간 이동 |
| `SUPER + 1` | 작업 공간 1 |
| `SUPER + 2` | 작업 공간 2 |
| `SUPER + 3` | 작업 공간 3 |
| `SUPER + 4` | 작업 공간 4 |
| `SUPER + 5` | 작업 공간 5 |
| `SUPER + 6` | 작업 공간 6 |
| `SUPER + 7` | 작업 공간 7 |
| `SUPER + 8` | 작업 공간 8 |
| `SUPER + 9` | 작업 공간 9 |
| `SUPER + CTRL + 1` 부터 `SUPER + CTRL + 9` | `argvus projects`의 해당 위치에서 프로젝트 열기 |
| `SUPER + Shift + 1` | 창을 데스크톱 1으로 이동 |
| `SUPER + Shift + 2` | 창을 데스크톱 2로 이동 |
| `SUPER + Shift + 3` | 창을 데스크톱 3으로 이동 |
| `SUPER + Shift + 4` | 창을 데스크톱 4로 이동 |
| `SUPER + Shift + 5` | 창을 데스크톱 5로 이동 |
| `SUPER + Shift + 6` | 창을 데스크톱 6으로 이동 |
| `SUPER + Shift + 7` | 창을 데스크톱 7로 이동 |
| `SUPER + Shift + 8` | 창을 데스크톱 8로 이동 |
| `SUPER + Shift + 9` | 창을 데스크톱 9로 이동 |

### 윈도우

| 바로가기 | 설명 |
| --- | --- |
| `SUPER + S` | 창 최대화 (토글) |
| `SUPER + Q` | 창 닫기 |
| `SUPER + Shift + Space` | 플로팅 창 사용/사용 안 함 |
| `SUPER + F` | 전체 화면 창 |
| `SUPER + E` | 세로/가로 분할 토글 |
| `SUPER + W` | 탭으로 그룹/그룹 해제 |
| `SUPER + Tab` | 탭 간 이동 |
| `SUPER + Shift + Left Arrow` | 창 이동 |
| `SUPER + Shift + Right Arrow` | 창 이동 |
| `SUPER + Shift + Up Arrow` | 창 이동 |
| `SUPER + Shift + Down Arrow` | 창 이동 |
| `SUPER + Left mouse button (mouse:272)` | 창 드래그 (플로팅 창만 해당) |
| `SUPER + Right mouse button (mouse:273)` | 창 크기 조정 모드 (플로팅 창만 해당) |
| `SUPER + R` | 창 크기 조정 모드 진입 (플로팅 창만 해당) |

### 응용 프로그램

| 단축키 | 설명 |
| --- | --- |
| `SUPER + Enter` | 터미널 |
| `SUPER + [` | 터미널 스크래치패드 (특수 작업 공간에서 드롭다운; 다시 누르면 숨김) |
| `SUPER + Space` | 파일 관리자 |
| `SUPER + CTRL + Space` | 시스템 모니터 |
| `SUPER + Shift + D` | 이동식 장치 메뉴 |
| `SUPER + Shift + F` | ARGVUS 포커스 (포모도로 및 집중 세션) |
| `SUPER + Shift + C` | ARGVUS 시계 (시계, 타이머 및 알람) |
| `SUPER + D` | 프로그램 실행기 |
| `SUPER + B` | 기본 브라우저 |
| `SUPER + C` | 계산기 |
| `SUPER + ALT + S` | SSH 호스트 선택기 (`argvus ssh`) |
| `SUPER + ALT + N` | 스니펫 선택기 (`argvus snippets`) |
| `SUPER + ALT + G` | 프로젝트 선택기, 그 후 선택한 프로젝트에서 git TUI (lazygit 또는 gitui) (`argvus git`) |

### 미디어

| 단축키 | 설명 |
| --- | --- |
| `XF86AudioRaiseVolume` | 볼륨 올리기 |
| `Volume Down` | 볼륨 내리기 |
| `Mute` | 음소거 |
| `Brightness Up` | 밝기 올리기 |
| `Brightness Down` | 밝기 내리기 |
| `Play/Pause` | 재생/일시정지 |
| `Next Track` | 다음 트랙 |
| `Previous Track` | 이전 트랙 |
| `Stop` | 트랙 정지 |

### 스크린샷 및 녹화

| 단축키 | 설명 |
| --- | --- |
| `Print` | 선택 영역 캡처 |
| `SUPER + Print` | 활성 창 캡처 |
| `SUPER + Shift + Print` | 전체 화면 캡처 |
| `SUPER + G` | 화면 녹화 시작/일시정지/재개 |
| `SUPER + Shift + G` | 화면 녹화 중지 및 저장 |

### 세션

| 바로가기 | 설명 |
| --- | --- |
| `SUPER + L` | 시스템 잠금 |
| `SUPER + escape` | 시스템 종료 |
| `SUPER + Shift + R` | Hyprland 재시작 |
| `SUPER + Shift + S` | 모니터 끄기/켜기 (시스템 절전 아님) |
| `SUPER + Shift + L` | 비활성 잠금 시간 선택 |
| `SUPER + ALT + W` | Keep Awake 토글 |

### 시스템

| 바로가기 | 설명 |
| --- | --- |
| `SUPER + Shift + /` | Hyprland 치트시트 |
| `SUPER + CTRL + /` | Kitty 치트시트 |
| `SUPER + F1` | ARGVUS 정보 열기 |
| `SUPER + ALT + C` | 제어 센터 열기 |
| `SUPER + P` | 색상 선택기 |
| `SUPER + .` | 이모지 선택기 |
| `SUPER + H` | 클립보드 기록 |
| `SUPER + Shift + H` | 클립보드 기록 삭제 |

### 위젯

| 바로 가기 | 설명 |
| --- | --- |
| `SUPER + ,` | 알림 사이드바 열기/닫기 |
| `Middle mouse button (mouse:274)` | 알림 사이드바 열기/닫기 |
| `SUPER + Backspace` | Waybar 상단 토글 |
| `SUPER + Shift + W` | 날씨 위치 설정 |
| `SUPER + ALT + Up Arrow` | 작업 표시줄을 상단으로 이동 |
| `SUPER + ALT + Down Arrow` | 작업 표시줄을 하단으로 이동 |

### 외관

| 바로 가기 | 설명 |
| --- | --- |
| `SUPER + Y` | 제어 센터 배경화면 열기 |
| `SUPER + Shift + T` | 테마 선택기 열기 |
| `SUPER + Shift + M` | 스티키/스페이스 모드 선택기 열기 |
| `SUPER + F5` | ARGVUS 다크와 ARGVUS 라이트 테마 간 전환 |
| `SUPER + F6` | 애니메이션 토글 |
| `SUPER + Shift + B` | 밝기 선택기 및 야간 조명 토글 열기 |

### 크기 조정 모드 (SUPER + R 후)

이 바로 가기는 크기 조정 모드가 활성화된 동안에만 작동합니다. `Esc` 또는 `Enter`를 사용하면 모드를 종료합니다.

| 단축키 | 설명 |
| --- | --- |
| `Right Arrow` | 크기 조정 |
| `Left Arrow` | 크기 조정 |
| `Up Arrow` | 크기 조정 |
| `Down Arrow` | 크기 조정 |
| `Shift + Right Arrow` | 창 이동 |
| `Shift + Left Arrow` | 창 이동 |
| `Shift + Up Arrow` | 창 이동 |
| `Shift + Down Arrow` | 창 이동 |
| `escape` | 크기 조정 모드 종료 |
| `Enter` | 크기 조정 모드 종료 |


[Windows and layout](/docs/argvus-hyprland/windows-and-layout/)에서 플로팅 및 작업 공간 동작을 확인하고 [Control Center](/docs/components/argvus-control-center/)에서 설정 워크플로를 확인하세요.

## 나이트 라이트

**SUPER + Shift + B**는 `appearance.brightness` 동작을 표준 키 바인딩 매니페스트에 유지합니다. Rofi 밝기 메뉴에서는 Hyprsunset이 활성화되어 있을 때 Night Light도 제공합니다. 온도(1000–20000 K)와 로컬 시작/종료 시간을 **Control Center > Desktop & Input > Displays > Night Light**에서 설정하세요. 빠른 동작은 공용 CLI를 사용하며 Hyprland를 다시 로드하거나 생성된 Lua를 변경하지 않습니다.

선택 사항인 argvus-ai 패키지가 설치되어 있으면, SUPER + A는 AI 에이전트 메뉴를 엽니다. 이 바인딩은 app.ai 사용자 재정의를 존중하며, 패키지 제거와 컴포지터 재로드 후 사라집니다. 재로드 전까지는 보호된 동작이 비활성 상태입니다.


선택적 argvus-ai 패키지는 /usr/share/argvus/ai/hyprland.lua를 소유합니다. Hyprland는 사용자 오버라이드 전에 이를 안전하게 로드하며, 모듈을 제거하면 재로드 시 해당 바인딩도 제거됩니다. Hyprland 패키지는 모듈 설치/업그레이드/제거 후 시스템 구성 타임스탬프만 갱신하는 Pacman 훅을 제공하며, 이를 통해 네이티브 자동 재로드가 실행됩니다. 자동 재로드가 비활성화되어 있거나 별도의 사용자 루트 구성을 사용하는 경우, 해당 구성을 명시적으로 재로드해야 합니다. 제어 센터 카탈로그에는 동일한 기본 키와 현지화된 레이블을 가진 app.ai가 포함되어 있으며, 선택적 모듈이 없으면 바인딩은 비활성 상태로 유지됩니다.

## 패키지 터미널

이 키들은 Hyprland 전체가 아니라 **Control Center > System Administration > Packages** 안에서 적용됩니다. `F8`은 거래 터미널을 다시 열고, `Esc`은 프로세스를 멈추지 않고 숨기며, `Shift+PageUp/PageDown`는 기록을 스크롤하고, `Shift+End`는 실시간 출력을 반환하며, `Ctrl+C`는 포커스된 자식 프로세스를 중단합니다. 설치된 치트시트에는 동일한 키가 포함되어 있습니다.

Packages에서는 `/`가 상단 **검색** 바에 포커스를 맞춥니다. `Enter`는 공식/AUR 설치 검색을 제출하며, 제거 및 업데이트 목록은 입력하면 필터링됩니다. `Down`는 결과로 이동하고, `Up`는 첫 번째 결과에서 검색으로 돌아가며, `Esc`는 검색에서 쿼리를 유지하고 목록으로 돌아갑니다. 결과에서 Enter를 누르면 해당 패키지 작업이 수행됩니다.
