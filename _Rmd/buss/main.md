이 문서는 *Sex differences in human mate preferences: Evolutionary
hypotheses tested in 37 cultures*(Buss 1989)을 다룹니다. 제목처럼 37개
문화권에서 성별 간 Mate preference의 차이를 측정하는 연구입니다. Mate
preference에 대한 복수의 기준에 대해 여러 문화권에서 동일한 결과를
관찰했고 이를 바탕으로 Mate preference에 대한 유전적/진화적 근거가
있다는 것이 논문의 결론입니다.

이전에 페이지의 글(현재 페이지는 삭제되어 링크가 없습니다)에서 이 논문에
존재하는 다중비교 문제를 거론한 적이 있는데 전중환 교수님께서 친절하게
[반론](https://darwin.tistory.com/2)을 남겨주셨습니다.

이 글은 전 교수님의 반론에 대한 재반론입니다.

귀무가설
--------

교수님의 글에 충분한 설명이 되어 있지만 이 연구의 결론과 함께 정확한
귀무가설이 무엇인지 밝히고 가겠습니다. 이 연구는 총 37개의 문화권과
5개의 종속변수에 대해 남녀 간의 평균 차이를 비교하고 있습니다. 따라서
*μ*<sub>*i*, *j*, *k*</sub>를 *i*-번째 문화권, *j*-번째 종속변수의
*k*-번째 성별의 평균값이라고 하면 다음의 귀무가설을 채택하고 있음을 알
수 있습니다.

*μ*<sub>*i*, *j*, 1</sub> = *μ*<sub>*i*, *j*, 2</sub> (*i* = 1, …, 37 *a**n**d* *j* = 1, …, 5)

그런데 이 연구의 귀무가설은 이걸로 끝이 아닙니다. 논문의 Conclusion은
다음과 같이 밝히고 있습니다.

> What do these results reveal about human reproductive history? They
> support the hypothesis that males and females have faced different
> constraints on reproductive success in our evolutionary past.

즉, 서두에서 밝혔던 것처럼 이 연구는 Mate preference의 차이가 진화의
산물이므로 다른 문화권 사이에서 진화적인 상관관계(correlation)가
존재한다는 것을 증명하고 싶어합니다. 따라서 해당 연구의 귀무가설은 첫
번쨰 귀무가설과 더불어 각 집단의 성차가 '독립적'이라는 내용을
포함합니다. 그 결과, 관찰된 결과가 독립이라는 귀무가설 하에서는 너무
낮은 확률의 일이기 때문에 귀무가설을 기각할 수 밖에 없다는 것이 연구의
흐름이 됩니다.

재반론
------

전 교수님의 주장을 [반론](https://darwin.tistory.com/2)에서 그대로
가져오면

> 요약하겠습니다. 이 의대생이 이야기하는 다중비교는 한 데이터 집합에
> 대하여 메인가설이 일단 받아들여진 다음에 다수의 사후검증을 할 때
> 본페로니 보정들을 해야 한다는 것입니다. 반면에 Buss(1989)는 한 가설을
> 한 나라에서만 검증한게 아니라 37개의 문화권에서 검증한 다음 이를
> 취합한 결과를 보고한 것입니다. 즉 37개의 데이터 집합들을 비교한
> Buss(1989)의 연구에 대해 엉뚱한 비판을 하는 것 뿐입니다.

입니다. 만약, Buss가 주장하고 싶었던 것이 '어떤 나라에서는 성차가
발견되고 어떤 나라에서는 그렇지 않다' 였다면 이 주장은 유효합니다.
하지만 논문에서 Buss가 지속적으로 밝히고 있는 것처럼 이 논문은 '이
차이가 진화적 근원을 갖고 있다' 입니다. 따라서 두 번쨰 귀무가설을 함께
고려해야하며 그 경우 다중비교를 반드시 적용할 수 밖에 없는 것입니다.

그러나 우회로를 이용하면 전 교수님의 주장이 유효한 상황을 만들 수
있습니다. 전 교수님 말씀처럼 문자 그대로 연구들을 '취합'하는 것입니다.
바로 메타 분석(Meta Analysis)죠.

Buss의 논문에는 각 estimate의 샘플수, 평균값(mean)과 표준오차(standard
error)을 모두 기재했기 때문에 37개 문화권의 결과들을 독립적인 연구의
결론으로 보고 메타 분석을 통해 취합할 수 있습니다. 물론 이렇게 되면
'진화적 가설'과는 전혀 상관 없는 연구가 되지만 한 번 해보는 건 의미가
있겠죠. 그럼 제가 직접 해볼테니 한 번 보시죠.

메타분석
========

메타분석에 사용한 라이브러리는 R *pwr*과 *meta*입니다. 그리고 늘
그렇듯이 분석 편의상 *tidyverse* 관련 패키지도 로딩하고 사용했습니다.
분석에 사용된 estimate에 대한 모든 정보는 논문에 기재된 것을 그대로
따랐습니다. 사용한 데이터와 코드는 모두 github에 올려뒀기 때문에 모든
분들이 원하시면 직접 재현해볼 수 있도록 하였습니다.

Descriptive Statistics
----------------------

#### 데이터 정보

    # 데이터 읽기
    data <- read_csv('data.csv')

    ## Parsed with column specification:
    ## cols(
    ##   `Culture#` = col_integer(),
    ##   N1 = col_integer(),
    ##   N2 = col_integer(),
    ##   Analysis = col_character(),
    ##   m.mean.t3 = col_double(),
    ##   m.sd.t3 = col_double(),
    ##   w.mean.t3 = col_double(),
    ##   w.sd.t3 = col_double()
    ## )

    # 결과 출력
    print(data)

    ## # A tibble: 37 x 8
    ##    `Culture#`    N1    N2 Analysis m.mean.t3 m.sd.t3 w.mean.t3 w.sd.t3
    ##         <int> <int> <int> <chr>        <dbl>   <dbl>     <dbl>   <dbl>
    ##  1          1   117    55 t             2.25    0.67      2.61    0.56
    ##  2          2    47    81 t             1.73    0.65      2.16    0.7 
    ##  3          3    52    48 t             2.41    0.8       2.1     0.73
    ##  4          4    70    49 t             1.97    0.85      2.14    0.75
    ##  5          5   265   235 t             2.22    0.62      2.63    0.59
    ##  6          6   103   144 t             1.79    0.73      2.44    0.76
    ##  7          7    88    55 t             1.97    0.81      2.29    0.62
    ##  8          8    28    27 t             2.68    0.73      2.81    0.48
    ##  9          9   205   268 t             1.78    0.93      2.43    0.71
    ## 10         10    54    55 t             2.28    0.6       2.58    0.71
    ## # ... with 27 more rows

샘플수는 남성 4601명, 여성 5446명으로 이뤄졌으며 총원의 중간값은 172명,
모든 분석은 t-검정을 적용했습니다.

#### P-hacking의 증거?

먼저 Table 3 결과들의 사후 검정력을 계산했습니다.

    # post-hoc power 계산
    p.power <- function(m1, sd1, n1, m2, sd2, n2, sig.level){
      sd <- sqrt((sd1*sd1+sd2*sd2)/2)
      d <- (m1-m2)/sd
      print(d)
      power <- pwr.t2n.test(n1=n1,n2=n2,d=d,sig.level=sig.level)$power
      return(power)
    }

    data <- data %>% mutate(ppwr = p.power(m.mean.t3, m.sd.t3, N1, w.mean.t3, w.sd.t3, N2, 0.05))

    ##  [1] -0.58303896 -0.63660056  0.40480531 -0.21208617 -0.67747776
    ##  [6] -0.87230643 -0.44365352 -0.21043148 -0.78564551 -0.45640905
    ## [11] -0.65399654 -0.91905603 -0.64185694 -0.22540468 -0.46335078
    ## [16] -0.59902280 -0.35082321 -0.29199352 -0.15563430 -0.32193360
    ## [21] -0.57527400 -0.36163931 -0.43837673 -0.53093033 -0.15631482
    ## [26] -0.11761451  0.04742453 -0.09150131 -0.81427393 -0.41596570
    ## [31] -0.93668960 -0.41323289 -0.58266647 -0.47137338 -0.64903674
    ## [36]  0.14171197 -0.28971439

    med.pwr <- median(data %>% pull(ppwr))
    prt <- paste('사후 검정력 중간값:',med.pwr,', ','실제 성공률:',as.character(29/37),sep="")
    print(prt)

    ## [1] "사후 검정력 중간값:0.749037723778365, 실제 성공률:0.783783783783784"

단일 연구에 대한 사후검정력 평가는 큰 의미를 가지지 않지만 메타 분석에서
사후 검정력을 평가하는 것은 일련의 편향(Bias)를 평가함에 있어 중요한
도구가 됩니다(Schimmack 2016). 검정력보다 실제 검정의 성공률이 더 높다는
것은 연구의 신뢰도가 떨어짐을 의미합니다(75% &lt; 78%).

다음으로 Table 3 결과들의 z-score을 계산했습니다.

    # z-score 계산 함수
    zscore <- function(m1, sd1, n1, m2, sd2, n2){
      z <- (m1-m2)/sqrt(sd1*sd1/n1 + sd2*sd2/n2)
      return(z)
    }

    # zscore 계산
    data <- data %>% mutate(z3 = zscore(m.mean.t3, m.sd.t3, N1, w.mean.t3, w.sd.t3, N2))

    # zscore 히스토그램
    plot <- ggplot(data, aes(x=z3)) + geom_histogram(color='black', fill='white', binwidth=0.2) + geom_vline(xintercept=-1.96, linetype='dashed', color='red', size=1) + geom_vline(xintercept=-3.7, linetype='dashed', color='red', size=1) +xlab('z-score of Table 3') + ylab('Frequency')
    plot

![](assets/img/buss/unnamed-chunk-4-1.png)

보시다시피 *Z* = −1.96과 *Z* = −3.7 부근에서 분포의 절벽이 두 개
발견됩니다(빨간점선). 만약 통상적인 메타 분석이었다면 *Z* = −1.96의
절벽은 출판편향 (Publication Bias)의 증거로 볼 수 있겠으나 이 연구는
37개 문화권에 대한 결과를 모두 보고하고 있으므로 출판편향의 가능성은
배제됩니다. 그렇다면 이는 P-hacking의 증거로 볼 수 밖에 없는데
어중간하게 유의성 기준(*Z* = −1.96)에 못 미치는 데이터에 뭔가 손을 대서
기준선을 넘겼다는 것이니까요. 두 번째 절벽은 이 가능성을 추가적으로
뒷받침합니다. 데이터 마사지를 통해 데이터를 건드리면 유의성 기준 넘어
일정 구간에 z-score이 많이 분포하게 됩니다. 그 결과 두 번째 절벽이
등장하는 것이죠.

마지막으로 등분산성을 확인했습니다.

    # z-score 계산 함수
    eqvar <- function(sd1, n1, sd2, n2){
      fstat <- sd1*sd1/(sd2*sd2)
      f.pvalue <- pf(fstat, n1-1, n2-1, lower.tail=F)
      return(f.pvalue)
    }

    # zscore 계산
    data <- data %>% mutate(eqvar = eqvar(m.sd.t3, N1, w.sd.t3, N2))
    vec <- data %>% pull('eqvar') < 0.05
    print(sum(as.numeric(vec))/length(vec)*100)

    ## [1] 21.62162

21%의 검정이 등분산성을 만족하지 않습니다. 이런 상황에서 등분산성을
가정하면 false positive가 증가한다는 것이 알려져 있습니다. Normality에
대한 얘기도 본문에 없으니 연구 결과를 더 보수적으로 해석할 수 밖에
없습니다. 만약 Normality도 깨져서 (이건 raw data가 없어서 현재로서는
확인불가) 비모수적 방법을 써야한다면 연구의 p-value들은 더 증가하겠죠.

맺음말
------

위의 세 가지 분석 결과를 종합하면 해당 연구를 신뢰할 수 없는 이유가
다중비교에만 있는 것은 아니라는 것입니다. 물론 다중비교도 중요한
문제지만요. 더 확인해보고 싶지만 Raw data가 없으니 어쩔 수 없네요.

나머지 테이블에 대해서는 손으로 옮겨야 하는 값이 수백 개라서 일단 Table
3에 대해서만 했습니다. 나중에 제가 시간이 남거나 다른 분께서 csv파일로
결과를 옮긴 파일을 제공해주시면 나머지 결과들에 대한 분석도
추가하겠습니다.

마지막으로, 글에서 굳이 개인의 자격요건을 따지시길래 저도 한 말씀만
올리겠습니다. 저는 통계관련 교과목으로 의대 학부 통계학, 학부 해석학,
대학원 실해석학, 수학과 확률과정론 및 확률미분방정식 그리고 통계학과
수리통계학을 모두 이수했고 대부분 A0나 A+ 받았습니다. 이 정도면 보편적인
통계학과 대학원에서 1학년이 이수하는 코스웍 수준인데 비-통계학과에서
이수하는 수준은 아득히 넘어선 것 같네요 ^^;;

참고문헌
--------

Buss, David M. 1989. “Sex Differences in Human Mate Preferences:
Evolutionary Hypotheses Tested in 37 Cultures.” *Behavioral and Brain
Sciences* 12 (01). Cambridge University Press (CUP): 1.
doi:[10.1017/s0140525x00023992](https://doi.org/10.1017/s0140525x00023992).

Schimmack, Ulrich. 2016. “A Revised Introduction to the R-Index.”
<https://wordpress.com/post/replication-index.wordpress.com/920>.
