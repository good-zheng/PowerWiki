# PowerWiki 문서

<div align="center">

<img src="../assets/powerwiki-logo.svg" alt="PowerWiki" width="360" />
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)
![Node](https://img.shields.io/badge/Node.js->=14-339933?style=for-the-badge&logo=node.js&logoColor=white)

Git 기반 마크다운 위키 시스템. 자동 동기화, 구문 하이라이팅, Feishu 스타일 UI 지원.

**🔗 온라인 데모: [https://powerwiki.ga666666.cn](https://powerwiki.ga666666.cn)**

[English](README.md) • [中文](README_ZH.md) • [日本語](docs/README_JA.md) • [한국어](README_KO.md) • [Español](docs/README_ES.md) • [Français](docs/README_FR.md) • [Deutsch](docs/README_DE.md) • [Русский](docs/README_RU.md)

</div>

---

## 언어 선택

다른 언어의 문서：

- [English](README.md)
- [中文](README_ZH.md)
- [日本語](README_JA.md)
- [한국어](README_KO.md)
- [Español](README_ES.md)
- [Français](README_FR.md)
- [Deutsch](README_DE.md)
- [Русский](README_RU.md)

## 특징

- **자동 동기화** - Git 리포지토리에서 문서를 자동으로 가져오고 업데이트
- **코드 하이라이팅** - 다양한 프로그래밍 언어 구문 하이라이팅 지원
- **반응형 디자인** - 모든 기기 화면에 완벽하게 적응
- **자동 목차** - 기사의 목차를 자동으로 생성
- **모던 UI** - 세련되고 직관적인 인터페이스
- **PDF 지원** - PDF 파일을 고해상도로 렌더링
- **방문 통계** - 기사의 조회수를 자동으로 통계
- **경량화** - 데이터베이스 불필요
- **SEO 최적화** - 검색 엔진 가시성을 전반적으로 최적화
- **Frontmatter 지원** - YAML 메타 정보 파싱
- **로컬 이미지** - Markdown에서 로컬 이미지 참조 지원
- **다국어** - 한국어와 영어 지원
- **Docker 지원** - 완전한 Docker 배포 지원

## 빠른 시작

### 전제 조건

- Node.js >= 14.0.0
- Git

### Docker 사용 (권장)

```bash
# 리포지토리 클론
git clone https://github.com/steven-ld/PowerWiki.git
cd PowerWiki

# 설정 파일 생성
cp config.example.json config.json
# config.json을 편집하여 Git 리포지토리 URL 설정

# Docker Compose로 시작
docker-compose up -d
```

### Node.js 사용

```bash
# 리포지토리 클론
git clone https://github.com/steven-ld/PowerWiki.git
cd PowerWiki

# 의존성 설치
npm install

# 설정 파일 생성
cp config.example.json config.json
# config.json을 편집하여 Git 리포지토리 URL 설정

# 서버 시작
npm start
```

브라우저에서 `http://localhost:3150`에 접근하세요.

## 설정

`config.json` 편집：

```json
{
  "gitRepo": "https://github.com/your-username/your-wiki-repo.git",
  "repoBranch": "main",
  "port": 3150,
  "siteTitle": "My Wiki",
  "siteDescription": "Knowledge Base",
  "autoSyncInterval": 180000,
  "pages": {
    "home": "README.md",
    "about": "ABOUT.md"
  }
}
```

| 옵션 | 설명 | 기본값 |
|------|------|--------|
| `gitRepo` | Git 리포지토리 URL | - |
| `repoBranch` | 브랜치 이름 | `main` |
| `mdPath` | 마크다운 파일 하위 디렉토리 | `""` |
| `port` | 서버 포트 | `3150` |
| `siteTitle` | 사이트 제목 | `PowerWiki` |
| `siteDescription` | 사이트 설명 | `Wiki` |
| `autoSyncInterval` | 자동 동기화 간격 (ms) | `180000` |
| `sortOrder` | 정렬 순서 (`modified` 또는 `name`) | `modified` |
| `pages.home` | 홈 페이지 파일 | `""` |
| `pages.about` | About 페이지 파일 | `""` |

## Docker 배포

### Docker 이미지

**[@sayunchuan](https://github.com/sayunchuan)** 이 PowerWiki의 Docker 이미지를 제공합니다.

- **이미지 이름**: `sayunchuan/powerwiki`
- **Docker Hub**: [sayunchuan/powerwiki](https://hub.docker.com/r/sayunchuan/powerwiki)
- **버전 태그**: `latest`, `1.4.5`, `20260207`

### 빠른 시작

```bash
# 가장 간단한 방법
docker run -d -p 3150:3150 sayunchuan/powerwiki

# 사용자 정의 설정 사용
docker run -d \
  --name powerwiki \
  -p 3150:3150 \
  -v $(pwd)/config.json:/app/config.json:ro \
  -v powerwiki_data:/app/data \
  -v powerwiki_cache:/app/cache \
  sayunchuan/powerwiki
```

### Docker Compose 배포

```yaml
version: '3.8'
services:
  powerwiki:
    image: sayunchuan/powerwiki:latest
    ports:
      - "3150:3150"
    environment:
      - NODE_ENV=production
      - LANG=ko
    volumes:
      - ./config.json:/app/config.json:ro
      - powerwiki_data:/app/data
      - powerwiki_cache:/app/cache
    restart: unless-stopped

volumes:
  powerwiki_data:
  powerwiki_cache:
```

```bash
# 서비스 시작
docker-compose up -d

# 로그 확인
docker-compose logs -f

# 서비스 중지
docker-compose down
```

**감사의 말**: [@sayunchuan](https://github.com/sayunchuan) 님께 감사드립니다. PowerWiki의 Docker 이미지를 제공하여 배포가 더욱 편리해졌습니다.

## 기사 구성

PowerWiki는 기사를 구성하기 위한 계층적 폴더 구조를 지원：

```
your-wiki-repo/
├── README.md              # 홈 페이지
├── ABOUT.md               # About 페이지
├── images/                # 글로벌 이미지 (선택 사항)
├── Architecture/          # 카테고리 폴더
│   ├── images/            # 카테고리 이미지
│   ├── IoT-Device-Standards.md
│   ├── TLS-Encryption.md
│   └── README.md          # 카테고리 인덱스
└── Projects/              # 또 다른 카테고리
    ├── images/
    ├── URL-Shortener.md
    └── README.md
```

### 기사의 Frontmatter

각 기사에는 YAML frontmatter 메타데이터를 포함할 수 있습니다：

```yaml
---
title: 기사 제목
description: SEO용 기사 설명
author: 저자 이름
date: 2026-01-10
updated: 2026-01-10
keywords: 키워드1, 키워드2, 키워드3
tags: [태그1, 태그2]
---
```

## 기술 스택

- **백엔드**: Express.js
- **프론트엔드**: Vanilla JavaScript
- **Git**: simple-git
- **Markdown**: marked + highlight.js
- **PDF**: pdfjs-dist
- **컨테이너화**: Docker

## 프로젝트 구조

```
PowerWiki/
├── src/                     # 소스 코드
│   ├── index.js             # Express 서버 진입점
│   ├── routes/              # 라우트 모듈
│   │   ├── api.js           # API 라우트
│   │   ├── feeds.js         # RSS/Sitemap 라우트
│   │   └── static.js        # 정적 파일 라우트
│   ├── config/              # 설정 모듈
│   │   ├── env.js           # 환경 변수
│   │   └── i18n.js          # 국제화
│   └── utils/               # 유틸리티 모듈
│       ├── cacheManager.js  # 캐시 관리
│       ├── gitManager.js    # Git 작업
│       └── markdownParser.js# 마크다운 파서
├── locales/                 # 번역 파일
├── templates/               # HTML 템플릿
├── public/                  # 정적 자산
│   ├── index.html          # 프론트엔드 HTML
│   ├── app.js             # 메인 엔트리 (모듈식)
│   ├── js/                # JavaScript 모듈
│   │   ├── theme.js       # 테마 관리
│   │   ├── i18n.js        # 국제화
│   │   ├── cache.js       # 클라이언트 캐싱
│   │   ├── utils.js       # 유틸리티
│   │   ├── posts.js       # 게시물 목록 및 트리
│   │   ├── article.js     # 기사 렌더링
│   │   ├── toc.js         # 목차 생성
│   │   └── media.js       # 코드 복사, 이미지 뷰어, PDF
│   └── css/               # CSS 모듈
│       ├── base.css       # 기본 스타일 및 변수
│       ├── layout.css     # 레이아웃
│       ├── sidebar.css    # 내비게이션 메뉴
│       ├── article.css    # 기사 및 마크다운
│       ├── toc.css        # 오른쪽 목차 바
│       ├── media.css      # 반응형 설계
│       └── components.css # UI 컴포넌트
├── config.example.json      # 설정 템플릿
└── package.json             # 종속성
```

## 라이선스

MIT License - [LICENSE](LICENSE) 참조.

## 기여자

- [@sayunchuan](https://github.com/sayunchuan) - 다국어, Mermaid 지원 추가, 다양한 문제 수정

---

<div align="center">

**이 프로젝트가 도움이 된다면, ⭐ Star를 눌러주세요!**

</div>
