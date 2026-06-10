create user skn_ai@'%' identified by '1234';#계정을 만듬

#Mysql엥서는 database와 schema를 같은 의미로 사용
# - data (데이터 창고)
# - database(데이터 창고) == schema(창고 설계도, 명세서)
create database menudb;#데이터베이스(제이터 저장 공간(파일) 생성)
create schema employeedb; #스키마 생성

grant all privileges on menudb.* to skn_ai@'%'; #권한 부여

show databases;
grant all privileges on employeedb.* to skn_ai@'%';

show grants for skn_ai@'%'; # skn_ai 계정에 부여된 권한 목록 조회

