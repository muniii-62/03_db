/*
 그룹 함수
 그룹의 통계를 반환하는 함수
 sum(),avg(), max(),min(), count()

# sum(컬럼)
 null(빈칸 상태)이 아닌 컬럼의 합
 select


 */


#sum
select
    sum(menu_price)
from
    tbl_menu;

#avg
select
    avg(menu_price)
from
    tbl_menu;

#카테고리 코드가 10인 메뉴의 평균 가격
#sum
select
    sum(menu_price)
from
    tbl_menu
where category_code = 10;


# 메뉴 가격 최대값, 최솟값
select
    max(menu_price) as 최댓값,
    min(menu_price) as 최소값
from tbl_menu;

# null과 연산을 수행하면 모든 결과가 null
select 1+null;

# 합겨ㅔ, 평균 -> 숫자 데이터 컬럼에만 적용 가능
# 최대, 최소 -> 숫자, 문자, 날짜 모두 사용 가능

select
    max(menu_name),
    min(menu_name)
from tbl_menu

# count(*|컬럼명) : 행의 개수를 조회
# count(*) : 모든 행(null 포함) 개수
#count(컬럼명) : 지정된 컬럼 값 중 null인 컬럼을 제외한 행의 개수

select
    count(*),
    count(ref_category_code)
from tbl_category;

/*
 group by
 지정된 컬럼 값이 일치하는 행을 그룹화(grouping) 시키는 구문
 */

select
     category_code,
     count(*),
     sum(menu_price),
     avg(menu_price),
     max(menu_price),
     min(menu_price)
 from tbl_menu
 group by
     category_code;


# group by 사용 시 주의 사항
# 1. null도 별도 그룹으로 묶임
# 2. select 절에는 group by 기준이 된 컬럼 + 그룹 함수만 작성 가능

select
    ref_category_code,
    # categor_name #그룹화 되지 않은 컬럼으로 인해 오류
from tbl_category
group by
    ref_category_code


# 그룹 내 하위 그룹 구성 가능
# 각 그룹에서 orderable_statue 가 같은 행 끼리 2차 그룹화
select category_code,
       orderable_status,
       count(*)
from tbl_menu
group by category_code,
         orderable_status
order by
    category_code asc


### group by + where : 필터링 된 행 중 컬럼값이 같은 행 그룹화
# where 지정된 테이블에서 행을 필터링
# goupby : 컬럼 값이 같은 행을 그룹화

#메뉴 테이블에서 카테고리별 개수, 합겨를 구하기
# 단, 메뉴 가격이 10000원 이상인 메뉴만

select category_code 그룹,
       count(*) 갯수,
       sum(menu_price) 합계
from tbl_menu
where menu_price >= 10000
group by category_code

#메뉴 테이블에서 주문이 가능한 메뉴
# 카테고리 코드가 4, 10 인 메뉴의 카테고리별 개수 조회

select c.category_name,
       count(*)
from tbl_menu m join tbl_category c on m.category_code = c.category_code
where m.category_code in (4,10)
and m.orderable_status = 'Y'
group by c.category_name;




/*
 having 절
 group by를 통해 만들어진 그룹에 대한 조건을 작성하는 구문
 having 절 작성 시 항상 그룹함수가 포함된다.
 */


 #메뉴 테이블에서 카테고리 별 메뉴 개수가 2개 이상인 카테고리의 카테고리 번호, 개수 출력

select category_code,
       count(*)
from tbl_menu
group by category_code
having
    count(*)>=2

# 카테고리 테이블에서 부모 카테고리(ref_category_code) 별로 갯수가 3개 이상인
# 부모카테고리 번호, 개수 조회
# 부모 카테고리 오름차순으로 조회

select
    ref_category_code,count(*)
from tbl_category
where ref_category_code is not null
group by
    ref_category_code
having
    count(*) >= 3
order by
    ref_category_code asc;



select
    ref_category_code,count(*)
from tbl_category
where ref_category_code is not null
group by
    ref_category_code
having
    count(*) >= 3
order by
    count(*) asc
limit 1;