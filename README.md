# EMBLAZE-USB 생성기

## Usage

```sh
$ mk-emblaze-usb.sh [DIR_PATH]
```

- `DIR_PATH`가 생략된 경우, `./data/` 디렉토리가 `DIR_PATH`로 지정되고,
  함께 기본 세팅으로 파일들이 자동으로 생성된다.
- `DIR_PATH`을 이미지로 생성한다.
- dd 명령어 (linux), https://www.alexpage.de/usb-image-tool/ (window) 등 이미지 백업 툴을 이용해서
  usb flash memory disk에 다운로드한다.
- EMBLAZE-USB 가 설치되어있는 gateway에 USB 삽입. 부팅 후 1분 전후의 유예시간을 두고 연결하여
  작동시킨다.
