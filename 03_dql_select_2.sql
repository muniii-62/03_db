-- =============================
-- JOIN
-- =============================
-- 두개 이상의 테이블의 레코드를 연결해서 가상테이블(relation) 생성
-- 연관성을 가지고 있는 컬럼을 기준(데이터)으로 조합

# relation을 생성하는 2가지 방법
-- 1. join : 특정컬럼 기준으로 행과 행을 연결한다. (가로)
-- 2. union : 컬럼과 컬럼을 연결한다.(세로)
-- join은 두 테이블의 행사이의 공통된 데이터를 기준으로 **선을 연결해서** 새로운 하나의 행을 만든다.

# JOIN 구분
-- 1. Equi JOIN : 일반적으로 사용하는 Equality Condition(=)에 의한 조인
-- 2. Non-Equi JOIN : 동등조건(=)이 아닌 BETWEEN AND, IS NULL, IS NOT NULL, IN, NOT IN, !=  등으로 사용.

# EQUI JOIN 구분
-- 1. INNER JOIN(내부 조인) : 교집합 (일반적으로 사용하는 JOIN)
-- 2. OUTER JOIN(외부 조인) : 합집합
        -- LEFT (OUTER) JOIN (왼쪽 외부 조인)
        -- RIGHT (OUTER) JOIN (오른쪽 외부 조인)
-- 3. CROSS JOIN
-- 4. SELF JOIN(자가 조인)
-- 5. MULTIPLE JOIN(다중 조인)

/*
 Inner join(내부조인
 두 테이블의 교집합을 반환하는 SQL JOIN
 == 조인에 사용될 두 테이블의 특정 컬럼값이같은 행만 JOIN

 tbl_menu, tbl_category 두 ㅌ이블을 inner join
 조인 조건 : category값이같은 행 끼리 join
  */
# select a.menu_name,
#        a.menu_price,
#        b.category_name
# from tbl_menu A inner join tbl_category B on A.category_code = B.category_code
# order by a.menu_price desc;
# #메뉴명, 가격, 카테고리명 가격 내림차순 조회

/*
================================================================================
outer join
좌/우측 기준 테이블의 모든 행을 relation에 포함하는 join
left [outer] join
right [outer]join

 */
#
# insert into tbl_menu(menu_name, menu_price, category_code, orderable_status)
# values('초콜릿 덮밥', 10000, 7, 'Y');
#
# commit;
#
# select * from tbl_menu;

select
    emp_name, dept_code
from employee;

#department
select
    *
from
    department;

# empoyee 테이블과 depatment 테이블 inner join
# -> employee (23행), deprtment(9행)
# -> join 결과 : 21행
# -> 원인 : employee.dept_code 에 값이 없는 행(Null) 행
# 하동운, 이오리 두 해이 조인 결과 (rrelation) 포함되지않음

select
    a.EMP_ID,
    a.EMP_NAME,
    a.DEPT_CODE,
    b.DEPT_ID,
    b.DEPT_TITLE
from
    employee A
right outer join
department B
on
 A.dept_code = B.dept_id
order by EMP_ID asc;

# left outer join ##
# join구문 기준 왼쪽에 작성된 테이블의 모든 행이
# relation 에 포함되게 하기


# inner join  결과 21행+ department join 안된 2행 + -> 23행(left)
# inner join  결과 21행+ department join 안된 3행 + -> 24행(right)


/* menudb 계정
    cross join(카테시안 곱, 곱집합)
   조인 되는  두 테이블의 모든 경우의 수를 처리한 것
 */
select count(*) from tbl_menu; # 22행
select count(*) from tbl_category;# 12행
# 카테시안 곱 22* 12 = 264(행)

select count(*)
from tbl_menu
cross join tbl_category;

/*
self join
 하나의 테이블에서
한행이 다른 행을 참조하는 관계가 있는 경우
 같은 테이블 끼리 조인하는 것
 */
select * from tbl_category;
# 똑같은 테이블이 2개 있다고 생각해보자
select child.category_code,
       child.category_name,
       parent.category_name as '상위 카테고리'

from
    tbl_category child
join
    tbl_category parent
on
    child.ref_category_code = parent.category_code
where
    parent.category_name = '식사';
#예시에서는 어떤것의 하위 카테고리인지 파악 가능
# 같은 테이블 안에 계층 관계 (부모-자식)가 있을 때 주로 씀
# 조직도, 카테고리 트리, 댓글 대댓글 구조

  /*
multiple join(다중 조인)
3개 이상의 테이블을 조인하는 것
join 순서가 매우 중요함
ex)  a join b join c
-> (a+b) join c
-> (a+b+c)
   */
select * from tbl_order;
select * from tbl_order_menu;
select * from tbl_menu;

select
    *
from
    tbl_order o
join tbl_order_menu om
on
    o.order_code = om.order_code
# o,om이 합쳐진 relation 생성
join tbl_menu m
on m.menu_code = om.menu_code ;

#employeedb 로 변경

#
select * from employee;
select * from department;
select * from location;

select *
from employee e
join department d on e.DEPT_CODE = d.DEPT_ID
join location l on d.LOCATION_ID = l.LOCAL_CODE




-- ===================================
-- SUBQUERY
-- ===================================
-- 하나의 SQL문(main-query) 안에 포함되어 있는 또 다른 SQL문(sub-query)
-- 존재하지 않는 조건에 근거한 값들을 검색하고자 할때 사용.
-- 메인 쿼리가 서브 쿼리를 포함하는 종속적인 관계이다.
-- 메인 쿼리 실행중에 서브 쿼리를 실행해서 그 결과값을 다시 메인쿼리에 전달하는 방식이다.

# 서브쿼리(SUBQUERY) 유형
-- 1. 일반 서브쿼리
-- 2. 상관 서브쿼리
-- 3. 인라인뷰(파생테이블)

# 규칙
-- 서브쿼리는 반드시 소괄호로 묶어야 함 - (SELECT ... ) 형태
-- 서브쿼리는 연산자의 오른쪽에 위치 해야 함
-- 서브쿼리 내에서 order by 문법은 지원 안됨


# 1. 메뉴 테이블에서 '민트미역국'의 카테고리 코드 조뢰
select category_code
from tbl_menu
where menu_name = '민트미역국'; # 4

#2. 메뉴 테이블에서 카테고리 코드가 4인 메뉴 조회
select *
from tbl_menu
where category_code = 4;

# 메뉴테이블에서
# '민트 미역국'과 같은 카테고리의 메뉴를 조회

select *
from tbl_menu
where category_code = (
    select category_code
    from tbl_menu
    where menu_name = '민트미역국'
    )

# 메뉴 테이블에서
# '민트미역국'보다 비싼 메뉴를
# 가격 내림 차순으로 조회

select *
from tbl_menu
where menu_price > (
    select menu_price
    from tbl_menu
    where menu_name = '민트미역국'
    )
order by menu_price desc

/*
다중행 단일열 서브쿼리
서브쿼리가 여러 개의 값을 반환

카테고리 테이블에서
ref_catgory_code 값이1인 카테고리 코드를 찾아
메뉴 테이블에서 같은 카테고리의 메뉴를 모두 조회
 */
select menu_name, category_code
from tbl_menu
where category_code in (select category_code
 from tbl_category
 where ref_category_code =1);


# 상관 서브쿼리
# 상관서브쿼리 (상호연관)
-- 메인쿼리의 값을 서브쿼리에 주고 서브쿼리를 수행한 다음
-- 그 결과를 다시 메인쿼리로 반환하는 방식으로 수행되는 서브쿼리

-- 서브쿼리의 WHERE 절 수행을 위해서는 메인쿼리가 먼저 수행되는 구조
-- 메인쿼리 테이블의 레코드(행)에 따라 서브쿼리의 결과값도 바뀜
-- 메인 쿼리에서 처리되는 각 행의 컬럼값에 따라 응답이 달라져야 하는 경우에 유용

# 구분
-- 메인쿼리에 있는 것을 서브쿼리에서 가져다 쓰면 상관 서브쿼리 (블럭 잡아 단독으로 실행할수 없다.)
-- 그렇지 않고 서브쿼리가 독단적으로 사용이 되면 일반 서브쿼리

# 카테고리별 가장 비싼 메뉴 조회
#1. 4번 카테고리 메뉴 중 가장 비싼 메뉴조회

select max(menu_price)
from tbl_menu
where category_code =4;

#2. 카테고리별 가장 비싼 메뉴 조회
select *
from tbl_menu as main
where menu_price = (
    select max(menu_price)
    from tbl_menu as sub
    where sub.category_code =main.category_code
    );

# 카테고리별 평균 금액보다 비싼 메뉴만 조회
select *
from tbl_menu as main
where menu_price > (
    select avg(menu_price)
    from tbl_menu as sub
    where sub.category_code =main.category_code
    );

# 스칼라 서브쿼리
# select 절에서 사용하는 결과 값이 1개인 서브쿼리

select
    main.menu_name,
    category_code,
    (select sub.category_name
     from tbl_category sub
     where sub.category_code=main.category_code) category_name
from tbl_menu main;

### 인라인 뷰(INLINE VIEW) view: 읽기전용 가상 테이블
# FROM절에 작성된 서브쿼리
# 서브쿼리의 결과 집합(ResultSet)을 테이블 처럼 사용




select *
from (select menu_code,menu_name,category_name
    from tbl_menu m
    join tbl_category c on m.category_code = c.category_code) as menu_view
where category_name = '한식'


# 인라인뷰를 이용하여 기존 테이블의 컬럼명을 별칭으로 변경 가능하다.
# (원본 테이블 컬럼명 은닉)

select *
from (select m.menu_code as 메뉴코드, m.menu_name as 메뉴명, c.category_name as 카테고리명
    from tbl_menu m
    join tbl_category c on m.category_code = c.category_code) as menu_view
where 카테고리명 = '한식';

### CTE(Common Table Expression)
# 인라인뷰로 사용할 서브쿼리를 테이블 변수에 저장하고, 사용할 수 있게 한느 문법
/* [작성법]
 with 변수명 as (서브쿼리)
   select *
   from 변수명
 */


with menu_view as (select m.menu_code as 메뉴코드, m.menu_name as 메뉴명, c.category_name as 카테고리명
    from tbl_menu m
    join tbl_category c on m.category_code = c.category_code)

select *
from  menu_view
where 카테고리명 = '한식'