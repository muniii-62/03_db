/*
set operators(집합 연산)
두 개 이상의 select 결과 (ResultSet)
union: 합집합
 */

 SELECT
    menu_code,
    menu_name,
    menu_price,
    category_code,
    orderable_status
FROM
    tbl_menu
WHERE
    category_code = 10
UNION
SELECT
    menu_code,
    menu_name,
    menu_price,
    category_code,
    orderable_status
FROM
    tbl_menu
WHERE
    menu_price < 9000;

#intersect:교집합
 SELECT
    menu_code,
    menu_name,
    menu_price,
    category_code,
    orderable_status
FROM
    tbl_menu
WHERE
    category_code = 10
intersect
SELECT
    menu_code,
    menu_name,
    menu_price,
    category_code,
    orderable_status
FROM
    tbl_menu
WHERE
    menu_price < 9000;

#union all :합집합 + 교집합
 SELECT
    menu_code,
    menu_name,
    menu_price,
    category_code,
    orderable_status
FROM
    tbl_menu
WHERE
    category_code = 10
UNION all
SELECT
    menu_code,
    menu_name,
    menu_price,
    category_code,
    orderable_status
FROM
    tbl_menu
WHERE
    menu_price < 9000;

#minus:
SELECT
    a.menu_code,
    a.menu_name,
    a.menu_price,
    a.category_code,
    a.orderable_status
FROM
    tbl_menu a
LEFT JOIN (SELECT
		menu_code,
		menu_name,
		menu_price,
		category_code,
		orderable_status
	FROM
		tbl_menu
	WHERE
		menu_price < 9000) b on (a.menu_code = b.menu_code)
WHERE
    a.category_code = 10 AND
    b.menu_code IS NULL;