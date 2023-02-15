# OpenWeatherApp

### 전세계 도시의 날씨정보를 확인할 수 있는 앱

|메인화면|검색화면|
|:----:|:---:|
|<img width="300" alt="" src="https://user-images.githubusercontent.com/83946704/219211067-26c6de4f-d027-4ea9-94ab-bb998abada3b.gif">|<img width="300" alt="" src="https://user-images.githubusercontent.com/83946704/219211127-09490fb4-c063-42c9-a6bb-e3c9f280f190.gif">|

### ❗️프로젝트 빌드를 위해 확인해주세요❗️
- 프로젝트에 OpenWeather API Key는 gitignore되어 있는 상태입니다. 직접 프로젝트 빌드하기 위해선 OpenWeather API Key를 발급받아 사용해주세요.
- 사용방법 : 프로젝트에 다음과 같은 구조의 OpenWeatherAPI 구조체 생성 및 key 변수선언을 해주세요.
```
struct OpenWeatherAPI {
    private init() { }
    
    static let key = "API Key값"
}
```


### 개발환경
- iOS: 16.0
- Xcode: 14.0.1

### 라이브러리

|라이브러리|Version|관리|
|:-----:|:-----:|:--:|
|RxSwift|`6.5.0`|`SPM`|
|RxCocoa|`6.5.0`|`SPM`|
|Alamofire|`5.6.4`|`SPM`|
|SnapKit|`5.6.0`|`SPM`|


### Git commit message

|Commit Type|Description|
|:-----:|:-----:|
|[Project]|프로젝트 설정 및 파일/폴더관리|
|[Feat]|기능구현|
|[Fix]|에러 및 버그수정|
|[Style]|코드 형식, 코드 스타일 수정|
|[Comment]|주석 추가|
|[Design]|UI 디자인 관련 수정|
|[Refactor]|리팩토링|
|[Readme]|리드미 수정|

### 폴더구조

```
OepnWeatherApp
  |
  |── Entity
  |     |── City.swift
  |     |── Weather.swift
  |     └── Model
  |           |── CurrentWeather.swift
  |           |── TodayWeather.swift
  |           |── WeeklyWeather.swift
  |           └── DetailWeather.swift
  |── Presentation
  |     |── MainViewController.swift
  |     |── MainViewModel.swift
  |     |── SearchTableView
  |     |── CurrentWeatherView
  |     |── TodayWeatherView
  |     |── WeeklyWeatherView
  |     |── MapView
  |     └── DeatilWeatherView
  |── Network
  |     |── WeatherService.swift
  |     └── PrivateKey.swift (gitignored)
  |── Domain
  |     └── CityStore.swift
  |── Extension
  |     |── Extension+Double.swift
  |     |── Extension+String.swift
  |     |── Extension+UIColor
  |     |── Extension+Date
  |     └── Extension+Int
  |── Resource
  |     |── Assets.xcassets
  |     └── citylist.json
  └── Supports
        |── AppDelegate.swit
        |── SceneDelegate.swit
        |── Info.plist
        └── LaunchScreen.storyboard

```

### 프로젝트 설명
1. MVVM 디자인패턴을 적용해 View는 View Life Cycle과 UI 구성요소 binding, ViewModel은 비즈니스 로직 관리 및 Model 통신, Model은 데이터를 관리하도록 분리하였습니다.
2. WeatherManager의 API Key는 PrivateKey.swift 파일 내의 OpenWatherAPI 구조체의 key 변수를 통해 받아와 사용하였습니다. PrivateKey.swift는 gitignore된 상태입니다. 프로젝트를 사용하기 위해선 Network 폴더 내에 OpenWatherAPI 구조체 생성 및 개인 API Key가 필요합니다.
3. 시간별 날씨는 현재시간 기준으로 2일간 3시간 간격으로 나타납니다.
4. 일별 날씨는 현재시간 기준으로 5일간 24시간 간격으로 나타납니다.
5. OpenWeather API 중 5 day/ 3 hour forecast API를 사용하였습니다. (링크 : https://openweathermap.org/forecast5)
