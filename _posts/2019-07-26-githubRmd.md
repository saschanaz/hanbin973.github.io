---
title: "Rmarkdown으로 Github Jekyll에 글쓰기"
author: "Hanbin Lee"
output: md_document
categories: 'R'
comments: true
---

R을 사용하시는 분들 중에 Github Pages를 사용하는 분들도 많을 것입니다. R
markdown을 사용하면 다양한 도표와 R 코드를 markdown에 손쉽게 삽입할 수
있습니다. 특히, output으로 html\_document를 지정하면 폴더를 github에
통째로 업로드 하는 것만으로 손쉽게 웹에 공개할 수 있습니다.

그러나 Jekyll Blog를 활용하는 경우에는 여러 어려움이 발생합니다.
ggplot2로 figure을 그리거나 외부 이미지를 문서에 삽입할 경우 출력물
markdown 문서에 기입된 경로와 실제 이미지 경로가 일치하지 않는 경우가
발생하기 때문입니다. 물론 수작업으로 어긋난 부분들을 고칠 수 있겠지만 R
markdown을 사용하는 것이 자동화로 인한 생산성 증가 때문이라는 점을
고려한다면 굉장히 피하고 싶은 일입니다.

저는 이 문제를 해결하기 위해서 짧은 스크립트를 하나 작성하였습니다. 이
글에서는 이 스크립트를 어떻게 활용하는지 알아보겠습니다.

폴더 구조
---------

제 [hanbin973.github.io](https://hanbin973.github.io)의 디렉토리는
다음과 같은 구조를 가졌습니다.

    ## -- _config.yml
    ## -- _data
    ##    |__navlist.yml
    ## -- _includes
    ##    |__mathjax_support.html
    ## -- _posts
    ##    |__2019-07-26-buss.md
    ## -- _Rmd
    ##    |__buss
    ##       |__assets
    ##          |__img
    ##             |__buss
    ##                |__unnamed-chunk-4-1.png
    ##       |__buss.bib
    ##       |__buss.Rproj
    ##       |__data.csv
    ##       |__img
    ##          |__corrbeta1.png
    ##          |__lippa1.png
    ##          |__lippa2.png
    ##          |__lippa2009.jpeg
    ##          |__nonprob.png
    ##       |__main.html
    ##       |__main.md
    ##       |__main.Rmd
    ## -- about.md
    ## -- assets
    ##    |__img
    ##       |__buss
    ##          |__unnamed-chunk-4-1.png
    ##    |__portfolio.png
    ## -- index.md
    ## -- make.R

이 글에서 중요한 폴더는 `_Rmd`, `_posts` 그리고 `assets` 입니다.
일반적으로 Jekyll에서는 `_posts`에 포스팅을 포함하고 `assets`에 이미지와
같은 파일들을 보관합니다. 이 글에서는 `_Rmd`에 담긴 Rmd 문서를
`make.R`라는 스크립트를 이용해 자동으로 markdown 문서는 `_posts`에,
이미지는 `assets`에 저장하는 방법을 설명하겠습니다.

코드
----

완성된 코드는 [제 저장소](https://github.com/hanbin973/githubRmd)에
있습니다. 홈페이지의 폴더구조를 위의 예시처럼 맞춘 뒤 `make.R`을
실행하면 됩니다. 코드에는 주석을 달아놓았으니 어렵지 않게 수정하실 수
있을 겁니다.

위의 `buss`라는 프로젝트를 기준으로 예시를 들면

1.  작성한 R markdown 문서와 (존재한다면) `.bib` 파일을 포함한 폴더를
    `_Rmd`에 넣습니다 (상단의 경우에는 `_Rmd/buss`).
2.  Rmd 파일에서 이미지의 경로는 `assets/img/{1.의 폴더명}/{이미지이름}`
    으로 지정합니다 (상단의 경우에는 `assets/img/buss/blah.png`).
3.  이제 루트 폴더에서 `make.R {_Rmd안에 있는 폴더명}` 을 실행합니다
    (상단의 경우에는 `make.R buss`).

Rmarkdown Template
------------------

Jekyll에 업로드될 문서는 적절한 YAML 정보를 요구합니다. 또, 위에서
살펴보았듯이 이미지 경로가 제대로 설정되기 위해서는 몇 가지 `knitr`
옵션들이 필요했죠. 글을 쓸 때마다 이 정보들을 일일이 기입하는 것은
굉장히 번거로운 일입니다. 이
[링크](http://ismayc.github.io/ecots2k16/template_pkg/)에는 R Studio에서
사용가능한 Rmd template을 만드는 법을 다루고 있습니다. 링크에 있는
`skeleton.Rmd`를 저는 다음과 같이 작성했습니다.

<script src="https://gist-it.appspot.com/github/hanbin973/githubRmd/blob/master/skeleton.Rmd"></script>
참고문헌
--------
