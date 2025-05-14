# movie_information_app
TMDB API를 기반으로 구현된 Flutter 영화 정보 앱입니다.

---

## 기술 스택

- Provider (상태 관리)
- Clean Architecture (Data, Domain, Presentation Layer 분리)
- HTTP 통신
- Hero 위젯을 활용한 디테일 화면 전환

---

## 주요 기능

- 현재 가장 인기있는 작품과 상영작, 인기작, 평점 높은 작품, 개봉 예정작 리스트 제공
- 영화 상세 페이지 제공 (줄거리, 장르, 개봉일, 런타임 등)
- Hero 위젯을 활용한 포스터 이미지 확대 애니메이션
- 인기순 섹션에 랭킹 숫자 표시


---
## 디렉토리 구조

lib/
├── data/
│   ├── datasource/
│   ├── dto/
│   ├── mapper/
│   └── repository/
├── domain/
│   ├── entity/
│   ├── repository/
│   └── usecase/
├── presentation/
│   ├── pages/
│   └── widgets/
