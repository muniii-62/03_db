/*
내장 함수
mysql dbms에 이미 구현된 함수
문자형, 숫자형, 날짜형별 함수가 따로 제공
반드시 반환값을 갖는다.
 */

 SELECT ASCII('A'), CHAR(65);

SELECT BIT_LENGTH('pie'), CHAR_LENGTH('pie'), LENGTH('pie');
SELECT menu_name,
       BIT_LENGTH(menu_name)
       , CHAR_LENGTH(menu_name),
         LENGTH(menu_name) from tbl_menu;
#문자 인코딩 : 컴퓨터에서 문자를 표시하는 방법
#UTF-8 : 아스키코드 문자는 1byte, 나머지는 3byte(my sql 차용)
#UTF-16 : 모든 문자를 2byte(16bit)로 표시

#INSTR(기준문자열, 부분(검색)문자열 :
# -기준 문자열에서 부분 문자열의 시작 위치 반환
select instr('사과딸기바나나','딸기');
select instr('사과딸기바나나','포도'); # 없기 ㄸ문에 결과값 0

# 메뉴 테이블에서 메뉴명에'마늘'이 포함된 메뉴만 조회
select
    *
from
    tbl_menu
where
#     menu_name like '%마늘%'
    instr(menu_name,'마늘') >0;

SELECT LPAD('왼쪽', 6, '@'), RPAD('오른쪽', 6 ,'@');

SELECT SUBSTRING('안녕하세요 반갑습니다.', 7, 2),
       SUBSTRING('안녕하세요 반갑습니다.', 7),
       substring('안녕하세요 반갑습니다.',instr('안녕하세요 반갑습니다.','반갑'))

# ceiling : 올림
# floor : 내림
# round L 반올림
select
    ceiling(1234.56),
    floor(1234.56),
    round(1234.56),
    truncate(1234.56,0);

select
    ceiling(-1.5),
    floor(-1.5),
    round(-1.5),
    truncate(-1.5,0);

select
    truncate(1234.56,1) as '1',
    truncate(1234.56,0) as '0',
    truncate(1234.56,-1) as '-1',
    truncate(1234.56,-2) as '-2';


select rand(),
       rand(),
       rand(),
       floor(rand());


select floor(rand()*45)+1; # 1 ~ 46

/*
#날짜 관련 함수
 */
# noe() :현재시간
# adddate(date,일수)
# subdate(date, 일수)
select now(),
       adddate(now(),1),
       subdate(now(),1),
       adddate(now(),interval 1 month),
       subdate(now(),interval 1 month);
# day month year 다 넣을 수잇다.

 #datediff 두 날짜 사이의 차이를 구하는 함수
 #timediff 시간1 시간2의 결과를 구함
select
    datediff('2026-11-20',now())

# extract(단위 from date)
# - date에서 해당하는 단위 추출
# - 단위: year, quarter, month,
#    week, day, hour, minute, second, microsecond

select
    now(),
    extract(year from now()),
    extract(month from now()),
    extract(day from now()); # 숫자 형태로 반환, 숫자 연산을 하기 쉬워진다






# date_format(datetime, 형식문자열) -> 문자열
select
    date_format(now(), '%y/%m/%d'),
    date_format(now(), '%Y/%m/%d'),
    date_format(now(), '%h:%i');

# str_to_date(문자열, 형식문자열) -> datetime
select
    str_to_date('25/04/21', '%y/%m/%d'),
    str_to_date('2025/04/21', '%Y/%m/%d'),
    cast('2025/04/21' as date); -- 날짜시간형식 유추가 가능한 경우

# 기타함수
# null처리 함수 - ifnull(값, null일때 값)
select
    ifnull(category_code, '미지정') category_code
from
    tbl_menu;

# 삼항연산처리 - if(조건식, 참일때 값, 거짓일때 값)
select
    isnull(category_code),
    if(isnull(category_code), '미지정', category_code) category_code
from
    tbl_menu;

select
    menu_name,
    menu_price,
    if(menu_price < 10000, '싼', '비싼') price_clf
from